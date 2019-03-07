const http = require('http');

function sendRequest(route) {
    const options = {
        host: '127.0.0.1',
        port: '6666',
        path: route,
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    };
    const req = http.request(options, (res) => {
        res.on('data', (data) => {
            if (data != '1') {
                console.log('Error en respaldo');
            }
        });
    });
    req.end();
}

function sendUser(id, ip) {
    sendRequest('/addUser?id=' + id + '&ip=' + ip);
}

module.exports = {
    sendUser: sendUser
}