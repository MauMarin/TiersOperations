const connection = require('../../connect');
const fiscal = require('../../miscellaneous/fiscalConversion');
const moment = require('moment');

//Preguntar si conexión se puede hacer desde aquí o se requiere de un DAO

class OpExController{
    constructor(){}

    async readOpExEntry(idGoal_){
        console.log(idGoal_)
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_OpExGoalSelect] :idGoal',
            {replacements: {
                idGoal: idGoal_
            }});
        return entry;
    }

    async getAllGoalEntries(){
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_GoalsByOpEx] ');
        return entry;
    }

    async insertOpExEntry(depID_, evaluation6S_, trainingOnTime_, completedOnTime_){

        //console.log(_reportDate, _createdBy, _tier, _scrap, _conversionLoss, _toolConsumption, _toolRate, _earnHours, _energyRate)

        const date = new Date();
        const month = date.getMonth() + 1; 
        const year = date.getFullYear();

        const _fiscalYear = fiscal.getYear(year, month);
        const _fiscalMonth = fiscal.getMonth(month);
        const monthly_ = true;

        await connection.sequelize.query('EXEC [dbo].[usp_OpExGoalInsert] :depID, :fiscalYear, :fiscalMonth, :monthly, :evaluation6S, :trainingOnTime, :completedOnTime',
        {replacements:{
            depID: depID_,
            fiscalYear: _fiscalYear, 
            fiscalMonth: _fiscalMonth, 
            monthly: monthly_, 

            evaluation6S: evaluation6S_,
            trainingOnTime: trainingOnTime_,
            completedOnTime: completedOnTime_
        }});
    };

    async updateOpExGoal(
        idGoal_,
        depID_,
        fiscalYear_,
        fiscalMonth_,
        
        evaluation6S_, trainingOnTime_, completedOnTime_){

        
        await connection.sequelize.query('EXEC [dbo].[usp_OpExGoalUpdate] :idGoal, :depID, :fiscalYear, :fiscalMonth, :eval6S, :tOT, :cOT',
        {replacements: {
            idGoal: idGoal_,
            depID: depID_,
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 

            eval6S: evaluation6S_,
            tOT: trainingOnTime_,
            cOT: completedOnTime_
        }});

    };

    async deleteOpExGoal(idGoal_){
        await connection.sequelize.query('EXEC [dbo].[usp_OpExGoalDelete] :idGoal',
        {replacements: {
            idGoal: idGoal_
        }});
    };
}

module.exports = OpExController;