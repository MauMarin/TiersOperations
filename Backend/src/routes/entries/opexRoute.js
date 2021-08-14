'use strict';

const express = require('express');
var OpexController = require('../../controllers/entriesControllers/opexController');
const router = express.Router();

var controller = new OpexController();

router.get('/select', (req, res) => {
    const {idEntry} = req.body;
    try{
        controller.readOpexEntry(idEntry)
        .then(response => {
            const entry = response;
            res.json({"OpexEntry":entry[0][0]});
        })
    }
    catch(err){
        return res.json({success: false, error: err});
    }
})

router.post('/insert', (req, res) => {
    const {reportDate, createdBy, tier, evaluation6S, trainingOnTime, completedOnTime} = req.body;
    try{
        controller.insertOpexEntry(reportDate, createdBy, tier, evaluation6S, trainingOnTime, completedOnTime)
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
    const{
        idEntry,
        fiscalYear,
        fiscalMonth,
        reportDate,
        createdBy,
        modifiedBy,
        createdDate,
        //modifiedDate,
        tier,
        evaluation6S,
        trainingOnTime,
        completedOnTime
    } = req.body;

    try{
        controller.updateOpexEntry(idEntry,
            fiscalYear,
            fiscalMonth,
            reportDate,
            createdBy,
            modifiedBy,
            createdDate,
            //modifiedDate,
            tier,
            evaluation6S,
            trainingOnTime,
            completedOnTime
        )
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
    const {idEntry} = req.body;
    try{
        controller.deleteOpexEntry(idEntry)
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