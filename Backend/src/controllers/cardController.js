const connection = require('../connect');
const fiscal = require('../miscellaneous/fiscalConversion');
const moment = require('moment');

//Preguntar si conexión se puede hacer desde aquí o se requiere de un DAO

class CardController{
    constructor(){}

    async insertCard(status_, dueDate_, department_, submittedBy_, directedTo_, actionPlan_, createdBy_, currID_, tier_){
        const createdDate_ = moment().format('YYYY-MM-DD HH:mm:ss');
        const modifiedDate_ = moment().format('YYYY-MM-DD HH:mm:ss');

        await connection.sequelize.query('EXEC [dbo].[usp_CardsInsert] :status, :dueDate, :department, :submittedBy, :directedTo, :actionPlan, :createdBy, :modifiedBy, :creationDate, :modifiedDate, :currID, :tier',
        {replacements:{
            status: status_,
            dueDate: dueDate_, 
            department: department_, 
            submittedBy: submittedBy_, 
            directedTo: directedTo_, 
            actionPlan: actionPlan_, 
            createdBy: createdBy_, 
            modifiedBy: createdBy_, 
            creationDate: createdDate_, 
            modifiedDate: modifiedDate_, 
            currID: currID_, 
            tier: tier_
        }});
    };

    async updateCard(idCard_, status_, dueDate_, department_, submittedBy_, directedTo_, actionPlan_, createdBy_, modifiedBy_, creationDate_, currID_, tier_){

        const modifiedDate = moment().format('YYYY-MM-DD HH:ss:mm');
        
        await connection.sequelize.query('EXEC [dbo].[usp_CardsUpdate] :idCard, :status, :dueDate, :department, :submittedBy, :directedTo, :actionPlan, :createdBy, :modifiedBy, :creationDate, :modifiedDate, :currID, :tier',
        {replacements: {
            idCard: idCard_,
            status: status_,
            dueDate: dueDate_, 
            department: department_, 
            submittedBy: submittedBy_, 
            directedTo: directedTo_, 
            actionPlan: actionPlan_, 
            createdBy: createdBy_, 
            modifiedBy: modifiedBy_, 
            creationDate: creationDate_, 
            modifiedDate: modifiedDate, 
            currID: currID_, 
            tier: tier_
        }});

    };

    async deleteCard(idCard_){
        await connection.sequelize.query('EXEC [dbo].[usp_CardsDelete] :idCard',
        {replacements: {
            idCard: idCard_
        }});
    };

    async changeStatus(idCard_, status_){
        await connection.sequelize.query('EXEC [dbo].[usp_ChangeStatus] :idCard, :status',
        {replacements: {
            idCard: idCard_,
            status: status_
        }});
    }

    async getByStatus(status_){
        const cards = await connection.sequelize.query('EXEC [dbo].[usp_GetByStatus] :status',
        {replacements: {
            status: status_
        }});
        return cards;
    }

}

module.exports = CardController;