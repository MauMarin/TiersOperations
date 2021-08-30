const connection = require('../../connect');
const fiscal = require('../../miscellaneous/fiscalConversion');
const moment = require('moment');

//Preguntar si conexión se puede hacer desde aquí o se requiere de un DAO

class ServiceController{
    constructor(){}

    async readServiceGoal(idGoal_){
        const Goal = await connection.sequelize.query('EXEC [dbo].[usp_ServiceGoalSelect] :idGoal',
            {replacements: {
                idGoal: idGoal_
            }});
        return Goal;
    }

    async getAllGoalEntries(){
        const Goal = await connection.sequelize.query('EXEC [dbo].[usp_GoalsByService] ');
        return Goal;
    }

    async insertServiceGoal(depID_, op20_, op40_, op60_, op65_, op70_, intervention_, OEE_){

        //console.log(_reportDate, _createdBy, _tier, _scrap, _conversionLoss, _toolConsumption, _toolRate, _earnHours, _energyRate)

        const date = new Date();
        const month = date.getMonth() + 1; 
        const year = date.getFullYear();

        const fiscalYear_ = fiscal.getYear(year, month);
        const fiscalMonth_ = fiscal.getMonth(month);
        const monthly_ = true;

        await connection.sequelize.query('EXEC [dbo].[usp_ServiceGoalInsert] :depID, :fiscalYear, :fiscalMonth, :monthly, :op20, :op40, :op60, :op65, :op70, :intervention, :OEE',
        {replacements:{
            depID: depID_,
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 
            monthly: monthly_, 

            op20: op20_,
            op40: op40_,
            op60: op60_,
            op65: op65_,
            op70: op70_,
            intervention: intervention_,
            OEE: OEE_
        }});
    };

    async updateServiceGoal(
        idGoal_,
        depID_,
        fiscalYear_,
        fiscalMonth_,
        monthly_,
        
        op20_, op40_, op60_, op65_, op70_, intervention_, OEE_){

        
        await connection.sequelize.query('EXEC [dbo].[usp_ServiceGoalUpdate] :idGoal, :depID, :fiscalYear, :fiscalMonth, :monthly, :op20, :op40, :op60, :op65, :op70, :intervention, :OEE',
        {replacements: {
            idGoal: idGoal_,
            depID: depID_,
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 
            monthly: monthly_,

            op20: op20_,
            op40: op40_,
            op60: op60_,
            op65: op65_,
            op70: op70_,
            intervention: intervention_,
            OEE: OEE_
        }});

    };

    async deleteServiceGoal(idGoal_){
        await connection.sequelize.query('EXEC [dbo].[usp_ServiceGoalDelete] :idGoal',
        {replacements: {
            idGoal: idGoal_
        }});
    };
}

module.exports = ServiceController;