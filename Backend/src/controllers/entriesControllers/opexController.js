const connection = require('../../connect');
const fiscal = require('../../miscellaneous/fiscalConversion');
const moment = require('moment');

//Preguntar si conexión se puede hacer desde aquí o se requiere de un DAO

class OpexController{
    constructor(){}

    async readOpexEntry(idEntry_){
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_OpExEntrySelect] :idEntry',
            {replacements: {
                idEntry: idEntry_
            }});
        return entry;
    }

    async getAllOpexEntries(){
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_EntriesByOpex]');
        return entry;
    }

    async insertOpexEntry(reportDate_, createdBy_, evaluation6S_, trainingOnTime_, completedOnTime_){
        const date = new Date();
        const month = date.getMonth() + 1; 
        const year = date.getFullYear();

        const fiscalYear_ = fiscal.getYear(year, month);
        const fiscalMonth_ = fiscal.getMonth(month);

        await connection.sequelize.query('EXEC [dbo].[usp_OpExEntryInsert] :fiscalYear, :fiscalMonth, :reportDate, :createdBy, :modifiedBy, :evaluation6S, :trainingOnTime, :completedOnTime',
        {replacements:{
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 
            reportDate: reportDate_, 
            createdBy: createdBy_, 
            modifiedBy: createdBy_,
            
            evaluation6S: evaluation6S_,
            trainingOnTime: trainingOnTime_,
            completedOnTime: completedOnTime_
        }});
    };

    async updateOpexEntry(
        _id,
        idEntry_,
        fiscalYear_,
        fiscalMonth_,
        reportDate_,
        createdBy_,
        modifiedBy_,
        createdDate_,
        //_modifiedDate,

        evaluation6S_,
        trainingOnTime_,
        completedOnTime_){
        
        await connection.sequelize.query('EXEC [dbo].[usp_OpExEntryUpdate] :id, :idEntry, :fiscalYear, :fiscalMonth, :reportDate, :createdBy, :modifiedBy, :createdDate, :evaluation6S, :trainingOnTime, :completedOnTime',
        {replacements: {
            id: _id,
            idEntry: idEntry_,
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 
            reportDate: reportDate_, 
            createdBy: createdBy_, 
            modifiedBy: modifiedBy_,

            createdDate: createdDate_, 
            
            evaluation6S: evaluation6S_,
            trainingOnTime: trainingOnTime_,
            completedOnTime: completedOnTime_
        }});

    };

    async deleteOpexEntry(_idEntry){
        await connection.sequelize.query('EXEC [dbo].[usp_OpExEntryDelete] :idEntry',
        {replacements: {
            idEntry: _idEntry
        }});
    };
}

module.exports = OpexController;