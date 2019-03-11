const express = require('express');
const app = express();
const http = require('http').Server(app);
const io = require('socket.io')(http);
const path = require('path');
const backup = require('./backup');
const dataManager = require('./dataManager');
const bodyParser = require('body-parser');

const port = 3000;

app.set('view engine', 'pug');
app.use('/public', express.static(path.join(__dirname, 'public')));
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

app.get('/sessionManager', (req, res) => {
  const username = req.query.username;
  dataManager.selectQuery(dataManager.ultimaSesionQuery, (results) => {
    const newSession = results[0].idSesion+1
    const query = dataManager.insertPedidoQuery + "('0', '" + username + "', " + newSession + ")";
    dataManager.insertQuery(query);
    backup.sendNewSessionOrder(username, newSession);
    res.send(''+newSession);
  });
});

app.get('/bookManager', (req, res) => insertLogic(req, res));

function insertLogic(req, res) {
  const username = req.query.username;
  let query = dataManager.checkUserQuery + "'"+ username + "'";
  dataManager.selectQuery(query, (results) => {
    const registered = results.length != 0;
    if (!registered) {
      dataManager.insertUser(username, req.ip);
      backup.sendUser(username, req.ip);
    } else {
      if (req.ip != results[0].IP) {
        dataManager.updateUser(username, req.ip);
        backup.sendUpdateUser(username, req.ip);
      }
    }
    dataManager.selectQuery(dataManager.randomBookQuery, (results) => {
      let book = results[0];
      dataManager.insertOrder(username, book.ISBN);
      backup.sendOrder(username, book.ISBN);
      dataManager.selectQuery(dataManager.librosDisponiblesQuery, (results) => {
        book.ended = results.length == 1;
        res.json(book);
      });
    });
  });
}

http.listen(port, () => console.log('Libreria iniciada'));

io.on('connection', (socket) => {
  setInterval(() => sendTime(socket), 1000)
});

function sendTime(socket) {
  currentDate = new Date()
  currentTime = formatTime(currentDate)
  socket.emit('time', { time: currentTime })
}

function formatTime(currentDate) {
  const hours = currentDate.getHours()
  const minutes = currentDate.getMinutes().toString().length == 1 ? '0' + currentDate.getMinutes() : currentDate.getMinutes()
  const seconds = currentDate.getSeconds().toString().length == 1 ? '0' + currentDate.getSeconds() : currentDate.getSeconds()
  return hours + ':' + minutes + ':' + seconds
}
