const connection = require('../connect');

class CardController{
    constructor(){}

    async readCard(id_){
        console.log(id_)
        const entry = await connection.sequelize.query('EXEC [dbo].[usp_CardsSelect] :id',
            {replacements: {
                id: id_
            }});
        return entry;
    }

    async insertCard(status_, dueDate_, department_, description_, submittedBy_, directedTo_, actionPlan_, createdBy_, tier_){

        await connection.sequelize.query('EXEC [dbo].[usp_CardsInsert] :status, :dueDate, :department, :description, :submittedBy, :directedTo, :actionPlan, :createdBy, :modifiedBy, :tier',
        {replacements:{
            status: status_,
            dueDate: dueDate_, 
            department: department_, 
            description: description_,
            submittedBy: submittedBy_, 
            directedTo: directedTo_, 
            actionPlan: actionPlan_, 
            createdBy: createdBy_, 
            modifiedBy: createdBy_, 
            tier: tier_
        }});
    };

    async updateCard(idCard_, status_, dueDate_, department_, submittedBy_, directedTo_, actionPlan_, createdBy_, modifiedBy_, creationDate_, description_, tier_){
        
        await connection.sequelize.query('EXEC [dbo].[usp_CardsUpdate] :idCard, :status, :dueDate, :department, :submittedBy, :directedTo, :actionPlan, :createdBy, :modifiedBy, :creationDate, :tier, :description',
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
            tier: tier_,
            description: description_,
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