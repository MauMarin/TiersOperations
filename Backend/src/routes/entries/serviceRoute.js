'use strict';

const express = require('express');
var ServiceController = require('../../controllers/entriesControllers/serviceController');
const router = express.Router();

var controller = new ServiceController();

router.post('/select', (req, res) => {
    const {idEntry} = req.body;
    try{
        controller.readServiceEntry(idEntry)
        .then(response => {
            const entry = response;
            res.json({"ServiceEntry":entry[0][0]});
        })
    }
    catch(err){
        return res.json({success: false, error: err});
    }
})

router.post('/insert', (req, res) => {
    const {reportDate, createdBy, op20, op40, op60, op65, op70, intervention, OEE} = req.body.reportDate;
    //const {reportDate, createdBy, op20, op40, op60, op65, op70, intervention, OEE} = req.body;
    try{
        controller.insertServiceEntry(reportDate, createdBy, op20, op40, op60, op65, op70, intervention, OEE)
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
        id,
        entry,
        fiscalYear,
        fiscalMonth,
        reportDate,
        createdBy,
        modifiedBy,
        createdDate,
        //modifiedDate,
        op20,
        op40,
        op60,
        op65,
        op70,
        intervention,
        OEE
    } = req.body.reportDate;

    try{
        controller.updateServiceEntry(
            id,
            entry,
            fiscalYear,
            fiscalMonth,
            reportDate,
            createdBy,
            modifiedBy,
            createdDate,
            //modifiedDate,
            op20,
            op40,
            op60,
            op65,
            op70,
            intervention,
            OEE
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
        controller.deleteServiceEntry(idEntry)
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
        controller.getAllServiceEntries()
        .then(response => {
            const entry = response;
            res.json(entry[0]);
        })
    } catch(err){
        return res.json({success: false, error: err});
    }
})

module.exports = router;