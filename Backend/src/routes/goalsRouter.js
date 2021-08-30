'use strict';

const cost = require("./goals/costRoute");
const opex = require("./goals/opexRoute");
const quality = require("./goals/qualityRoute");
const safety = require("./goals/safetyRoute");
const service = require("./goals/serviceRoute");

const express = require('express');
const router = express.Router();


router.use('/cost', cost);
router.use('/opex', opex);
router.use('/quality', quality);
router.use('/safety', safety);
router.use('/service', service);


module.exports = {
    routes: router
};