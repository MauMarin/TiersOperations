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

    async insertSafetyEntry(reportDate_, createdBy_, tier_, HOs_, TRIR_, firstAid_, nearMiss_){

        const createdDate_ = moment().format('YYYY-MM-DD HH:mm:ss');
        const modifiedDate_ = moment().format('YYYY-MM-DD HH:mm:ss');
        const date = new Date();
        const month = date.getMonth() + 1; 
        const year = date.getFullYear();

        const fiscalYear_ = fiscal.getYear(year, month);
        const fiscalMonth_ = fiscal.getMonth(month);

        await connection.sequelize.query('EXEC [dbo].[usp_SafetyEntryInsert] :fiscalYear, :fiscalMonth, :reportDate, :createdBy, :modifiedBy, :createdDate, :modifiedDate, :tier, HOs, TRIR, firstAid, nearMiss',
        {replacements:{
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 
            reportDate: reportDate_, 
            createdBy: createdBy_, 
            modifiedBy: createdBy_,

            createdDate: createdDate_, 
            modifiedDate: modifiedDate_, 
            
            tier: tier_,
            HOs: HOs_,
            TRIR: TRIR_,
            firstAid: firstAid_,
            nearMiss: nearMiss_
        }});
    };

    async updateSafetyEntry(
        idEntry_,
        fiscalYear_,
        fiscalMonth_,
        reportDate_,
        createdBy_,
        modifiedBy_,
        createdDate_,
        //_modifiedDate,
        tier_,
        HOs_,
        TRIR_,
        firstAid_,
        nearMiss_){

        const modifiedDate_ = moment().format('YYYY-MM-DD HH:ss:mm');
        
        await connection.sequelize.query('EXEC [dbo].[usp_SafetyEntryUpdate] :idEntry, :fiscalYear, :fiscalMonth, :reportDate, :createdBy, :modifiedBy, :createdDate, :modifiedDate, :tier, :larOverall, :larHumacao, :larWarsaw, :fpy25, :fly65, :NCROpen',
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