const connection = require('../../connect');
const fiscal = require('../../miscellaneous/fiscalConversion');
const moment = require('moment');

//Preguntar si conexión se puede hacer desde aquí o se requiere de un DAO

class SafetyController{
    constructor(){}

    async readSafetyEntry(idEntry_){
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_SafetyEntrySelect] :idEntry',
            {replacements: {
                idEntry: idEntry_
            }});
        return entry;
    }

    async getAllSafetyEntries(){
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_EntriesBySafety]');
        return entry;
    }

    async insertSafetyEntry(reportDate_, createdBy_, HOs_, TRIR_, firstAid_, nearMiss_){
        const date = new Date();
        const month = date.getMonth() + 1; 
        const year = date.getFullYear();

        const fiscalYear_ = fiscal.getYear(year, month);
        const fiscalMonth_ = fiscal.getMonth(month);

        await connection.sequelize.query('EXEC [dbo].[usp_SafetyEntryInsert] :fiscalYear, :fiscalMonth, :reportDate, :createdBy, :modifiedBy, :HOs, :TRIR, :firstAid, :nearMiss',
        {replacements:{
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 
            reportDate: reportDate_, 
            createdBy: createdBy_, 
            modifiedBy: createdBy_,
            
            HOs: HOs_,
            TRIR: TRIR_,
            firstAid: firstAid_,
            nearMiss: nearMiss_
        }});
    };

    async updateSafetyEntry(
        id_,
        idEntry_,
        fiscalYear_,
        fiscalMonth_,
        reportDate_,
        createdBy_,
        modifiedBy_,
        createdDate_,
        //_modifiedDate,

        HOs_,
        TRIR_,
        firstAid_,
        nearMiss_){
        
        await connection.sequelize.query('EXEC [dbo].[usp_SafetyEntryUpdate] :id, :idEntry, :fiscalYear, :fiscalMonth, :reportDate, :createdBy, :modifiedBy, :createdDate, :HOs, :TRIR, :firstAid, :nearMiss',
        {replacements: {
            id: id_,
            idEntry: idEntry_,
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 
            reportDate: reportDate_, 
            createdBy: createdBy_, 
            modifiedBy: modifiedBy_,

            createdDate: createdDate_, 

            HOs: HOs_,
            TRIR: TRIR_,
            firstAid: firstAid_,
            nearMiss: nearMiss_
        }});

    };

    async deleteSafetyEntry(_idEntry){
        await connection.sequelize.query('EXEC [dbo].[usp_SafetyEntryDelete] :idEntry',
        {replacements: {
            idEntry: _idEntry
        }});
    };
}

module.exports = SafetyController;