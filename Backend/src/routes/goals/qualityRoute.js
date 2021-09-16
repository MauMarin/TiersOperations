

const express = require('express');
var QualityController = require('../../controllers/goalsControllers/qualityController');
const router = express.Router();

var controller = new QualityController();

router.post('/select', (req, res) => {
    const {idGoal} = req.body;
    try{
        controller.readQualityGoal(idGoal)
        .then(response => {
            const Goal = response;
            res.json({"QualityGoal":Goal[0][0]});
        })
    }
    catch(err){
        return res.json({success: false, error: err});
    }
})

router.post('/insert', (req, res) => {
    const {depID} = req.body;
    const {larOverall, larHumacao, larWarsaw, fly65, NCROpen} = req.body.larOverall;
    //console.log(req.body.tier);
    //const {reportDate, createdBy, tier, scrap, conversionLoss, toolConsumption, toolRate, earnHours, energyRate} = req.body.tier;

    try{
        controller.insertQualityGoal(depID, larOverall, larHumacao, larWarsaw, fly65, NCROpen)
        .then(() => {
            return res.json({success: true, message: 'Goal has succesfully been submitted'});
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

        larOverall, larHumacao, larWarsaw, fpy25, fly65, NCROpen
    } = req.body;

    try{
        controller.updateQualityGoal(
            idGoal,
            depID,
            fiscalYear,
            fiscalMonth,
            monthly,

            larOverall, larHumacao, larWarsaw, fpy25, fly65, NCROpen
        )
        .then(() => {
            return res.json({success: true, message: 'Goal has succesfully been updated'});
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
        controller.deleteQualityGoal(idGoal)
        .then(() => {
            return res.json({success: true, message: 'Goal has succesfully been deleted'});
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
            const Goal = response;
            res.json(Goal[0]);
        })
    } catch(err){
        return res.json({success: false, error: err});
    }
})

module.exports = router;