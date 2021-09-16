// Permite tener conexión con la base de datos

// Importa la configuración para obtener ip y puerto donde está hosteada la DB
const config = require('./config');

// Clases importadas de la biblioteca para poder conectarse
const {Sequelize, DataTypes, QueryTypes} = require('sequelize');

// Función que permite conexión con el contenedor de docker y por ende MSSQL
const sequelize = new Sequelize(config.sql.database, config.sql.user, config.sql.password, {
    dialect: 'mssql',
    host: config.sql.server,
    port: config.sql.port
});

// Se exporta función para conectarse
exports.sequelize = sequelize;
exports.DataTypes = DataTypes;
exports.QueryTypes = QueryTypes