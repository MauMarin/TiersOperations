
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
                larOverall: '',
                larHumacao: '',
                larWarsaw: '',
                fly65: '',
                NCROpen: ''

            }}
            validationSchema={Yup.object().shape({
                createdBy: Yup.number().required('userID is required'),
                reportDate: Yup.date().required('Report date is required'),
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
                url: `http://${config.host}:${config.port}/api/entries/quality/insert`,
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
                            title="New Quality Entry"
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