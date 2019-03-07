let mysql = require ('mysql');
let config = require ('./config.js');

let connection = mysql.createConnection(config);
const backup = require('./backup');


function insertUser(id, ip) {
    let sql =   "INSERT INTO usuario (idUsuario, IP) values (id , ip )";

    connection.query(sql);
    connection.end();
}

function insertSession(id, user){
    let sql =   "INSERT INTO sesion values (id, user)";
                 

}

function insertOrder (user, session, isbn){
    let sql =   "INSERT INTO pedido values (idPedido, date, isbn, user, idSesion)";

}


function newSession(user) {
    activeSessionID = getActiveSession(user);
    deactivateSession(activeSessionID);
    let sql = "INSERT INTO sesion values (activeSessionID + 1, user )"
}


function getActiveSession(user){
    let sql =  "SELECT idSesion WHERE idUsuario =  user";
   
}

function getActiveSessionOrders(user){

}



function getActiveSession(user) {
    let id = 0;
    for (const session of sessions) {
        if (session.user == user && session.active == true) {
            id = session.id;
        }
    }
    return id;
}

function getAllActiveUsers() {
    let activeUsersID = [];
    for (const session of sessions) {
        if (session.active) {
            activeUsersID.push(session.user);
        }
    }
    return activeUsersID;
}

function getUserID(ip) {
    let id = 0;
    for (let user of users) {
        if (user.ip == ip) {
            id = user.id;
        }
    }
    return id;
}

function getLastOrder(user) {
    let lastOrder = {};
    for (const order of orders.reverse()) {
        if (order.user == user) {
            lastOrder = order;
        }
    }
    return lastOrder;
}

function getCoordinadorView() {
    activeUsers = getAllActiveUsers();
    lastOrders = [];
    for (const user of activeUsers) {
        lastOrders.push(getLastOrder(user));
    }
    return lastOrders;
}


module.exports = {
    insertUser: insertUser,
    insertSession: insertSession,
    insertOrder: insertOrder,
    newSession: newSession,
    getActiveSession: getActiveSession,
    getActiveSessionOrders: getActiveSessionOrders,
    getUserID: getUserID,
    getCoordinadorView: getCoordinadorView,
    users: users,
    userIDs: userIDs,
    sessions: sessions,
    orders: orders
};