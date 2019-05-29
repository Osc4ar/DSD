const http = require('http');

let bufferedOperations = [];

function sendRequest(route, targets, errorHandler) {
    targets.forEach((target) => {
        hostInfo = target.server.split(':');
        console.log('Enviando backup a ' + JSON.stringify(target));
        const option = {
            host: hostInfo[0],
            port: hostInfo[1],
            path: route,
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        };
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

function addUser(username, ip, targets, errorHandler) {
    const route = '/replicateAddUser?username=' + username + '&ip=' + ip;
    sendRequest(route, targets, errorHandler);
}

function updateUser(username, ip, targets, errorHandler) {
    const route = '/replicateUpdateUser?username=' + username + '&ip=' + ip;
    sendRequest(route, targets, errorHandler);
}

function newOrder(username, isbn, time, count, targets, errorHandler) {
    const route = '/replicateNewOrder?username=' + username + '&isbn=' + isbn + '&time=' + time + '&count=' + count;
    sendRequest(route, targets, errorHandler);
}

function newSession(targets, errorHandler) {
    const route = '/replicateAddNewSession';
    sendRequest(route, targets, errorHandler);
}

module.exports = {
    addUser: addUser,
    newOrder: newOrder,
    newSession: newSession,
    updateUser: updateUser,
    sendBufferedOperations: sendBufferedOperations
}