
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

const EntryForm = (props) => {

    return (
        <Formik
            initialValues={{
                tier: '',
                createdBy: '',
                reportDate: '',
                HOs: '',
                TRIR: '',
                firstAid: '',
                nearMiss: ''
            }}
            validationSchema={Yup.object().shape({
                tier: Yup.number().required('Tier is required'),
                createdBy: Yup.number().required('userID is required'),
                reportDate: Yup.string().required('Report date is required'),
                HOs: Yup.number().required('Scrap is required'),
                TRIR: Yup.number().required('Conversion loss is required'),
                firstAid: Yup.number().required('Tool consumption is required'),
                nearMiss: Yup.number().required('Tool consumption is required')
            })}

            //initial call to backend
            onSubmit={(tier, createdBy, reportDate, HOs, TRIR, firstAid, nearMiss) => {

            axios({
                method: 'post',
                url: 'http://localhost:8080/api/entries/safety/insert',
                headers: {'Content-Type': 'application/json; charset=utf-8'}, 
                data: {
                    tier: tier,
                    createdBy: createdBy, 
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
                                        type="number"
                                        fullWidth
                                        label="Tier"
                                        name="tier"
                                        onChange={handleChange}
                                        required
                                        value={values.tier}
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
                                        label="User ID"
                                        name="createdBy"
                                        onChange={handleChange}
                                        required
                                        value={values.createdBy}
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
                                        label="Report date"
                                        name="reportDate"
                                        onChange={handleChange}
                                        required
                                        value={values.reportDate}
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