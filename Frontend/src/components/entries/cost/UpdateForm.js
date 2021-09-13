
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
            url: `http://${config.host}:${config.port}/api/entries/cost/select`,
            headers: {'Content-Type': 'application/json; charset=utf-8'}, 
            data: {
                idEntry: data
            }
        })
        .then((response) => {
            setEntry(response.data.CostEntry)
            //console.log(response.data.CostEntry)
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

                scrap: entry.scrap,
                conversionLoss: entry.conversionLoss,
                toolConsumption: entry.toolConsumption,
                toolRate: entry.toolRate,
                earnHours: entry.earnHours,
                energyRate: entry.energyRate,
            }}
            validationSchema={Yup.object().shape({
                fiscalYear: Yup.string().required('Fiscal year date is required'),
                fiscalMonth: Yup.string().required('Fiscal month date is required'),
                reportDate: Yup.date().required('Report date is required'),
                scrap: Yup.number().required('Scrap is required'),
                conversionLoss: Yup.number().required('Conversion loss is required'),
                toolConsumption: Yup.number().required('Tool consumption is required'),
                toolRate: Yup.number().required('Tool rate is required'),
                earnHours: Yup.number().required('Energy hours is required'),
                energyRate: Yup.number().required('Energy rate is required'),
            })}

            //initial call to backend
            onSubmit={(fiscalMonth, reportDate, scrap, conversionLoss, toolConsumption, toolRate, earnHours, energyRate) => {

            axios({
                method: 'post',
                url: `http://${config.host}:${config.port}/api/entries/cost/update`,
                headers: {'Content-Type': 'application/json; charset=utf-8'}, 
                data: {
                    reportDate: reportDate,
                    fiscalMonth: fiscalMonth,
                    scrap: scrap,
                    conversionLoss: conversionLoss,
                    toolConsumption: toolConsumption,
                    toolRate: toolRate,
                    earnHours: earnHours, 
                    energyRate: energyRate
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
                                        label="Scrap amount"
                                        name="scrap"
                                        onChange={handleChange}
                                        required
                                        value={values.scrap}
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
                                        label="Conversion loss"
                                        name="conversionLoss"
                                        onChange={handleChange}
                                        required
                                        value={values.conversionLoss}
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
                                        label="Daily tool consumption"
                                        name="toolConsumption"
                                        onChange={handleChange}
                                        required
                                        value={values.toolConsumption}
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
                                        label="Tool rate"
                                        name="toolRate"
                                        onChange={handleChange}
                                        required
                                        value={values.toolRate}
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
                                        label="Earn hours"
                                        name="earnHours"
                                        onChange={handleChange}
                                        required
                                        value={values.earnHours}
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
                                        label="Energy rate"
                                        name="energyRate"
                                        onChange={handleChange}
                                        required
                                        value={values.energyRate}
                                        variant="outlined"
                                    >
                                    </TextField>
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