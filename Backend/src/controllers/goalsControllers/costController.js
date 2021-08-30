const connection = require('../../connect');
const fiscal = require('../../miscellaneous/fiscalConversion');
const moment = require('moment');

//Preguntar si conexión se puede hacer desde aquí o se requiere de un DAO

class CostController{
    constructor(){}

    async readCostEntry(idGoal_){
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_CostGoalsSelect] :idGoal',
                        {replacements: {
                            idGoal: idGoal_
                        }});
        return entry;
    }

    async getAllGoalEntries(){
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_GoalsByCost] ');
        return entry;
    }

    async insertCostEntry(depID_, _scrap, _conversionLoss, _toolConsumption, _toolRate, _earnHours, _energyRate){

        //console.log(_reportDate, _createdBy, _tier, _scrap, _conversionLoss, _toolConsumption, _toolRate, _earnHours, _energyRate)

        const date = new Date();
        const month = date.getMonth() + 1; 
        const year = date.getFullYear();

        const _fiscalYear = fiscal.getYear(year, month);
        const _fiscalMonth = fiscal.getMonth(month);
        const monthly_ = true;

        await connection.sequelize.query('EXEC [dbo].[usp_CostGoalsInsert] :depID, :fiscalYear, :fiscalMonth, :monthly, :scrap, :conversionLoss, :toolConsumption, :toolRate, :earnHours, :energyRate',
        {replacements:{
            depID: depID_,
            fiscalYear: _fiscalYear, 
            fiscalMonth: _fiscalMonth, 
            monthly: monthly_, 

            scrap: _scrap, 
            conversionLoss: _conversionLoss, 
            toolConsumption: _toolConsumption, 
            toolRate: _toolRate, 
            earnHours: _earnHours, 
            energyRate: _energyRate
        }});
    };

    async updateCostEntry(
        idGoal_,
        depID_,
        _fiscalYear,
        _fiscalMonth,
        monthly_,
        
        _scrap,
        _conversionLoss,
        _toolConsumption,
        _toolRate,
        _earnHours,
        _energyRate){

        
        await connection.sequelize.query('EXEC [dbo].[usp_CostGoalsUpdate] :idGoal, :depID, :fiscalYear, :fiscalMonth, :monthly, :scrap, :conversionLoss, :toolConsumption, :toolRate, :earnHours, :energyRate',
        {replacements: {
            idGoal: idGoal_,
            depID: depID_,
            fiscalYear: _fiscalYear, 
            fiscalMonth: _fiscalMonth, 
            monthly: monthly_,
            scrap: _scrap, 
            conversionLoss: _conversionLoss, 
            toolConsumption: _toolConsumption, 
            toolRate: _toolRate, 
            earnHours: _earnHours, 
            energyRate: _energyRate
        }});

    };

    async deleteCostGoal(idGoal_){
        await connection.sequelize.query('EXEC [dbo].[usp_CostGoalsDelete] :idGoal',
        {replacements: {
            idGoal: idGoal_
        }});
    };
}

module.exports = CostController;