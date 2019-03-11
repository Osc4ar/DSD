const express = require('express');
const dataManager = require('./dataManager');
const app = express();
const port = 6666;

app.get('/', (req, res) => res.send('Backup'));

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

app.get('/addUser', (req, res) => {
    dataManager.insertUser(req.query.username, req.query.ip);
    res.send('1');
});

app.get('/updateUser', (req, res) => {
    dataManager.updateUser(req.query.username, req.query.ip);
    res.send('1');
});

app.get('/addOrder', (req, res) => {
    dataManager.insertOrder(req.query.username, req.query.isbn);
    res.send('1');
});

app.get('/addNewSessionOrder', (req, res) => {
    const query = dataManager.insertPedidoQuery + "('0', '" + req.query.username + "', " + req.query.session + ")";
    dataManager.insertQuery(query);
    res.send('1');
});


app.listen(port, () => console.log('Respaldo iniciado'));