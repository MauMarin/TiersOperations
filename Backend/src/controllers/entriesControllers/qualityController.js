const connection = require('../../connect');
const fiscal = require('../../miscellaneous/fiscalConversion');
const moment = require('moment');

//Preguntar si conexión se puede hacer desde aquí o se requiere de un DAO

class QualityController{
    constructor(){}

    async readQualityEntry(idEntry_){
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_QualityEntrySelect] :idEntry',
            {replacements: {
                idEntry: idEntry_
            }});
        return entry;
    }

    async insertQualityEntry(reportDate_, createdBy_, larOverall_, larHumacao_, larWarsaw_, fly65_, NCROpen_){
        const date = new Date();
        const month = date.getMonth() + 1; 
        const year = date.getFullYear();

        const fiscalYear_ = fiscal.getYear(year, month);
        const fiscalMonth_ = fiscal.getMonth(month);

        await connection.sequelize.query('EXEC [dbo].[usp_QualityEntryInsert] :fiscalYear, :fiscalMonth, :reportDate, :createdBy, :modifiedBy, :larOverall, :larHumacao, :larWarsaw, :fly65, :NCROpen',
        {replacements:{
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 
            reportDate: reportDate_, 
            createdBy: createdBy_, 
            modifiedBy: createdBy_,
            
            larOverall: larOverall_,
            larHumacao: larHumacao_,
            larWarsaw: larWarsaw_,
            fly65: fly65_,
            NCROpen: NCROpen_
        }});
    };

    async updateQualityEntry(
        id_,
        idEntry_,
        fiscalYear_,
        fiscalMonth_,
        reportDate_,
        createdBy_,
        modifiedBy_,
        createdDate_,
        //_modifiedDate,
        larOverall_,
        larHumacao_,
        larWarsaw_,
        fly65_,
        NCROpen_){
        
        await connection.sequelize.query('EXEC [dbo].[usp_QualityEntryUpdate] :id, :idEntry, :fiscalYear, :fiscalMonth, :reportDate, :createdBy, :modifiedBy, :createdDate, :larOverall, :larHumacao, :larWarsaw, :fly65, :NCROpen',
        {replacements: {
            id: id_,
            idEntry: idEntry_,
            fiscalYear: fiscalYear_, 
            fiscalMonth: fiscalMonth_, 
            reportDate: reportDate_, 
            createdBy: createdBy_, 
            modifiedBy: modifiedBy_,

            createdDate: createdDate_, 
            
            larOverall: larOverall_,
            larHumacao: larHumacao_,
            larWarsaw: larWarsaw_,
            fly65: fly65_,
            NCROpen: NCROpen_
        }});

    };

    async deleteQualityEntry(_idEntry){
        await connection.sequelize.query('EXEC [dbo].[usp_QualityEntryDelete] :idEntry',
        {replacements: {
            idEntry: _idEntry
        }});
    };

    async getAllQualityEntries(){
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_EntriesByQuality]');
        return entry;
    }
}

module.exports = QualityController;