
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
            url: 'http://localhost:8080/api/entries/safety/select',
            headers: {'Content-Type': 'application/json; charset=utf-8'}, 
            data: {
                idEntry: data
            }
        })
        .then((response) => {
            setEntry(response.data.SafetyEntry)
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

                HOs: entry.HOs,
                TRIR: entry.TRIR,
                firstAid: entry.firstAid,
                nearMiss: entry.nearMiss
            }}
            validationSchema={Yup.object().shape({
                fiscalYear: Yup.string().required('Fiscal year date is required'),
                fiscalMonth: Yup.string().required('Fiscal month date is required'),
                reportDate: Yup.date().required('Report date is required'),
                createdBy: Yup.number().required('userID is required'),
                HOs: Yup.number().required('Scrap is required'),
                TRIR: Yup.number().required('Conversion loss is required'),
                firstAid: Yup.number().required('Tool consumption is required'),
                nearMiss: Yup.number().required('Tool consumption is required')
            })}

            //initial call to backend
            onSubmit={(reportDate, HOs, TRIR, firstAid, nearMiss) => {

            axios({
                method: 'post',
                url: 'http://localhost:8080/api/entries/safety/update',
                headers: {'Content-Type': 'application/json; charset=utf-8'}, 
                data: {
                    reportDate: reportDate,
                    HOs: HOs,
                    TRIR: TRIR,
                    firstAid: firstAid,
                    nearMiss: nearMiss
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
                                        label="HOs"
                                        name="HOs"
                                        onChange={handleChange}
                                        required
                                        value={values.HOs}
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
                                        label="TRIR"
                                        name="TRIR"
                                        onChange={handleChange}
                                        required
                                        value={values.TRIR}
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
                                        label="First Aid"
                                        name="firstAid"
                                        onChange={handleChange}
                                        required
                                        value={values.firstAid}
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
                                        label="Near Miss"
                                        name="nearMiss"
                                        onChange={handleChange}
                                        required
                                        value={values.nearMiss}
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