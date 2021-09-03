const connection = require('../../connect');
const fiscal = require('../../miscellaneous/fiscalConversion');
const moment = require('moment');

//Preguntar si conexión se puede hacer desde aquí o se requiere de un DAO

class CostController{
    constructor(){}

    async readCostEntry(idEntry_){
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_CostEntrySelect] :idEntry',
                        {replacements: {
                            idEntry: idEntry_
                        }});
        return entry;
    }

    async getAllCostEntries(){
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_EntriesByCost]');
        return entry;
    }

    async insertCostEntry(_reportDate, _createdBy, _scrap, _conversionLoss, _toolConsumption, _toolRate, _earnHours, _energyRate){

        console.log(_reportDate, _createdBy, _scrap, _conversionLoss, _toolConsumption, _toolRate, _earnHours, _energyRate)

        const _createdDate = moment().format('YYYY-MM-DD HH:mm:ss');
        const _modifiedDate = moment().format('YYYY-MM-DD HH:mm:ss');
        const date = new Date();
        const month = date.getMonth() + 1; 
        const year = date.getFullYear();

        const _fiscalYear = fiscal.getYear(year, month);
        const _fiscalMonth = fiscal.getMonth(month);

        await connection.sequelize.query('EXEC [dbo].[usp_CostEntryInsert] :fiscalYear, :fiscalMonth, :reportDate, :createdBy, :modifiedBy, :createdDate, :modifiedDate, :scrap, :conversionLoss, :toolConsumption, :toolRate, :earnHours, :energyRate',
        {replacements:{
            fiscalYear: _fiscalYear, 
            fiscalMonth: _fiscalMonth, 
            reportDate: _reportDate, 
            createdBy: _createdBy, 
            modifiedBy: _createdBy,

            createdDate: _createdDate, 
            modifiedDate: _modifiedDate, 
            
            scrap: _scrap, 
            conversionLoss: _conversionLoss, 
            toolConsumption: _toolConsumption, 
            toolRate: _toolRate, 
            earnHours: _earnHours, 
            energyRate: _energyRate
        }});
    };

    async updateCostEntry(
        _idEntry,
        _fiscalYear,
        _fiscalMonth,
        _reportDate,
        _createdBy,
        _modifiedBy,
        _createdDate,
        //_modifiedDate,
        _scrap,
        _conversionLoss,
        _toolConsumption,
        _toolRate,
        _earnHours,
        _energyRate){

        const modifiedDate = moment().format('YYYY-MM-DD HH:ss:mm');
        
        await connection.sequelize.query('EXEC [dbo].[usp_CostEntryUpdate] :idEntry, :fiscalYear, :fiscalMonth, :reportDate, :createdBy, :modifiedBy, :createdDate, :modifiedDate, :scrap, :conversionLoss, :toolConsumption, :toolRate, :earnHours, :energyRate',
        {replacements: {
            idEntry: _idEntry,
            fiscalYear: _fiscalYear, 
            fiscalMonth: _fiscalMonth, 
            reportDate: _reportDate, 
            createdBy: _createdBy, 
            modifiedBy: _modifiedBy,

            createdDate: _createdDate, 
            modifiedDate: modifiedDate, 
            
            scrap: _scrap, 
            conversionLoss: _conversionLoss, 
            toolConsumption: _toolConsumption, 
            toolRate: _toolRate, 
            earnHours: _earnHours, 
            energyRate: _energyRate
        }});

    };

    async deleteCostEntry(_idEntry){
        await connection.sequelize.query('EXEC [dbo].[usp_CostEntryDelete] :idEntry',
        {replacements: {
            idEntry: _idEntry
        }});
    };
}

module.exports = CostController;