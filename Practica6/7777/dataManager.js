const mysql = require ('mysql');
const config = require ('./config.js');

const checkUserQuery = "SELECT idUsuario from Usuario where idUsuario=";
const randomBookQuery = "SELECT * FROM LibroRandom";
const insertPedidoQuery = "INSERT INTO Pedido(ISBN, idUsuario, idSesion, fecha, Tiempo) values ";
const ultimaSesionQuery = "SELECT * FROM UltimaSesion";
const insertSesionQuery = "INSERT INTO Sesion VALUES ()";
const updateUltimaSesionQuery = "UPDATE Sesion set fin=CURRENT_TIME() WHERE idSesion=(SELECT * FROM UltimaSesion)";
const librosDisponiblesQuery = "SELECT * FROM LibrosDisponibles";
const coordinadorQuery = "SELECT * FROM Coordinador order by idPedido DESC";
const updateIPQuery = "UPDATE Usuario set IP=";

const reset = "\x1b[0m";
const fgRed = '\x1b[31m';
const fgBlue = '\x1b[34m';

function connect() {
    let connection = mysql.createConnection(config);
    connection.connect((err)=> {
        if (err) {
            return console.error(fgRed + '\n! Error: ' + err.message + reset);
        }
    });
    return connection;
}

function selectQuery(query, callback) {
    connection = connect();
    connection.query(query, (err, results) => {
        if (err) {
            throw err;
        }
        return callback(results);
    });
    connection.end();
}

function insertQuery(query) {
    connection = connect();
    connection.query(query, (err) => {
        if (err) {
            throw err;
        }
        console.log('\n> Query ejecutado:\n\t' + fgBlue + query + reset);
    });
    connection.end();
}

function insertUser(idUsuario, ip) {
    const insert = "INSERT INTO Usuario values ('"+ idUsuario + "', '" + ip + "')";
    insertQuery(insert);
}

function updateUser(idUsuario, ip) {
    query = updateIPQuery + "'" + ip + "' where idUsuario='" + idUsuario + "'";
    insertQuery(query);
}

function insertOrder(user, isbn, time, count){
    const formattedTime = formatTime(time);
    selectQuery(ultimaSesionQuery, (results) => {
        const insert = insertPedidoQuery + "('" + isbn + "', '" + user + "', " + results[0].idSesion + ", '" + formattedTime + "', "+ count +")";
        insertQuery(insert);
    });
}

function formatTime(time) {
    const timeComponents = time.split(':');
    const hours   = parseInt(timeComponents[0]);
    const minutes = parseInt(timeComponents[1]);
    const seconds = parseInt(timeComponents[2]);
    let date = new Date();
    date.setHours(hours, minutes, seconds);
    return date.toISOString().slice(0, 10) + ' ' + date.toString().slice(16, 24);
}

function createNewSession(sender) {
    insertQuery(updateUltimaSesionQuery);
    insertQuery(insertSesionQuery);
    selectQuery(ultimaSesionQuery, (results) => {
        idSesion = results[0].idSesion;
        sender(idSesion);
    });
}

module.exports = {
    insertUser: insertUser,
    updateUser: updateUser,
    insertOrder: insertOrder,
    createNewSession: createNewSession,
    insertQuery: insertQuery,
    selectQuery: selectQuery,
    checkUserQuery: checkUserQuery,
    randomBookQuery: randomBookQuery,
    librosDisponiblesQuery: librosDisponiblesQuery,
    insertPedidoQuery: insertPedidoQuery,
    ultimaSesionQuery: ultimaSesionQuery,
    coordinadorQuery: coordinadorQuery
};