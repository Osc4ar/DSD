const backup = require('./backup');

let users = [];
let sessions = [];
let orders = [];

let userIDs = [];

function insertUser(id, ip) {
    users.push({"id": id, "ip": ip});
    backup.sendUser(id, ip);
}

function insertSession(id, user) {
    sessions.push({"id": id, "user": user, "active": true});
}

function insertOrder(user, session, isbn) {
    orders.push({"user": user, "session": session, "isbn": isbn, "date": new Date()});
}

function deactivateSession(id) {
    for (let session of sessions) {
        if (session.id == id && session.active == true) {
            session.active = false;
        }
    }
}

function newSession(user) {
    activeSessionID = getActiveSession(user);
    deactivateSession(activeSessionID);
    sessions.push({"id": activeSessionID + 1, "user": user, "active": true});
}

function getActiveSessionOrders(user) {
    userOrders = []
    session = getActiveSession(user);
    for (const order of orders) {
        if (order.user == user && order.session == session) {
            userOrders.push(order);
        }
    }
    return userOrders;
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