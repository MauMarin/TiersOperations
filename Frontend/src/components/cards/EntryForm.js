
import * as Yup from 'yup';
import { Formik } from 'formik';

import AdapterDateFns from '@mui/lab/AdapterDateFns';
import LocalizationProvider from '@mui/lab/LocalizationProvider';
import DatePicker from '@mui/lab/DatePicker';

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

import { useState, useEffect } from 'react';
import axios from 'axios';

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


    const [users, setUsers] = useState({});

    useEffect(() => {
        axios.post("http://localhost:8080/api/users/getAll",).then(response => {
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
                createdBy: '',
                tier: '',
                currID: ''
            }}
            validationSchema={Yup.object().shape({
                status: Yup.string().required('Status is required'),
                dueDate: Yup.string().required('Status is required'),
                department: Yup.string().required('Status is required'),
                description: Yup.string().required('Status is required'),
                submittedBy: Yup.string().required('Status is required'),
                directedTo: Yup.string().required('Status is required'),
                actionPlan: Yup.string().required('Status is required'),
                createdBy: Yup.string().required('Status is required'),
                tier: Yup.string().required('Status is required'),
                currID: Yup.string().required('Status is required'),
            })}

            //initial call to backend
            onSubmit={(status, dueDate, department, description, submittedBy, directedTo, actionPlan, createdBy, tier, currID) => {

                axios({
                    method: 'post',
                    url: 'http://localhost:8080/api/cards/insert',
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
                        tier: tier,
                        currID: currID
                    }
                })
                    .then((response) => {
                        const data = response.data;
                        console.log(data)
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
                            title="New Cost Entry"
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
                                        name="depID"
                                        onChange={handleChange}
                                        required
                                        select
                                        type="number"
                                        SelectProps={{ native: true }}
                                        value={values.depID}
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
                                    <DatePicker
                                        disableFuture
                                        label="Responsive"
                                        openTo="year"
                                        views={['year', 'month', 'day']}
                                        value={value}
                                        onChange={(newValue) => {
                                            setValue(newValue);
                                        }}
                                        renderInput={(params) => <TextField {...params} />}
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