const connection = require('../../connect');
const fiscal = require('../../miscellaneous/fiscalConversion');
const moment = require('moment');

//Preguntar si conexión se puede hacer desde aquí o se requiere de un DAO

class SafetyController{
    constructor(){}

    async readSafetyGoal(idGoal_){
        const Goal = await connection.sequelize.query('EXEC [dbo].[usp_SafetyGoalSelect] :idGoal',
            {replacements: {
                idGoal: idGoal_
            }});
        return Goal;
    }

    async getAllGoalEntries(){
        const Goal = await connection.sequelize.query('EXEC [dbo].[usp_GoalsBySafety] ');
        return Goal;
    }

    async insertSafetyGoal(depID_, HOs_, TRIR_, firstAid_, nearMiss_){

        //console.log(_reportDate, _createdBy, _tier, _scrap, _conversionLoss, _toolConsumption, _toolRate, _earnHours, _energyRate)

        const date = new Date();
        const month = date.getMonth() + 1; 
        const year = date.getFullYear();

        const fiscalYear_ = fiscal.getYear(year, month);
        const fiscalMonth_ = fiscal.getMonth(month);
        const monthly_ = true;

        await connection.sequelize.query('EXEC [dbo].[usp_SafetyGoalInsert] :depID, :fiscalYear, :fiscalMonth, :monthly, :HOs, :TRIR, :firstAid, :nearMiss',
        {replacements:{
            depID: depID_,
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 
            monthly: monthly_, 

            HOs: HOs_,
            TRIR: TRIR_,
            firstAid: firstAid_,
            nearMiss: nearMiss_
        }});
    };

    async updateSafetyGoal(
        idGoal_,
        depID_,
        fiscalYear_,
        fiscalMonth_,
        monthly_,
        
        HOs_, TRIR_, firstAid_, nearMiss_){

            console.log("AAAAAAAAAAAAAA")

            console.log(
                idGoal_,
                depID_,
                fiscalYear_,
                fiscalMonth_,
                monthly_,
                
                HOs_, TRIR_, firstAid_, nearMiss_)

        
        await connection.sequelize.query('EXEC [dbo].[usp_SafetyGoalUpdate] :idGoal, :depID, :fiscalYear, :fiscalMonth, :monthly, :HOs, :TRIR, :firstAid, :nearMiss',
        {replacements: {
            idGoal: idGoal_,
            depID: depID_,
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 
            monthly: monthly_,

            HOs: HOs_,
            TRIR: TRIR_,
            firstAid: firstAid_,
            nearMiss: nearMiss_
        }});

    };

    async deleteSafetyGoal(idGoal_){
        await connection.sequelize.query('EXEC [dbo].[usp_SafetyGoalDelete] :idGoal',
        {replacements: {
            idGoal: idGoal_
        }});
    };
}

module.exports = SafetyController;