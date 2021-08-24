const connection = require('../connect');
const fiscal = require('../miscellaneous/fiscalConversion');
const moment = require('moment');

//Preguntar si conexión se puede hacer desde aquí o se requiere de un DAO

class UserController{
    constructor(){}

    async getUser(idUser_){
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_UsersSelect] :idUser',
            {replacements: {
                idUser: idUser_
            }});
        return entry;
    }

    async insertUser(name_, username_, depID_, role_, password_){

        await connection.sequelize.query('EXEC [dbo].[usp_UsersInsert] :name, :username, :depID, :role, :password',
        {replacements:{
            name: name_,
            username: username_,
            depID: depID_,
            role: role_,
            password: password_
        }});
    };

    async updateUser(idUser_, name_, username_, depID_, role_, password_){

        await connection.sequelize.query('EXEC [dbo].[usp_UsersUpdate] :idUser, :name, :username, :depID, :role, :password',
        {replacements: {
            idUser: idUser_,
            name: name_,
            username: username_,
            depID: depID_,
            role: role_,
            password: password_
        }});

    };

    async deleteUser(idUser_){
        await connection.sequelize.query('EXEC [dbo].[usp_UsersDelete] :idUser',
        {replacements: {
            idUser: idUser_
        }});
    };

    async validateUser(username_, password_){
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_ValidateUser] :username, :password',
        {replacements: {
            username: username_,
            password: password_
        }});
        console.log(entry)
        return entry;
    }

    async getAllUsers(){
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_GetAllUsers]');
        return entry;
    }
}

module.exports = UserController;