'use strict';

const express = require('express');
const router = express.Router();

const entries = require('./entriesRouter');
const cards = require('./cards');
const dashboard = require('./dashboard');
const goals = require('./goals');
const users = require('./users');

router.use('/entries', entries.routes);
router.use('/department', entries.routes);
//router.use('/cards', cards);
//router.use('/dashboard', dashboard);
//router.use('/goals', goals);
router.use('/users', users);

router.get('/', (req, res) => {
    res.json({a: "s"})
})

module.exports = {
    routes: router
};