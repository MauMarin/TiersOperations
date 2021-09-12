
import * as Yup from 'yup';
import { Formik } from 'formik';

// import AdapterDateFns from '@material-ui/lab/AdapterDateFns';
// import LocalizationProvider from '@material-ui/lab/LocalizationProvider';
// import DatePicker from '@material-ui/lab/DatePicker';

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
                evaluation6S: '',
                trainingOnTime: '',
                completedOnTime: ''
            }}
            validationSchema={Yup.object().shape({
                createdBy: Yup.number().required('userID is required'),
                reportDate: Yup.date().required('Report date is required'),
                evaluation6S: Yup.number().required('Scrap is required'),
                trainingOnTime: Yup.number().required('Conversion loss is required'),
                completedOnTime: Yup.number().required('Tool consumption is required')
            })}

            //initial call to backend
            onSubmit={(reportDate, evaluation6S, trainingOnTime, completedOnTime) => {

            axios({
                method: 'post',
                url: `http://${config.host}:${config.port}/api/entries/opex/insert`,
                headers: {'Content-Type': 'application/json; charset=utf-8'}, 
                data: {
                    reportDate: reportDate,
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
                            title="New OpEx Entry"
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