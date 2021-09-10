
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

const EntryForm = ({data}) => {

    const [isLoading, setLoading] = useState(true);
    const [entry, setEntry] = useState({});

    useEffect(() => {
        axios({
            method: 'post',
            url: 'http://localhost:8080/api/entries/quality/select',
            headers: {'Content-Type': 'application/json; charset=utf-8'}, 
            data: {
                idEntry: data
            }
        })
        .then((response) => {
            setEntry(response.data.QualityEntry)
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

                larOverall: entry.larOverall,
                larHumacao: entry.larHumacao,
                larWarsaw: entry.larWarsaw,
                fly65: entry.fly65,
                NCROpen: entry.NCROpen
            }}
            validationSchema={Yup.object().shape({
                fiscalYear: Yup.string().required('Fiscal year date is required'),
                fiscalMonth: Yup.string().required('Fiscal month date is required'),
                reportDate: Yup.date().required('Report date is required'),
                createdBy: Yup.number().required('userID is required'),
                larOverall: Yup.number().required('Scrap is required'),
                larWarsaw: Yup.number().required('Conversion loss is required'),
                larHumacao: Yup.number().required('Tool consumption is required'),
                fly65: Yup.number().required('Tool consumption is required'),
                NCROpen: Yup.number().required('Tool consumption is required')
            })}

            //initial call to backend
            onSubmit={(reportDate, larOverall, larHumacao, larWarsaw, fly65, NCROpen) => {

            axios({
                method: 'post',
                url: 'http://localhost:8080/api/entries/quality/update',
                headers: {'Content-Type': 'application/json; charset=utf-8'}, 
                data: {
                    reportDate: reportDate,
                    larOverall: larOverall, 
                    larHumacao: larHumacao,
                    larWarsaw: larWarsaw,
                    fly65: fly65,
                    NCROpen: NCROpen
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
                                        label="Lot Acceptance Rate - Overall"
                                        name="larOverall"
                                        onChange={handleChange}
                                        required
                                        value={values.larOverall}
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
                                        label="Lot Acceptance Rate - Humacao"
                                        name="larHumacao"
                                        onChange={handleChange}
                                        required
                                        value={values.larHumacao}
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
                                        label="Lot Acceptance Rate - Warsaw"
                                        name="larWarsaw"
                                        onChange={handleChange}
                                        required
                                        value={values.larWarsaw}
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
                                        label="FPY OP65"
                                        name="fly65"
                                        onChange={handleChange}
                                        required
                                        value={values.fly65}
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
                                        label="NCRs Open"
                                        name="NCROpen"
                                        onChange={handleChange}
                                        required
                                        value={values.NCROpen}
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