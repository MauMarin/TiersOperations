const config = require('./config');

const {Sequelize, DataTypes, QueryTypes} = require('sequelize');

const sequelize = new Sequelize(config.sql.database, config.sql.user, config.sql.password, {
    dialect: 'mssql',
    host: config.sql.server,
    port: config.sql.port
});

/*
async function test(){
    try{
        await sequelize.authenticate();
        console.log('Worked..');
    } catch(err){
        console.log(err);
    }
}
*/

exports.sequelize = sequelize;
exports.DataTypes = DataTypes;
exports.QueryTypes = QueryTypes