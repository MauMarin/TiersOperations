'use strict';

const express = require('express');
var UserController = require('../controllers/userController')
const router = express.Router();

var controller = new UserController();

router.get('/select', (req, res) => {
    const {idUser} = req.body;
    try{
        controller.getUser(idUser)
        .then(response => {
            const entry = response;
            res.json({"User":entry[0][0]});
        })
    }
    catch(err){
        return res.json({success: false, error: err});
    }
})

router.post('/insert', (req, res) => {
    const {name, username, depID, role, password} = req.body;

    try{
        controller.insertUser(name, username, depID, role, password)
        .then(() => {
            return res.json({success: true, message: 'User has succesfully been added'});
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
    const{name, username, depID, role, password} = req.body;

    try{
        controller.updateUser(name, username, depID, role, password)
        .then(() => {
            return res.json({success: true, message: 'User has succesfully been updated'});
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
    const {idUser} = req.body;
    try{
        controller.deleteUser(idUser)
        .then(() => {
            return res.json({success: true, message: 'User has succesfully been deleted'});
        })
        .catch(err => {
            return res.json({success: false, error: {message: err.message}})
        })
    }
    catch(err){
        return res.json({success: false, error: err});
    }
})

router.post('/validate', (req, res) => {
    const {username, password} = req.body;
    try{
        //res.json({username, password})
        controller.validateUser(username, password)
        .then(response => {
            const entry = response;
            res.json(entry[0][0]);
        })
    }
    catch(err){
        return res.json({success: false, error: err});
    }
})

module.exports = router;