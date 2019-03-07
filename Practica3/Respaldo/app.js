const express = require('express')
const app = express()
const port = 6666

app.get('/', (req, res) => res.send('Respaldo'));

app.get('/addUser', (req, res) => {
    console.log('id: ' + req.query.id + ' ip: ' + req.query.ip);
    res.send('1');
});

app.listen(port, () => console.log('Respaldo iniciado'));