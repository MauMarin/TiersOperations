
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

const config = require('../../../config');

const EntryForm = (props) => {

    const cookie = new Cookies();
    const { id } = cookie.get('userData');

    return (
        <Formik
            initialValues={{
                createdBy: id,
                reportDate: '',
                scrap: '',
                conversionLoss: '',
                toolConsumption: '',
                toolRate: '',
                earnHours: '',
                energyRate: '',
            }}
            validationSchema={Yup.object().shape({
                reportDate: Yup.date().required('Report date is required'),
                scrap: Yup.number().required('Scrap is required'),
                conversionLoss: Yup.number().required('Conversion loss is required'),
                toolConsumption: Yup.number().required('Tool consumption is required'),
                toolRate: Yup.number().required('Tool rate is required'),
                earnHours: Yup.number().required('Energy hours is required'),
                energyRate: Yup.number().required('Energy rate is required'),
            })}

            //initial call to backend
            onSubmit={(reportDate, scrap, conversionLoss, toolConsumption, toolRate, earnHours, energyRate) => {

            axios({
                method: 'post',
                url: `http://${config.host}:${config.port}/api/entries/cost/insert`,
                headers: {'Content-Type': 'application/json; charset=utf-8'}, 
                data: {
                    reportDate: reportDate,
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