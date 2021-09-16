//Archivo donde se definen las rutas de la aplicación

// Cada ruta está compuesta de subrutas o de las funciones que se buscan propiamente
// Una vez que se llega a la función, se llama al controlador correspondiente para que este se conecta a la base de datos

'use strict';

// Se indica que utilice express para ir definiendo la ruta
const express = require('express');

// Router permite ir creando la ruta, en este caso, toda ruta creada tiene 
const router = express.Router();

// Se importan los archivos que contienen las rutas de cada sección
const entries = require('./entriesRouter');
const cards = require('./cards');
const department = require('./department');
const goals = require('./goalsRouter');
const users = require('./users');

// Router.use va armando la ruta, agregando cada uno de estos después de "/api/"

/*
Todas las rutas comparten la misa estructura base
Se hace un método post a lo que se quiera hacer (CRUDs, etc.)
Cada función llama al controlador correspondiente, el cual se encarga de llamar a la base de datos
El resultado se retorna como un stack de callbacks, desde el controlador, hasta la ruta

Todas las rutas sirven de la misma manera, al asignar las variables del req.body
Estas se pasan hasta el controlador, donde se envían a la base de datos y retornan un resultado

Los controladores sirven al hacer un await a cada llamada a la base, para que no se pueda hacer
nada más hasta que se obtengan los resultados
Se hacen llamadas mediante sequelize, y los parámetros que se envían a la base de datos tienen un ":" antes de la variable
Es importante recalcar que, como sequelize es un poco tieso, el orden de las variables debe de ser el mismo que aquel que aparece en los SPs de SQL

Algunas rutas usan el archivo "fiscalConversion", el cual se encarga de convertir la fecha actual en el mes y año fiscal correspondiente

Entries y Goals son casos diferentes, donde se llama un archivo similar a este, que retorna más rutas

*/

router.use('/entries', entries.routes);
router.use('/department', department);
router.use('/cards', cards);
router.use('/goals', goals.routes);
router.use('/users', users);

router.get('/', (req, res) => {
    res.json({message: "API router works"})
})

module.exports = {
    routes: router
};