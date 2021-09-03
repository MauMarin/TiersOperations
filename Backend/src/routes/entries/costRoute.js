

const express = require('express');
var CostController = require('../../controllers/entriesControllers/costController');
const router = express.Router();

var controller = new CostController();

router.get('/select', (req, res) => {
    const {idEntry} = req.body;
    try{
        controller.readCostEntry(idEntry)
        .then(response => {
            const entry = response;
            res.json({"CostEntry":entry[0][0]});
        })
    }
    catch(err){
        return res.json({success: false, error: err});
    }
})

router.post('/insert', (req, res) => {
    //const {reportDate, createdBy, tier, scrap, conversionLoss, toolConsumption, toolRate, earnHours, energyRate} = req.body;
    //console.log(req.body);
    const {reportDate, createdBy, scrap, conversionLoss, toolConsumption, toolRate, earnHours, energyRate} = req.body.createdBy;

    try{
        controller.insertCostEntry(reportDate, createdBy, scrap, conversionLoss, toolConsumption, toolRate, earnHours, energyRate)
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
    const{idEntry,
        fiscalYear,
        fiscalMonth,
        reportDate,
        createdBy,
        modifiedBy,
        createdDate,
        //modifiedDate,
        scrap,
        conversionLoss,
        toolConsumption,
        toolRate,
        earnHours,
        energyRate
    } = req.body;

    try{
        controller.updateCostEntry(idEntry,
            fiscalYear,
            fiscalMonth,
            reportDate,
            createdBy,
            modifiedBy,
            createdDate,
            //modifiedDate,
            scrap,
            conversionLoss,
            toolConsumption,
            toolRate,
            earnHours,
            energyRate
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
        controller.deleteCostEntry(idEntry)
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
        controller.getAllCostEntries()
        .then(response => {
            const entry = response;
            res.json(entry[0]);
        })
    } catch(err){
        return res.json({success: false, error: err});
    }
})

module.exports = router;