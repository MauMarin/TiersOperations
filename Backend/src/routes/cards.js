'use strict';

const express = require('express');
var CardController = require('../controllers/cardController')
const router = express.Router();

var controller = new CardController();

router.post('/insert', (req, res) => {
    const {status, dueDate, department, submittedBy, directedTo, actionPlan, createdBy, currID, tier} = req.body;

    try{
        controller.insertCard(status, dueDate, department, submittedBy, directedTo, actionPlan, createdBy, currID, tier)
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
    const{idCard, status, dueDate, department, submittedBy, directedTo, actionPlan, createdBy, modifiedBy, creationDate, currID, tier} = req.body;

    try{
        controller.updateCard(idCard, status, dueDate, department, submittedBy, directedTo, actionPlan, createdBy, modifiedBy, creationDate, currID, tier)
        .then(() => {
            return res.json({success: true, message: 'Entry has succesfully been updated'});
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
            return res.json({success: true, message: 'Entry has succesfully been deleted'});
        })
        .catch(err => {
            return res.json({success: false, error: {message: err.message}})
        })
    }
    catch(err){
        return res.json({success: false, error: err});
    }
})

module.exports = router;