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

    async getAllServiceEntries(depID_){
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_EntriesByService] :depID',
            {replacements: {
                depID: depID_
            }});
        return entry;
    }

    async insertServiceEntry(reportDate_, createdBy_, tier_, op20_, op40_, op60_, op65_, op70_, intervention_, OEE_){

        const createdDate_ = moment().format('YYYY-MM-DD HH:mm:ss');
        const modifiedDate_ = moment().format('YYYY-MM-DD HH:mm:ss');
        const date = new Date();
        const month = date.getMonth() + 1; 
        const year = date.getFullYear();

        const fiscalYear_ = fiscal.getYear(year, month);
        const fiscalMonth_ = fiscal.getMonth(month);

        await connection.sequelize.query('EXEC [dbo].[usp_ServiceEntryInsert] :fiscalYear, :fiscalMonth, :reportDate, :createdBy, :modifiedBy, :createdDate, :modifiedDate, :tier, :op20, :op40, :op60, :op65, :op70, :intervention, :OEE',
        {replacements:{
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 
            reportDate: reportDate_, 
            createdBy: createdBy_, 
            modifiedBy: createdBy_,

            createdDate: createdDate_, 
            modifiedDate: modifiedDate_, 
            
            tier: tier_,
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
        idEntry_,
        fiscalYear_,
        fiscalMonth_,
        reportDate_,
        createdBy_,
        modifiedBy_,
        createdDate_,
        //_modifiedDate,
        tier_,
        op20_,
        op40_,
        op60_,
        op65_,
        op70_,
        intervention_,
        OEE_
    ){
        const modifiedDate_ = moment().format('YYYY-MM-DD HH:ss:mm');
        
        await connection.sequelize.query('EXEC [dbo].[usp_ServiceEntryUpdate] :idEntry, :fiscalYear, :fiscalMonth, :reportDate, :createdBy, :modifiedBy, :createdDate, :modifiedDate, :tier, :op20, :op40, :op60, :op65, :op70, :intervention, :OEE',
        {replacements: {
            idEntry: idEntry_,
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 
            reportDate: reportDate_, 
            createdBy: createdBy_, 
            modifiedBy: modifiedBy_,

            createdDate: createdDate_, 
            modifiedDate: modifiedDate_, 
            
            tier: tier_, 
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