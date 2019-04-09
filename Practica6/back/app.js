const express = require('express');
const app = express();
const http = require('http').Server(app);
const path = require('path');
const backup = require('./backup');
const dataManager = require('./dataManager');
const bodyParser = require('body-parser');

const port = 3000;

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
      dataManager.insertOrder(username, book.ISBN);
      backup.newOrder(username, book.ISBN, () => res.send('Error replicando nueva orden'));
      dataManager.selectQuery(dataManager.librosDisponiblesQuery, (results) => {
        book.ended = results.length == 1;
        res.json(book);
      });
    });
  });
}

app.get('/replicateAddUser', (req, res) => {
  dataManager.insertUser(req.query.username, req.query.ip);
  res.send('1');
});

app.get('/replicateUpdateUser', (req, res) => {
  dataManager.updateUser(req.query.username, req.query.ip);
  res.send('1');
});

app.get('/replicateNewOrder', (req, res) => {
  dataManager.insertOrder(req.query.username, req.query.isbn);
  res.send('1');
});

app.get('/replicateAddNewSession', (req, res) => {
  dataManager.createNewSession((idSesion) => res.send('1'));
});

http.listen(port, () => console.log('Libreria iniciada en 3000'));