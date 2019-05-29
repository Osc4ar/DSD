const express = require('express');
const app = express();
const http = require('http').Server(app);
const path = require('path');
const backup = require('./backup');
const dataManager = require('./dataManager');
const bodyParser = require('body-parser');

const port = parseInt(process.argv[2]);

let servers = [
  {server: '10.0.0.19:'+port.toString(), clients: [], on: true}
];

let count = 0;
setInterval(() => count++, 2000);

if (port == 3000) {
  serverSocket();
} else {
  clientSocket();
}

function serverSocket() {
  const io = require('socket.io')(http);
  io.on('connection', (socket) => {
    socket.on('register', (hostInfo) => {
      servers.push(hostInfo)
      console.log('Conectando ' + socket.hostInfo.server);
      io.emit('status', servers);
    });
    socket.on('disconnect', (data) => {
      console.log('Desconectando ' + socket.hostInfo.server);
      oldServer = servers[socket.hostID];
      oldServer.on = false;
      newServer = getLessBusyServer();
      for (let index = 0; index < oldServer.clients.length; index++) {
        const client = oldServer.clients[index];
        newServer.clients.push(client);
      }
      oldServer.clients.splice(0, oldServer.clients.length);
      io.emit('status', servers);
    });
  });
}

function clientSocket() {
  //const serverHost = getLessBusyServer();
  const serverHost = '10.0.0.19:3000';
  const client = require('socket.io-client')('http://' + serverHost);
  client.emit('register', 1);
  client.on('status', (data) => {
    console.log(data);
  });
  client.on('disconnect', (data) => {
    console.log('Servidor desconectado');
  });
}

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
      dataManager.insertOrder(username, book.ISBN, time, count);
      backup.newOrder(username, book.ISBN, time, count, () => res.send('Error replicando nueva orden'));
      dataManager.selectQuery(dataManager.librosDisponiblesQuery, (results) => {
        book.ended = results.length == 1;
        res.json(book);
      });
    });
  });
}

app.get('/newServer', (req, res) => {
  const assignedServer = getAssignedServer(req.ip);
  if (assignedServer == null) {
    lessBusyServer = getLessBusyServer();
    lessBusyServer.clients.push(req.ip);
    console.log(servers);
    io.emit('status', servers);
    res.send({server: lessBusyServer.server});
  } else {
    res.send({server: assignedServer});
  }
});

function getAssignedServer(ip) {
  for (let index = 0; index < servers.length; index++) {
    const server = servers[index];
    if (server.clients.includes(ip)) {
      return server.server;
    }
  }
  return null;
}

function getLessBusyServer() {
  let min = 0;
  for (let index = 1; index < servers.length; index++) {
    const server = servers[index];
    if (server.on & server.clients.length < servers[min].clients.length) {
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
  console.log(JSON.stringify({
    'EVENTO': 'Replicando Operación',
    'OPERACION': 'Nueva Orden'
  }, null, 4));
  const queryCount = parseInt(req.query.count);
  if (queryCount > count) {
    console.log(JSON.stringify({
      'EVENTO': 'Contador Actualizado',
      'PREVIO': count,
      'NUEVO': queryCount+1
    }, null, 4));
    count = queryCount + 1;
  }
  dataManager.insertOrder(req.query.username, req.query.isbn, req.query.time, req.query.count);
  res.send('1');
});

app.get('/replicateAddNewSession', (req, res) => {
  console.log('Replicando operación');
  dataManager.createNewSession((idSesion) => res.send('1'));
});

setInterval(backup.sendBufferedOperations, 5000);

http.listen(port, () => console.log('Libreria iniciada en ' + port));