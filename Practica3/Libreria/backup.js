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

function sendUser(username, ip) {
    sendRequest('/addUser?username=' + username + '&ip=' + ip);
}

function sendUpdateUser(username, ip) {
    sendRequest('/updateUser?username=' + username + '&ip=' + ip);
}

function sendOrder(username, isbn) {
    sendRequest('/addOrder?username=' + username + '&isbn=' + isbn);
}

function sendNewSessionOrder(username, session) {
    sendRequest('/addNewSessionOrder?username=' + username + '&session=' + session);
}

module.exports = {
    sendUser: sendUser,
    sendOrder: sendOrder,
    sendNewSessionOrder: sendNewSessionOrder,
    sendUpdateUser: sendUpdateUser
}