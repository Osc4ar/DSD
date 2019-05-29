const http = require('http');

let bufferedOperations = [];

function sendRequest(route, errorHandler) {
    const options = [
        {
            host: '10.0.0.19',
            port: '3000',
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
        req.on('error', (err) => {
            bufferedOperations.unshift(option);
        });
        req.end();
    });
}

function sendBufferedOperations() {
    let index = bufferedOperations.length;
    while (index--) {
        const req = http.request(bufferedOperations[index], (res) => {
            res.on('data', (data) => {
                if (data != '1') {
                    errorHandler();
                } else {
                    bufferedOperations.splice(index, 1);
                }
            });
        });
        req.on('error', (err) => {  });
        req.end();
    }
}

function addUser(username, ip, errorHandler) {
    sendRequest('/replicateAddUser?username=' + username + '&ip=' + ip, errorHandler);
}

function updateUser(username, ip, errorHandler) {
    sendRequest('/replicateUpdateUser?username=' + username + '&ip=' + ip, errorHandler);
}

function newOrder(username, isbn, time, count, errorHandler) {
    sendRequest('/replicateNewOrder?username=' + username + '&isbn=' + isbn + '&time=' + time + '&count=' + count, errorHandler);
}

function newSession(errorHandler) {
    sendRequest('/replicateAddNewSession', errorHandler);
}

module.exports = {
    addUser: addUser,
    newOrder: newOrder,
    newSession: newSession,
    updateUser: updateUser,
    sendBufferedOperations: sendBufferedOperations
}