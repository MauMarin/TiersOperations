const connection = require('../../connect');
const fiscal = require('../../miscellaneous/fiscalConversion');
const moment = require('moment');

//Preguntar si conexión se puede hacer desde aquí o se requiere de un DAO

class ServiceController{
    constructor(){}

    async readServiceEntry(idEntry_){
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_ServiceEntrySelect] :idEntry',
            {replacements: {
                idEntry: idEntry_
            }});
        return entry;
    }

    async getAllServiceEntries(){
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_EntriesByService]');
        return entry;
    }

    async insertServiceEntry(reportDate_, createdBy_, op20_, op40_, op60_, op65_, op70_, intervention_, OEE_){
        const date = new Date();
        const month = date.getMonth() + 1; 
        const year = date.getFullYear();

        const fiscalYear_ = fiscal.getYear(year, month);
        const fiscalMonth_ = fiscal.getMonth(month);

        await connection.sequelize.query('EXEC [dbo].[usp_ServiceEntryInsert] :fiscalYear, :fiscalMonth, :reportDate, :createdBy, :modifiedBy, :op20, :op40, :op60, :op65, :op70, :intervention, :OEE',
        {replacements:{
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 
            reportDate: reportDate_, 
            createdBy: createdBy_, 
            modifiedBy: createdBy_,
            
            op20: op20_,
            op40: op40_,
            op60: op60_,
            op65: op65_,
            op70: op70_,
            intervention: intervention_,
            OEE: OEE_
        }});
    };

    async updateServiceEntry(
        id_,
        idEntry_,
        fiscalYear_,
        fiscalMonth_,
        reportDate_,
        createdBy_,
        modifiedBy_,
        createdDate_,
        //_modifiedDate,
        op20_,
        op40_,
        op60_,
        op65_,
        op70_,
        intervention_,
        OEE_
    ){
        
        await connection.sequelize.query('EXEC [dbo].[usp_ServiceEntryUpdate] :id, :idEntry, :fiscalYear, :fiscalMonth, :reportDate, :createdBy, :modifiedBy, :createdDate, :op20, :op40, :op60, :op65, :op70, :intervention, :OEE',
        {replacements: {
            id: id_,
            idEntry: idEntry_,
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 
            reportDate: reportDate_, 
            createdBy: createdBy_, 
            modifiedBy: modifiedBy_,

            createdDate: createdDate_, 
            
            op20: op20_,
            op40: op40_,
            op60: op60_,
            op65: op65_,
            op70: op70_,
            intervention: intervention_,
            OEE: OEE_
        }});

    };

    async deleteServiceEntry(_idEntry){
        await connection.sequelize.query('EXEC [dbo].[usp_ServiceEntryDelete] :idEntry',
        {replacements: {
            idEntry: _idEntry
        }});
    };
}

module.exports = ServiceController;