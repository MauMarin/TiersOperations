'use strict';

const express = require('express');
const config = require('./config');
const cors = require('cors');
const connection = require('./connect');

const api = require('./routes/router');

var app = express();

app.use(cors({origin: 
    ["http://localhost:3000"],
    credentials: true
}))

app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
  });

app.use(express.urlencoded({ extended: false }));
app.use(express.json());


app.get('/', function(req, res){
    return res.json({success: true, message: "Connection established"})
});

app.use('/api', api.routes);

app.get('*', function(req, res){
    return res.json({nope: "Undefined route"})
});

app.listen(config.port, () => {
    console.log(`Listening on http://${config.host}:${config.port}`);
});