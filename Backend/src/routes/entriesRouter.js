'use strict';

const cost = require("./entries/costRoute");
const opex = require("./entries/opexRoute");
const quality = require("./entries/qualityRoute");
const safety = require("./entries/safetyRoute");
const service = require("./entries/serviceRoute");

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