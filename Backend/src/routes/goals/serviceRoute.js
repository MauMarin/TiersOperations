

const express = require('express');
var ServiceController = require('../../controllers/goalsControllers/ServiceController');
const router = express.Router();

var controller = new ServiceController();

router.post('/select', (req, res) => {
    const {idGoal} = req.body;
    try{
        controller.readServiceGoal(idGoal)
        .then(response => {
            const Goal = response;
            res.json({"ServiceGoal":Goal[0][0]});
        })
    }
    catch(err){
        return res.json({success: false, error: err});
    }
})

router.post('/insert', (req, res) => {
    const {depID} = req.body;
    const {op20, op40, op60, op65, op70, intervention, OEE} = req.body.op20;
    //console.log(req.body.tier);
    //const {reportDate, createdBy, tier, scrap, conversionLoss, toolConsumption, toolRate, earnHours, energyRate} = req.body.tier;

    try{
        controller.insertServiceGoal(depID, op20, op40, op60, op65, op70, intervention, OEE)
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

        op20, op40, op60, op65, op70, intervention, OEE
    } = req.body;

    try{
        controller.updateServiceGoal(
            idGoal,
            depID,
            fiscalYear,
            fiscalMonth,
            monthly,

            op20, op40, op60, op65, op70, intervention, OEE
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
        controller.deleteServiceGoal(idGoal)
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