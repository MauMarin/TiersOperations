

const express = require('express');
var CostController = require('../../controllers/goalsControllers/costController');
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
    //console.log(req.body)
    //const {depID, scrap, conversionLoss, toolConsumption, toolRate, earnHours, energyRate} = req.body.depID;
    const {depID} = req.body;
    const {scrap, conversionLoss, toolConsumption, toolRate, earnHours, energyRate} = req.body.scrap;

    try{
        controller.insertCostEntry(depID, scrap, conversionLoss, toolConsumption, toolRate, earnHours, energyRate)
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
        idGoal,
        depID,
        fiscalYear,
        fiscalMonth,
        monthly,

        scrap,
        conversionLoss,
        toolConsumption,
        toolRate,
        earnHours,
        energyRate
    } = req.body;

    console.log(idGoal,
        depID,
        fiscalYear,
        fiscalMonth,
        monthly,

        scrap,
        conversionLoss,
        toolConsumption,
        toolRate,
        earnHours,
        energyRate)

    try{
        controller.updateCostEntry(
            idGoal,
            depID,
            fiscalYear,
            fiscalMonth,
            monthly,

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
        return res.json({success: false, error: "Failed to send to controller"});
    }
});

router.post('/delete', (req, res) => {
    const {idGoal} = req.body;
    try{
        controller.deleteCostGoal(idGoal)
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

router.post('/allGoals', (req, res) => {
    try{
        controller.getAllGoalEntries()
        .then(response => {
            const entry = response;
            res.json(entry[0]);
        })
    } catch(err){
        return res.json({success: false, error: err});
    }
})

module.exports = router;