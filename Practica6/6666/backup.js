const http = require('http');

function sendRequest(route, errorHandler) {
    const options = [
        {
            host: '127.0.0.1',
            port: '3000',
            path: route,
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        },
        {
            host: '127.0.0.1',
            port: '7777',
            path: route,
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        }
    ];
    options.forEach((option) => {
        const req = http.request(option, (res) => {
            res.on('data', (data) => {
                if (data != '1') {
                    errorHandler();
                }
            });
        });
        req.end();
    });
}

function addUser(username, ip, errorHandler) {
    sendRequest('/replicateAddUser?username=' + username + '&ip=' + ip, errorHandler);
}

function updateUser(username, ip, errorHandler) {
    sendRequest('/replicateUpdateUser?username=' + username + '&ip=' + ip, errorHandler);
}

function newOrder(username, isbn, errorHandler) {
    sendRequest('/replicateNewOrder?username=' + username + '&isbn=' + isbn, errorHandler);
}

function newSession(errorHandler) {
    sendRequest('/replicateAddNewSession', errorHandler);
}

module.exports = {
    addUser: addUser,
    newOrder: newOrder,
    newSession: newSession,
    updateUser: updateUser
}
