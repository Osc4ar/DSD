const mysql = require ('mysql');
const config = require ('./config.js');

const checkUserQuery = "SELECT idUsuario from Usuario where idUsuario=";
const randomBookQuery = "SELECT * FROM LibroRandom";
const insertPedidoQuery = "INSERT INTO Pedido(ISBN, idUsuario, idSesion) values ";
const ultimaSesionQuery = "SELECT * FROM UltimaSesion";
const librosDisponiblesQuery = "SELECT * FROM LibrosDisponibles";
const coordinadorQuery = "SELECT * FROM Coordinador order by fecha DESC";
const updateIPQuery = "UPDATE Usuario set IP=";

function connect() {
    let connection = mysql.createConnection(config);
    connection.connect((err)=> {
        if (err) {
            return console.error('Error: ' + err.message);
        }
        console.log('Conectado a la base de datos');
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
        console.log('Dato insertado: ' + query);
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

function checkUserRegistered(idUsuario) {
    const select = "SELECT idUsuario from Usuario where idUsuario='" + idUsuario + "'";
    var registered = false;
    selectQuery(select, (results) => {
        registered = results.length != 0;
    });
}

function insertOrder(user, isbn){
    selectQuery(ultimaSesionQuery, (results) => {
        const insert = insertPedidoQuery + "('" + isbn + "', '" + user + "', " + results[0].idSesion + ")";
        insertQuery(insert);
    });
}

function getActiveSession() {
    const sql = 'select * from UltimaSesion';
    selectQuery(sql);
}

module.exports = {
    insertUser: insertUser,
    checkUserRegistered: checkUserRegistered,
    selectQuery: selectQuery,
    insertOrder: insertOrder,
    getActiveSession: getActiveSession,
    checkUserQuery: checkUserQuery,
    randomBookQuery: randomBookQuery,
    insertQuery: insertQuery,
    librosDisponiblesQuery: librosDisponiblesQuery,
    insertPedidoQuery: insertPedidoQuery,
    ultimaSesionQuery: ultimaSesionQuery,
    coordinadorQuery: coordinadorQuery,
    updateUser: updateUser
};