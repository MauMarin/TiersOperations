
import * as Yup from 'yup';
import { Formik } from 'formik';

import {
    Box,
    Button,
    Card,
    CardContent,
    CardHeader,
    Divider,
    Grid,
    TextField
} from '@material-ui/core';

import Cookies from 'universal-cookie';


import { useState, useEffect } from 'react';
import axios from 'axios';

const config = require('../../config');

const status = [
    {
        value: '',
        label: ''
    }, {
        value: "green",
        label: 'Green'
    }, {
        value: 'yellow',
        label: 'Yellow'
    }, {
        value: 'red',
        label: 'Red'
    }
];

const departments = [
    {
        value: '',
        label: ''
    }, {
        value: 1,
        label: 'Cost'
    }, {
        value: 2,
        label: 'OpEx'
    }, {
        value: 3,
        label: 'Quality'
    }, {
        value: 4,
        label: 'Safety'
    }, {
        value: 5,
        label: 'Service'
    },
    {
        value: 1002,
        label: 'MFG'
    },
    {
        value: 1003,
        label: 'ENG'
    }
];

const tiers = [
    {
        value: '',
        label: ''
    }, {
        value: 2,
        label: 'Tier 2'
    }, {
        value: 3,
        label: 'Tier 3'
    },
]

const userOptions = [
    {
        value: '',
        label: ''
    }
]

const EntryForm = (props) => {

    const cookie = new Cookies();
    const { id } = cookie.get('userData');

    const [users, setUsers] = useState({});

    useEffect(() => {
        axios.post(`http://${config.host}:${config.port}/api/users/getAll`,).then(response => {
            //console.log(response.data)
            setUsers(response.data)
            const u = response.data;

            for (var users of u) {
                const temp = { value: users.id, label: users.name }
                userOptions.push(temp)
            }

            setUsers(userOptions)


        });
    }, []);

    return (
        <Formik
            initialValues={{
                status: '',
                dueDate: '',
                department: '',
                description: '',
                submittedBy: '',
                directedTo: '',
                actionPlan: '',
                createdBy: id,
                tier: ''
            }}
            validationSchema={Yup.object().shape({
                status: Yup.string().required('Status is required'),
                dueDate: Yup.date().required('Due date is required'),
                department: Yup.number().required('Department is required'),
                description: Yup.string().required('Description is required'),
                submittedBy: Yup.number().required('Submitted by is required'),
                directedTo: Yup.number().required('Directed to is required'),
                actionPlan: Yup.string().required('Action plan is required'),
                createdBy: Yup.number().required('Created by is required'),
                tier: Yup.number().required('Tier is required'),
            })}

            //initial call to backend
            onSubmit={(status, dueDate, department, description, submittedBy, directedTo, actionPlan, createdBy, tier) => {

                axios({
                    method: 'post',
                    url: `http://${config.host}:${config.port}/api/cards/insert`,
                    headers: { 'Content-Type': 'application/json; charset=utf-8' },
                    data: {
                        status: status,
                        dueDate: dueDate,
                        department: department,
                        description: description,
                        submittedBy: submittedBy,
                        directedTo: directedTo,
                        actionPlan: actionPlan,
                        createdBy: createdBy,
                        tier: tier
                    }
                })
                    .then((response) => {
                        const data = response.data;
                    }, (error) => {
                        console.log(error);
                    });

                window.location.reload();
            }}

        >
            {({
                errors,
                handleBlur,
                handleChange,
                handleSubmit,
                isSubmitting,
                touched,
                values
            }) => (
                <form onSubmit={handleSubmit}>
                    <Card>
                        <CardHeader
                            subheader="Insert required data"
                            title="New Card"
                        />
                        <Divider />
                        <CardContent>
                            <Grid
                                container
                                spacing={3}
                            >

                                <Grid
                                    item
                                    md={6}
                                    xs={12}
                                >
                                    <TextField
                                        fullWidth
                                        label="Status"
                                        name="status"
                                        onChange={handleChange}
                                        required
                                        select
                                        SelectProps={{ native: true }}
                                        value={values.status}
                                        variant="outlined"
                                    >
                                        {status.map((option) => (
                                            <option
                                                key={option.value}
                                                value={option.value}
                                            >
                                                {option.label}
                                            </option>
                                        ))}
                                    </TextField>
                                </Grid>

                                <Grid
                                    item
                                    md={6}
                                    xs={12}
                                >
                                    <TextField
                                        fullWidth
                                        label="Department"
                                        name="department"
                                        onChange={handleChange}
                                        required
                                        select
                                        type="number"
                                        SelectProps={{ native: true }}
                                        value={values.department}
                                        variant="outlined"
                                    >
                                        {departments.map((option) => (
                                            <option
                                                key={option.value}
                                                value={option.value}
                                            >
                                                {option.label}
                                            </option>
                                        ))}
                                    </TextField>
                                </Grid>

                                <Grid
                                    item
                                    md={6}
                                    xs={12}
                                >
                                    <TextField
                                        fullWidth
                                        label="To"
                                        name="directedTo"
                                        onChange={handleChange}
                                        required
                                        select
                                        SelectProps={{ native: true }}
                                        value={values.directedTo}
                                        variant="outlined"
                                    >
                                        {userOptions.map((option) => (
                                            <option
                                                key={option.value}
                                                value={option.value}
                                            >
                                                {option.label}
                                            </option>
                                        ))}
                                    </TextField>
                                </Grid>

                                <Grid
                                    item
                                    md={6}
                                    xs={12}
                                >
                                    <TextField
                                        fullWidth
                                        label="By"
                                        name="submittedBy"
                                        onChange={handleChange}
                                        required
                                        select
                                        SelectProps={{ native: true }}
                                        value={values.submittedBy}
                                        variant="outlined"
                                    >
                                        {userOptions.map((option) => (
                                            <option
                                                key={option.value}
                                                value={option.value}
                                            >
                                                {option.label}
                                            </option>
                                        ))}
                                    </TextField>
                                </Grid>

                                <Grid
                                    item
                                    md={6}
                                    xs={12}
                                >
                                    <TextField
                                        fullWidth
                                        label="Tier"
                                        name="tier"
                                        onChange={handleChange}
                                        required
                                        select
                                        SelectProps={{ native: true }}
                                        value={values.tier}
                                        variant="outlined"
                                    >
                                        {tiers.map((option) => (
                                            <option
                                                key={option.value}
                                                value={option.value}
                                            >
                                                {option.label}
                                            </option>
                                        ))}
                                    </TextField>
                                </Grid>

                                <Grid
                                    item
                                    md={6}
                                    xs={12}
                                >

                                <TextField
                                    type='date'
                                    fullWidth
                                    label="Due date"
                                    name="dueDate"
                                    onChange={handleChange}
                                    required
                                    value={values.dueDate}
                                    variant="outlined"
                                    InputLabelProps={{ shrink: true, required: true }}
                                />

                                </Grid>

                                <Grid
                                    item
                                    md={6}
                                    xs={12}
                                >

                                <TextField
                                    fullWidth
                                    label="Description"
                                    name="description"
                                    onChange={handleChange}
                                    required
                                    multiline
                                    rows = {10}
                                    value={values.description}
                                    variant="outlined"
                                />

                                </Grid>

                                <Grid
                                    item
                                    md={6}
                                    xs={12}
                                >

                                <TextField
                                    fullWidth
                                    label="Action Plan"
                                    name="actionPlan"
                                    onChange={handleChange}
                                    multiline
                                    rows = {10}
                                    value={values.actionPlan}
                                    variant="outlined"
                                />

                                </Grid>

                            </Grid>
                        </CardContent>
                        <Divider />
                        <Box
                            sx={{
                                display: 'flex',
                                justifyContent: 'flex-end',
                                p: 2
                            }}
                        >
                            <Button
                                color="primary"
                                disabled={isSubmitting}
                                fullWidth
                                size="large"
                                type="submit"
                                variant="contained"
                            >
                                Submit new entry
                            </Button>
                        </Box>
                    </Card>
                </form>
            )}
        </Formik>
    );
};

export default EntryForm;