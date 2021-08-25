const connection = require('../connect');

class DepartmentController{
    constructor(){}

    async getAll(){
        const deps = await connection.sequelize.query('EXEC [dbo].[usp_AllDepartments]');
        return deps;
    }
}

module.exports = DepartmentController;