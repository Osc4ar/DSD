const express = require('express');
const app = express();
const http = require('http').Server(app);
const io = require('socket.io')(http);
const books = require('./books.json');
const dataManager = require('./dataManager');

const port = 3000;

app.set('view engine', 'pug');

app.get('/', (req, res) => {
  initUserData(req.ip);
  res.render('index');
});

app.post('/bookManager', (req, res) => {
  book = getBook(req.ip);
  res.json(book);
});

app.post('/sessionManager', (req, res) => {
  const userID = dataManager.getUserID(req.ip);
  dataManager.newSession(userID);
  const session = dataManager.getActiveSession(userID);
  res.send('' + session);
});

io.on('connection', (socket) => {
  setInterval(() => sendTime(socket), 1000)
});

http.listen(port, () => console.log('Libreria iniciada'));

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

function initUserData(ip) {
  let id = 0;
  if (dataManager.userIDs.length == 0) {
    id = 1;
    dataManager.insertUser(id, ip);
  }
  else {
    id = dataManager.userIDs[dataManager.userIDs.length-1] + 1;
    dataManager.insertUser(id, ip);
  }
  dataManager.userIDs.push(id);
  dataManager.insertSession(1, id);
  console.log(dataManager.users);
  console.log(dataManager.sessions);
}

function libraryContains(library, isbn) {
  for (let i = 0; i < library.length; i++) {
    if (library[i].ISBN == isbn) {
      return i;
    }
  }
  return -1;
}

function getBook(client) {
  let availableBooks = JSON.parse(JSON.stringify(books.library));
  const userID = dataManager.getUserID(client);
  const session = dataManager.getActiveSession(userID);
  const userOrders = dataManager.getActiveSessionOrders(userID);
  for (let i = 0; i < userOrders.length; i++) {
    const bookPosition = libraryContains(availableBooks, userOrders[i].isbn);
    if (bookPosition != -1) {
      availableBooks.splice(bookPosition, 1);
    }
  }
  if (availableBooks.length != 0) {
    const index = Math.floor(Math.random()*availableBooks.length);
    const book = availableBooks[index];
    dataManager.insertOrder(userID, session, book.ISBN);
    return book;
  }
  return {"ended": true};
}