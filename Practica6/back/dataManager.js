const mysql = require ('mysql');
const config = require ('./config.js');

const checkUserQuery = "SELECT idUsuario from Usuario where idUsuario=";
const randomBookQuery = "SELECT * FROM LibroRandom";
const insertPedidoQuery = "INSERT INTO Pedido(ISBN, idUsuario, idSesion) values ";
const ultimaSesionQuery = "SELECT * FROM UltimaSesion";
const insertSesionQuery = "INSERT INTO Sesion VALUES ()";
const updateUltimaSesionQuery = "UPDATE Sesion set fin=CURRENT_TIME() WHERE idSesion=(SELECT * FROM UltimaSesion)";
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

function insertOrder(user, isbn){
    selectQuery(ultimaSesionQuery, (results) => {
        const insert = insertPedidoQuery + "('" + isbn + "', '" + user + "', " + results[0].idSesion + ")";
        insertQuery(insert);
    });
}

function createNewSession() {
    let idSesion = 0;
    insertQuery(updateUltimaSesionQuery);
    insertQuery(insertSesionQuery);
    selectQuery(ultimaSesionQuery, (results) => {
        idSesion = results[0].idSesion;
    });
    return idSesion;
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