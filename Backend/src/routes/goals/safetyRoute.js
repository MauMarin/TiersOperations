

const express = require('express');
var SafetyController = require('../../controllers/goalsControllers/SafetyController');
const router = express.Router();

var controller = new SafetyController();

router.post('/select', (req, res) => {
    const {idGoal} = req.body;
    try{
        controller.readSafetyGoal(idGoal)
        .then(response => {
            const Goal = response;
            res.json({"SafetyGoal":Goal[0][0]});
        })
    }
    catch(err){
        return res.json({success: false, error: err});
    }
})

router.post('/insert', (req, res) => {
    const {depID} = req.body;
    const {HOs, TRIR, firstAid, nearMiss} = req.body.HOs;
    //console.log(req.body.tier);
    //const {reportDate, createdBy, tier, scrap, conversionLoss, toolConsumption, toolRate, earnHours, energyRate} = req.body.tier;

    try{
        controller.insertSafetyGoal(depID, HOs, TRIR, firstAid, nearMiss)
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

        HOs, TRIR, firstAid, nearMiss
    } = req.body;

    try{
        controller.updateSafetyGoal(
            idGoal,
            depID,
            fiscalYear,
            fiscalMonth,
            monthly,

            HOs, TRIR, firstAid, nearMiss
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
        controller.deleteSafetyGoal(idGoal)
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