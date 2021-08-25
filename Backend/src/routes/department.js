

const express = require('express');
var DepartmentController = require('../controllers/departmentController')
const router = express.Router();

var controller = new DepartmentController();

router.get('/allDepartments', (req, res) => {
    try{
        controller.getAll()
        .then(response => {
            const entry = response;
            res.json(entry[0]);
        })
    }
    catch(err){
        return res.json({success: false, error: err});
    }
})

module.exports = router;