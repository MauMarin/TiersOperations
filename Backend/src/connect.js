const config = require('./config');

const {Sequelize, DataTypes, QueryTypes} = require('sequelize');

const sequelize = new Sequelize(config.sql.database, config.sql.user, config.sql.password, {
    dialect: 'mssql',
    host: config.sql.server,
    port: config.sql.port
});

exports.sequelize = sequelize;
exports.DataTypes = DataTypes;
exports.QueryTypes = QueryTypes