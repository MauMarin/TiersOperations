
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

const EntryForm = ({data}) => {

    const [isLoading, setLoading] = useState(true);
    const [entry, setEntry] = useState({});

    useEffect(() => {
        axios({
            method: 'post',
            url: `http://${config.host}:${config.port}/api/entries/service/select`,
            headers: {'Content-Type': 'application/json; charset=utf-8'}, 
            data: {
                idEntry: data
            }
        })
        .then((response) => {
            setEntry(response.data.ServiceEntry)
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
                
                createdDate: entry.createdDateH,

                op20: entry.op20,
                op40: entry.op40,
                op60: entry.op60,
                op65: entry.op65,
                op70: entry.op70,
                intervention: entry.intervention,
                OEE: entry.OEE
            }}
            validationSchema={Yup.object().shape({
                fiscalYear: Yup.string().required('Fiscal year date is required'),
                fiscalMonth: Yup.string().required('Fiscal month date is required'),
                reportDate: Yup.date().required('Report date is required'),
                createdBy: Yup.number().required('userID is required'),
                op20: Yup.number().required('Scrap is required'),
                op40: Yup.number().required('Conversion loss is required'),
                op60: Yup.number().required('Tool consumption is required'),
                op65: Yup.number().required('Tool consumption is required'),
                op70: Yup.number().required('Tool consumption is required'),
                intervention: Yup.number().required('Tool consumption is required'),
                OEE: Yup.number().required('Tool consumption is required')
            })}

            //initial call to backend
            onSubmit={(reportDate, op20, op40, op60, op65, op70, intervention, OEE) => {

            axios({
                method: 'post',
                url: `http://${config.host}:${config.port}/api/entries/service/update`,
                headers: {'Content-Type': 'application/json; charset=utf-8'}, 
                data: {
                    reportDate: reportDate,
                    op20: op20,
                    op40: op40,
                    op60: op60,
                    op65: op65,
                    op70:op70,
                    intervention: intervention,
                    OEE: OEE
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
                                    label="ID"
                                    name="id"
                                    onChange={handleChange}
                                    required
                                    disabled={true}
                                    value={values.id}
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
                                    value={values.fiscalMonth}
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
                                    fullWidth
                                    label="Created By"
                                    name="createdBy"
                                    onChange={handleChange}
                                    disabled={true}
                                    required
                                    value={values.createdBy}
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
                                    label="Created Date"
                                    name="createdDate"
                                    onChange={handleChange}
                                    disabled={true}
                                    required
                                    value={values.createdDate}
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
                                        label="Op20 Machining"
                                        name="op20"
                                        onChange={handleChange}
                                        required
                                        value={values.op20}
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
                                        label="Op40 Cleaning"
                                        name="op40"
                                        onChange={handleChange}
                                        required
                                        value={values.op40}
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
                                        label="Op60 Final Inspec / Deburring"
                                        name="op60"
                                        onChange={handleChange}
                                        required
                                        value={values.op60}
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
                                        label="Op65 FDV"
                                        name="op65"
                                        onChange={handleChange}
                                        required
                                        value={values.op65}
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
                                        label="Op70 Packaging"
                                        name="op70"
                                        onChange={handleChange}
                                        required
                                        value={values.op70}
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
                                        label="Maintenance Interventions"
                                        name="intervention"
                                        onChange={handleChange}
                                        required
                                        value={values.intervention}
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
                                        label="OEE"
                                        name="OEE"
                                        onChange={handleChange}
                                        required
                                        value={values.OEE}
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