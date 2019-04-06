const express = require('express');
const path = require('path');
const app = express();
const router = express.Router();
const port = 8080;

router.get('/', (req, res) => res.send('Frontend de libreria'));

router.get('/usuario', (req, res) => {
	res.sendFile(path.join(__dirname + '/views/usuario.html'));
});

router.get('/coordinador', (req, res) => {
    res.sendFile(path.join(__dirname + '/views/coordinador1.html'));
});

app.use('/', router);
app.use('/public', express.static(__dirname + '/public'));
app.listen(port, () => console.log('App listening on port 8080!'));
