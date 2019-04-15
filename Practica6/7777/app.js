const express = require('express');
const app = express();
const http = require('http').Server(app);
const path = require('path');
const backup = require('./backup');
const dataManager = require('./dataManager');
const bodyParser = require('body-parser');

const port = 7777;

let servers = [{server: '192.168.43.48:3000', clients: [], on: true}, {server: '192.168.43.48:7776', clients: [], on: false}, {server: '192.168.43.48:7777', clients: [], on: false}];

app.use('/public', express.static(path.join(__dirname, 'public')));
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});
app.set('view engine', 'pug');
app.use(bodyParser.json());

app.get('/', (req, res) => {
  res.render('index');
});

app.get('/coordinador', (req, res) => {
  if (req.ip === '::1') {
    dataManager.selectQuery(dataManager.coordinadorQuery, (results) => {
      res.render('coordinador', {
        orders: results
      });
    });
  } else {
    res.send('Acceso no autorizado');
  }
});

app.get('/newSession', (req, res) => {
  dataManager.createNewSession((idSesion) => {
    backup.newSession(() => res.send('Error replicando nueva sesión'));
    response = {idSesion: idSesion};
    console.log(response);
    res.send(response);
  });
});

app.get('/newBook', (req, res) => getNewBook(req, res));

function getNewBook(req, res) {
  const username = req.query.username;
  const time = req.query.time;
  let query = dataManager.checkUserQuery + "'"+ username + "'";
  dataManager.selectQuery(query, (results) => {
    const registered = results.length != 0;
    if (!registered) {
      dataManager.insertUser(username, req.ip);
      backup.addUser(username, req.ip, () => res.send('Error replicando nuevo usuario'));
    } else {
      if (req.ip != results[0].IP) {
        dataManager.updateUser(username, req.ip);
        backup.updateUser(username, req.ip, () => res.send('Error replicando actualización de usuario'));
      }
    }
    dataManager.selectQuery(dataManager.randomBookQuery, (results) => {
      let book = results[0];
      dataManager.insertOrder(username, book.ISBN, time);
      backup.newOrder(username, book.ISBN, time, () => res.send('Error replicando nueva orden'));
      dataManager.selectQuery(dataManager.librosDisponiblesQuery, (results) => {
        book.ended = results.length == 1;
        res.json(book);
      });
    });
  });
}

app.get('/newServer', (req, res) => {
  lessBusyServer = getLessBusyServer();
  lessBusyServer.clients.push(req.ip);
  socket.emit('status', servers);
  res.send({server: lessBusyServer.server});
});

function getLessBusyServer() {
  let min = 0;
  for (let index = 1; index < servers.length; index++) {
    const server = servers[index];
    if (server.clients.length < servers[min].clients.length) {
      min = index;
    }
  }
  return servers[min];
}

app.get('/replicateAddUser', (req, res) => {
  console.log('Replicando operación');
  dataManager.insertUser(req.query.username, req.query.ip);
  res.send('1');
});

app.get('/replicateUpdateUser', (req, res) => {
  console.log('Replicando operación');
  dataManager.updateUser(req.query.username, req.query.ip);
  res.send('1');
});

app.get('/replicateNewOrder', (req, res) => {
  console.log('Replicando operación');
  dataManager.insertOrder(req.query.username, req.query.isbn, req.query.time);
  res.send('1');
});

app.get('/replicateAddNewSession', (req, res) => {
  console.log('Replicando operación');
  dataManager.createNewSession((idSesion) => res.send('1'));
});

function clientSocket() {
  const serverHost = getLessBusyServer();
  const client = require('socket.io-client')('http://' + serverHost.server);
  client.emit('register', 2);
  client.on('status', (data) => {
    console.log(data);
  });
  client.on('disconnect', (data) => {
    console.log('Servidor desconectado');
  });
}
clientSocket();

setInterval(backup.sendBufferedOperations, 5000);

http.listen(port, () => console.log('Libreria iniciada en 7777'));