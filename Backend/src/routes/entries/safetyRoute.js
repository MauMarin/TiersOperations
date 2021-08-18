'use strict';

const express = require('express');
var SafetyController = require('../../controllers/entriesControllers/safetyController');
const router = express.Router();

var controller = new SafetyController();

router.get('/select', (req, res) => {
    const {idEntry} = req.body;
    try{
        controller.readSafetyEntry(idEntry)
        .then(response => {
            const entry = response;
            res.json({"SafetyEntry":entry[0][0]});
        })
    }
    catch(err){
        return res.json({success: false, error: err});
    }
})

router.post('/insert', (req, res) => {
    const {reportDate, createdBy, tier, HOs, TRIR, firstAid, nearMiss} = req.body;
    try{
        controller.insertSafetyEntry(reportDate, createdBy, tier, HOs, TRIR, firstAid, nearMiss)
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
        HOs,
        TRIR,
        firstAid,
        nearMiss
    } = req.body;

    try{
        controller.updateSafetyEntry(idEntry,
            fiscalYear,
            fiscalMonth,
            reportDate,
            createdBy,
            modifiedBy,
            createdDate,
            //modifiedDate,
            tier,
            HOs,
            TRIR,
            firstAid,
            nearMiss
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
        controller.deleteSafetyEntry(idEntry)
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
    const {depID} = req.body;
    try{
        controller.getAllSafetyEntries(depID)
        .then(response => {
            const entry = response;
            res.json(entry[0]);
        })
    } catch(err){
        return res.json({success: false, error: err});
    }
})

module.exports = router;