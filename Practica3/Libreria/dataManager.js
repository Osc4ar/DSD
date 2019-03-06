let users = [];
let sessions = [];
let orders = [];

let userIDs = [];

function insertUser(id, ip) {
    users.push({"id": id, "ip": ip});
}

function insertSession(id, user) {
    sessions.push({"id": id, "user": user, "active": true});
}

function insertOrder(user, session, isbn) {
    orders.push({"user": user, "session": session, "isbn": isbn, "date": new Date()});
}

function getActiveSession(user) {
    let id = 0;
    for (let session of sessions) {
        if (session.user == user && session.active == true) {
            id = session.id;
        }
    }
    return id;
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
    for (let order of orders) {
        if (order.user == user && order.session == session) {
            userOrders.push(order);
        }
    }
    return userOrders;
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

module.exports = {
    insertUser: insertUser,
    insertSession: insertSession,
    newSession: newSession,
    getActiveSession: getActiveSession,
    getActiveSessionOrders: getActiveSessionOrders,
    getUserID: getUserID,
    insertOrder: insertOrder,
    users: users,
    userIDs: userIDs,
    sessions: sessions,
    orders: orders
};