'use strict';

// Requerimientos necesarios para usar el api
const express = require('express');
const config = require('./config');
const cors = require('cors');
//const connection = require('./connect');

// Rutas del api
const api = require('./routes/router');

// Aplicación express que recibe llamados y va creando las rutas
var app = express();

// Se le indica que utilice localhost como origen, para etapa de desarrollo
app.use(cors({origin: 
    ["http://localhost:3000"],
    credentials: true
}))

// Los headers que se esperan de los requests que entren al API
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
  });


app.use(express.urlencoded({ extended: false }));

// Permite utilizar json para mandar como recibir
app.use(express.json());

// Función base para revisar si existe conexión
app.get('/', function(req, res){
    return res.json({success: true, message: "Connection established"})
});

// Define que todas las rutas tienen como prefijo "api"
app.use('/api', api.routes);

// Entra en caso que no se encuentre la ruta
app.get('*', function(req, res){
    return res.json({nope: "Undefined route"})
});

// Escucha en el puerto y host definido en las variables de ambiente
app.listen(config.port, () => {
    console.log(`Listening on http://${config.host}:${config.port}`);
});