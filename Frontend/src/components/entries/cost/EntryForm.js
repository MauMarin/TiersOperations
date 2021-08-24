import { useState } from 'react';
import { Link as RouterLink, useNavigate } from 'react-router-dom';
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

// import DatePicker from '@material-ui/lab/DatePicker';
// import LocalizationProvider from '@material-ui/lab/LocalizationProvider';
// import AdapterDateFns from '@material-ui/lab/AdapterDateFns';

const EntryForm = (props) => {

    return (
        <Formik
            initialValues={{
                scrap: '',
                conversionLoss: '',
                toolConsumption: '',
                toolRate: '',
                earnHours: '',
                energyRate: '',
                reportDate: ''
            }}
            validationSchema={Yup.object().shape({
                scrap: Yup.string().required('Scrap is required'),
                conversionLoss: Yup.string().required('Conversion loss is required'),
                toolConsumption: Yup.string().required('Tool consumption is required'),
                toolRate: Yup.string().required('Tool rate is required'),
                earnHours: Yup.string().required('Energy hours is required'),
                energyRate: Yup.string().required('Energy rate is required'),
                reportDate: Yup.date().required('Report date is required')
            })}

            //initial call to backend
            onSubmit={(scrap, conversionLoss, toolConsumption, toolRate, earnHours, energyRate) => {
                //axios.post('localhost:8080/api/entries/cost/insert')
                console.log(scrap, conversionLoss, toolConsumption, toolRate, earnHours, energyRate);
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

                                <Grid
                                    item
                                    md={6}
                                    xs={12}
                                >
                                    {/* <LocalizationProvider dateAdapter={AdapterDateFns}>
                                    <DatePicker
                                        disableFuture
                                        label="Report date"
                                        openTo="year"
                                        views={['year', 'month', 'day']}
                                        value={values.reportDate}
                                        onChange={handleChange}
                                        renderInput={(params) => <TextField {...params} />}
                                    />
                                    </LocalizationProvider> */}
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


/*
<form
            autoComplete="off"
            noValidate
            {...props}
        >
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

                        <Grid
                            item
                            md={6}
                            xs={12}
                        >

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
                        variant="contained"
                    >
                        Submit
                    </Button>
                </Box>
            </Card>
        </form>
 */