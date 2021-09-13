'use strict';

const express = require('express');
var CardController = require('../controllers/cardController')
const router = express.Router();

var controller = new CardController();

router.post('/select', (req, res) => {
    const {id} = req.body;

    console.log(id)

    try{
        controller.readCard(id)
        .then(response => {
            const entry = response;
            res.json({"Card":entry[0][0]});
        })
    }
    catch(err){
        return res.json({success: false, error: err});
    }
})

router.post('/insert', (req, res) => {
    //const {status, dueDate, department, description, submittedBy, directedTo, actionPlan, createdBy, tier} = req.body;
    const {status, dueDate, department, description, submittedBy, directedTo, actionPlan, tier, createdBy} = req.body.status;
    
    try{
        controller.insertCard(status, dueDate, department, description, submittedBy, directedTo, actionPlan, createdBy, tier)
        .then(() => {
            return res.json({success: true, message: 'Entry has succesfully been submitted'});
        })
        .catch(err => {
            return res.json({success: false, error: {message: err.message}})
        })
    }
    catch(err){
        return res.json({success: false, error: err})
    }
});

router.post('/update', (req, res) => {
    const{id, status, dueDate, department, submittedBy, directedTo, actionPlan, createdBy, modifiedBy, creationDate, description, tier} = req.body.status;

    const dep2 = Number(department)

    try{
        controller.updateCard(id, status, dueDate, dep2, submittedBy, directedTo, actionPlan, createdBy, modifiedBy, creationDate, description, tier)
        .then(() => {
            return res.json({success: true, message: 'Card has succesfully been updated'});
        })
        .catch(err => {
            return res.json({success: false, error: {message: err.message}})
        })
    }
    catch(err){
        return res.json({success: false, error: err});
    }
});

router.post('/delete', (req, res) => {
    const {idCard} = req.body;
    try{
        controller.deleteCard(idCard)
        .then(() => {
            return res.json({success: true, message: 'Card has succesfully been deleted'});
        })
        .catch(err => {
            return res.json({success: false, error: {message: err.message}})
        })
    }
    catch(err){
        return res.json({success: false, error: err});
    }
})

router.post('/changeStatus', (req, res) => {
    const {idCard, status} = req.body;
    try{
        controller.changeStatus(idCard, status)
        .then(() => {
            return res.json({success: true, message: 'Card has succesfully been changed'});
        })
        .catch(err => {
            return res.json({success: false, error: {message: err.message}})
        })
    }
    catch (err){
        return res.json({success: false, error: err});
    }
})

router.post('/getByStatus', (req, res) => {
    const {status} = req.body;
    console.log(status)
    try{
        controller.getByStatus(status)
        .then((response) => {
            const cards = response;
            res.json(cards[0])
        })
    }
    catch (err){
        return res.json({success: false, error: err});
    }
})

module.exports = router;