

const express = require('express');
var OpexController = require('../../controllers/goalsControllers/OpexController');
const router = express.Router();

var controller = new OpexController();

router.post('/select', (req, res) => {
    const {idGoal} = req.body;
    try{
        controller.readOpExEntry(idGoal)
        .then(response => {
            const entry = response;
            res.json({"OpexGoal":entry[0][0]});
        })
    }
    catch(err){
        return res.json({success: false, error: err});
    }
})

router.post('/insert', (req, res) => {
    const {depID} = req.body;
    const {evaluation6S, trainingOnTime, completedOnTime} = req.body.evaluation6S;
    //const {reportDate, createdBy, tier, scrap, conversionLoss, toolConsumption, toolRate, earnHours, energyRate} = req.body.tier;

    try{
        controller.insertOpExEntry(depID, evaluation6S, trainingOnTime, completedOnTime)
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
    const {depID} = req.body;
    const{
        idGoal,
        fiscalYear,
        fiscalMonth,

        evaluation6S, 
        trainingOnTime, 
        completedOnTime
    } = req.body.scrap;

    try{
        controller.updateOpExGoal(
            idGoal,
            depID,
            fiscalYear,
            fiscalMonth,

            evaluation6S, trainingOnTime, completedOnTime
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
        controller.deleteOpExGoal(idGoal)
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