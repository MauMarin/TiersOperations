'use strict';

const express = require('express');
//var UserController = require('../controllers/userController')
const router = express.Router();

var controller = new UserController();

module.exports = router;