const express = require('express');
const app = express();
const http = require('http').Server(app);
const path = require('path');
const backup = require('./backup');
const dataManager = require('./dataManager');
const bodyParser = require('body-parser');

const port = parseInt(process.argv[2]);

const reset = "\x1b[0m";
const fgRed = '\x1b[31m';
const fgGreen = '\x1b[32m';
const fgYellow = '\x1b[33m';
const fgBlue = '\x1b[34m';
const fgMagenta = '\x1b[35m';
const fgCyan = '\x1b[36m';

const io = require('socket.io')(http);

let servers = [
  {server: '10.0.0.19:'+port.toString(), clients: []}
];

let count = 0;
setInterval(() => count++, 2000);

if (process.argv.length > 3) {
  const host = process.argv[3];
  clientSocket(host);
} else {
  serverSocket();
}

function serverSocket() {
  io.on('connection', (socket) => {
    socket.on('register', (hostInfo) => {
      socket.hostInfo = hostInfo;
      servers.push(hostInfo);
      console.log('\n> Servidor ' + fgYellow + socket.hostInfo.server + fgGreen + ' conectado'+reset);
      logServers();
      io.emit('status', servers);
    });
    socket.on('disconnect', (data) => {
      console.log('\n> Servidor ' + fgYellow + socket.hostInfo.server + fgRed + ' desconectado' + reset);
      reallocateClients(socket.hostInfo);
      io.emit('status', servers);
      logServers();
    });
  });
}

function clientSocket(host) {
  const serverHost = host;
  const client = require('socket.io-client')('http://' + serverHost);
  client.emit('register', servers[0]);
  client.on('status', (data) => {
    servers = data;
    logServers();
  });
  client.on('disconnect', (data) => {
    console.log(fgRed + '\n> Servidor principal desconectado' + reset);
    exMainServer = findServer(host);
    reallocateClients(exMainServer);
    serverSocket();
    console.log('\n> Servidor convertido a servidor principal');
  });
}

function reallocateClients(oldServer) {
  for (let i = 0; i < servers.length; i++)
    if (servers[i].server == oldServer.server)
      servers.splice(i, 1);
  newServer = getLessBusyServer();
  for (let index = 0; index < oldServer.clients.length; index++) {
    const client = oldServer.clients[index];
    newServer.clients.push(client);
  }
  oldServer.clients.splice(0, oldServer.clients.length);
}

function findServer(host) {
  for (let i = 0; i < servers.length; i++)
    if (servers[i].server == host)
      return servers[i];
  return ;
}

function logServers() {
  console.log('\n> Servidores conectados: ' + fgMagenta + servers.length + reset);
  for (let i = 0; i < servers.length; i++) {
    console.log('\t[' + (i+1).toString() + '] ' + fgYellow + servers[i].server + reset);
    console.log('\t\t Clientes: ' + fgMagenta + servers[i].clients.length + reset);
    for (let j = 0; j < servers[i].clients.length; j++)
      console.log('\t\t\t[' + (j+1).toString() + '] ' + fgBlue + servers[i].clients[j] + reset);
  }
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

function getTargetServers() {
  let targetServers = [];
  for (let i = 0; i < servers.length; i++) {
    if (servers[i].server.split(':')[1] != port.toString())
      targetServers.push(servers[i]);
  }
  return targetServers;
}

app.get('/newSession', (req, res) => {
  dataManager.createNewSession((idSesion) => {
    const targets = getTargetServers();
    backup.newSession(targets, () => res.send('Error replicando nueva sesión'));
    response = {idSesion: idSesion};
    console.log('\n> Sesión ' + fgCyan + idSesion + reset + ' iniciada')
    res.send(response);
  });
});

app.get('/newBook', (req, res) => getNewBook(req, res));

function getNewBook(req, res) {
  const username = req.query.username;
  const time = req.query.time;
  const targets = getTargetServers();
  let query = dataManager.checkUserQuery + "'"+ username + "'";
  dataManager.selectQuery(query, (results) => {
    const registered = results.length != 0;
    if (!registered) {
      dataManager.insertUser(username, req.ip);
      backup.addUser(username, req.ip, targets, () => res.send('Error replicando nuevo usuario'));
    } else {
      if (req.ip != results[0].IP) {
        dataManager.updateUser(username, req.ip);
        backup.updateUser(username, req.ip, targets, () => res.send('Error replicando actualización de usuario'));
      }
    }
    dataManager.selectQuery(dataManager.randomBookQuery, (results) => {
      let book = results[0];
      dataManager.insertOrder(username, book.ISBN, time, count);
      backup.newOrder(username, book.ISBN, time, count, targets, () => res.send('Error replicando nueva orden'));
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
    logServers();
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
    if (server.clients.length < servers[min].clients.length) {
      min = index;
    }
  }
  return servers[min];
}

app.get('/replicateAddUser', (req, res) => {
  console.log('\n> Replicando operación: ' + fgRed + 'Agregar Usuario' + reset);
  dataManager.insertUser(req.query.username, req.query.ip);
  res.send('1');
});

app.get('/replicateUpdateUser', (req, res) => {
  console.log('\n> Replicando operación: ' + fgRed + 'Actualizar IP Usuario' + reset);
  dataManager.updateUser(req.query.username, req.query.ip);
  res.send('1');
});

app.get('/replicateNewOrder', (req, res) => {
  console.log('\n> Replicando operación: ' + fgRed + 'Nueva Orden' + reset);
  const queryCount = parseInt(req.query.count);
  if (queryCount > count) {
    console.log(fgGreen + '\n> Reloj lógico actualizado' + reset);
    console.log('\tValor previo: ' + fgCyan + count + reset);
    console.log('\tValor nuevo:  ' + fgCyan + (queryCount+1).toString() + reset);
    count = queryCount + 1;
  }
  dataManager.insertOrder(req.query.username, req.query.isbn, req.query.time, req.query.count);
  res.send('1');
});

app.get('/replicateAddNewSession', (req, res) => {
  console.log('\n> Replicando operación: ' + fgRed + 'Nueva Sesión' + reset);
  dataManager.createNewSession((idSesion) => res.send('1'));
});

setInterval(backup.sendBufferedOperations, 5000);

http.listen(port, () => console.log('> Libreria iniciada en puerto ' + fgCyan + port + reset));