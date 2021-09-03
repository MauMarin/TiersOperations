const connection = require('../../connect');
const fiscal = require('../../miscellaneous/fiscalConversion');
const moment = require('moment');

//Preguntar si conexión se puede hacer desde aquí o se requiere de un DAO

class QualityController{
    constructor(){}

    async readQualityGoal(idGoal_){
        const Goal = await connection.sequelize.query('EXEC [dbo].[usp_QualityGoalSelect] :idGoal',
                        {replacements: {
                            idGoal: idGoal_
                        }});
        return Goal;
    }

    async getAllGoalEntries(){
        const Goal = await connection.sequelize.query('EXEC [dbo].[usp_GoalsByQuality] ');
        return Goal;
    }

    async insertQualityGoal(depID_, larOverall_, larHumacao_, larWarsaw_, fly65_, NCROpen_){

        //console.log(_reportDate, _createdBy, _tier, _scrap, _conversionLoss, _toolConsumption, _toolRate, _earnHours, _energyRate)

        const date = new Date();
        const month = date.getMonth() + 1; 
        const year = date.getFullYear();

        const fiscalYear_ = fiscal.getYear(year, month);
        const fiscalMonth_ = fiscal.getMonth(month);
        const monthly_ = true;

        await connection.sequelize.query('EXEC [dbo].[usp_QualityGoalInsert] :depID, :fiscalYear, :fiscalMonth, :monthly, :larOverall, :larHumacao, :larWarsaw, :fly65, :NCROpen',
        {replacements:{
            depID: depID_,
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 
            monthly: monthly_, 

            larOverall: larOverall_,
            larHumacao: larHumacao_,
            larWarsaw: larWarsaw_,
            fly65: fly65_,
            NCROpen: NCROpen_
        }});
    };

    async updateQualityGoal(
        idGoal_,
        depID_,
        fiscalYear_,
        fiscalMonth_,
        monthly_,
        
        larOverall_, larHumacao_, larWarsaw_, fly65_, NCROpen_){

        
        await connection.sequelize.query('EXEC [dbo].[usp_QualityGoalUpdate] :idGoal, :depID, :fiscalYear, :fiscalMonth, :monthly, :larOverall, :larHumacao, :larWarsaw, :fly65, :NCROpen',
        {replacements: {
            idGoal: idGoal_,
            depID: depID_,
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 
            monthly: monthly_,

            larOverall: larOverall_,
            larHumacao: larHumacao_,
            larWarsaw: larWarsaw_,
            fly65: fly65_,
            NCROpen: NCROpen_
        }});

    };

    async deleteQualityGoal(idGoal_){
        await connection.sequelize.query('EXEC [dbo].[usp_QualityGoalDelete] :idGoal',
        {replacements: {
            idGoal: idGoal_
        }});
    };
}

module.exports = QualityController;