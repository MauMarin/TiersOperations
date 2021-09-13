
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

import axios from 'axios';

import Cookies from 'universal-cookie';

import { useEffect, useState } from 'react';

const config = require('../../../config');

const monthP = [
    {
        value: '',
        label: ''
    },{
        value: "P1",
        label: 'P1'
    }, {
        value: "P2",
        label: 'P2'
    },{
        value: "P3",
        label: 'P3'
    },{
        value: "P4",
        label: 'P4'
    },{
        value: "P5",
        label: 'P5'
    },{
        value: "P6",
        label: 'P6'
    },{
        value: "P7",
        label: 'P7'
    },{
        value: "P8",
        label: 'P8'
    },{
        value: "P9",
        label: 'P9'
    },{
        value: "P10",
        label: 'P10'
    },{
        value: "P11",
        label: 'P11'
    },{
        value: "P12",
        label: 'P12'
    },
];

const EntryForm = ({data}) => {

    const [isLoading, setLoading] = useState(true);
    const [entry, setEntry] = useState({});

    useEffect(() => {
        axios({
            method: 'post',
            url: `http://${config.host}:${config.port}/api/entries/opex/select`,
            headers: {'Content-Type': 'application/json; charset=utf-8'}, 
            data: {
                idEntry: data
            }
        })
        .then((response) => {
            console.log(response.data.OpexEntry)
            setEntry(response.data.OpexEntry)
            setLoading(false);
        });
      }, [data]);

      if (isLoading) {
        return <div className="App">Loading...</div>;
      }

    const cookie = new Cookies();
    const modifiedBy = cookie.get('userData').id;

    return (
        <Formik
            initialValues={{
                id: entry.id,
                entry: entry.entry,
                fiscalYear: entry.fiscalYear,
                fiscalMonth: entry.fiscalMonth,
                reportDate: entry.reportDate,
                createdBy: entry.createdBy,
                modifiedBy: modifiedBy,
                
                createdDate: entry.createdDate,

                evaluation6S: entry.evaluation6S,
                trainingOnTime: entry.trainingOnTime,
                completedOnTime: entry.completedOnTime
            }}
            validationSchema={Yup.object().shape({
                fiscalYear: Yup.string().required('Fiscal year date is required'),
                fiscalMonth: Yup.string().required('Fiscal month date is required'),
                reportDate: Yup.date().required('Report date is required'),
                createdBy: Yup.number().required('userID is required'),
                evaluation6S: Yup.number().required('Scrap is required'),
                trainingOnTime: Yup.number().required('Conversion loss is required'),
                completedOnTime: Yup.number().required('Tool consumption is required')
            })}

            //initial call to backend
            onSubmit={(fiscalMonth, reportDate, evaluation6S, trainingOnTime, completedOnTime) => {

            axios({
                method: 'post',
                url: `http://${config.host}:${config.port}/api/entries/opex/update`,
                headers: {'Content-Type': 'application/json; charset=utf-8'}, 
                data: {
                    reportDate: reportDate,
                    fiscalMonth: fiscalMonth,
                    evaluation6S: evaluation6S,
                    trainingOnTime: trainingOnTime,
                    completedOnTime: completedOnTime
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
                            title="Update OpEx Entry"
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
                                    label="Fiscal Year"
                                    name="fiscalYear"
                                    onChange={handleChange}
                                    required
                                    value={values.fiscalYear}
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
                                        label="Fiscal Month"
                                        name="fiscalMonth"
                                        onChange={handleChange}
                                        required
                                        select
                                        SelectProps={{ native: true }}
                                        value={values.depID}
                                        variant="outlined"
                                    >
                                        {monthP.map((option) => (
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
                                    label="Report Date"
                                    name="reportDate"
                                    onChange={handleChange}
                                    required
                                    value={values.reportDate}
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
                                        type="number"
                                        fullWidth
                                        label="6S Evaluation"
                                        name="evaluation6S"
                                        onChange={handleChange}
                                        required
                                        value={values.evaluation6S}
                                        variant="outlined"
                                    />
                                </Grid>
                                <Grid
                                    item
                                    md={6}
                                    xs={12}
                                >
                                    <TextField
                                        type="number"
                                        fullWidth
                                        label="Training on time"
                                        name="trainingOnTime"
                                        onChange={handleChange}
                                        required
                                        value={values.trainingOnTime}
                                        variant="outlined"
                                    />
                                </Grid>
                                <Grid
                                    item
                                    md={6}
                                    xs={12}
                                >
                                    <TextField
                                        type="number"
                                        fullWidth
                                        label="Completed on time"
                                        name="completedOnTime"
                                        onChange={handleChange}
                                        required
                                        value={values.completedOnTime}
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
                                Update
                            </Button>
                        </Box>
                    </Card>
                </form>
            )}
        </Formik>
    );
};

export default EntryForm;