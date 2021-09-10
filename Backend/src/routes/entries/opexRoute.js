'use strict';

const express = require('express');
var OpexController = require('../../controllers/entriesControllers/opexController');
const router = express.Router();

var controller = new OpexController();

router.post('/select', (req, res) => {
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
    
    const {reportDate, createdBy, evaluation6S, trainingOnTime, completedOnTime} = req.body.reportDate;
    //const {reportDate, createdBy, tier, evaluation6S, trainingOnTime, completedOnTime} = req.body;
    try{
        controller.insertOpexEntry(reportDate, createdBy, evaluation6S, trainingOnTime, completedOnTime)
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
    //console.log(req.body)
    const{
        id,
        entry,
        fiscalYear,
        fiscalMonth,
        reportDate,
        createdBy,
        modifiedBy,
        createdDate,
        //modifiedDate,

        evaluation6S,
        trainingOnTime,
        completedOnTime
    } = req.body.fiscalMonth;

    try{
        controller.updateOpexEntry(
            id,
            entry,
            fiscalYear,
            fiscalMonth,
            reportDate,
            createdBy,
            modifiedBy,
            createdDate,
            //modifiedDate,

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

router.post('/allEntries', (req, res) => {
    try{
        controller.getAllOpexEntries()
        .then(response => {
            const entry = response;
            res.json(entry[0]);
        })
    } catch(err){
        return res.json({success: false, error: err});
    }
})

module.exports = router;