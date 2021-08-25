'use strict';

const express = require('express');
var QualityController = require('../../controllers/entriesControllers/qualityController');
const router = express.Router();

var controller = new QualityController();

router.get('/select', (req, res) => {
    const {idEntry} = req.body;
    try{
        controller.readQualityEntry(idEntry)
        .then(response => {
            const entry = response;
            res.json({"QualityEntry":entry[0][0]});
        })
    }
    catch(err){
        return res.json({success: false, error: err});
    }
})

router.post('/insert', (req, res) => {
    const {reportDate, createdBy, tier, larOverall, larHumacao, larWarsaw, fpy25, fly65, NCROpen} = req.body.tier;
    //const {reportDate, createdBy, tier, larOverall, larHumacao, larWarsaw, fpy25, fly65, NCROpen} = req.body;
    try{
        controller.insertQualityEntry(reportDate, createdBy, tier, larOverall, larHumacao, larWarsaw, fpy25, fly65, NCROpen)
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
        larOverall,
        larHumacao,
        larWarsaw,
        fpy25,
        fly65,
        NCROpen
    } = req.body;

    try{
        controller.updateQualityEntry(idEntry,
            fiscalYear,
            fiscalMonth,
            reportDate,
            createdBy,
            modifiedBy,
            createdDate,
            //modifiedDate,
            tier,
            larOverall,
            larHumacao,
            larWarsaw,
            fpy25,
            fly65,
            NCROpen
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
        controller.deleteQualityEntry(idEntry)
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
    const {tier} = req.body;
    try{
        controller.getAllQualityEntries(tier)
        .then(response => {
            const entry = response;
            res.json(entry[0]);
        })
    } catch(err){
        return res.json({success: false, error: err});
    }
})

module.exports = router;