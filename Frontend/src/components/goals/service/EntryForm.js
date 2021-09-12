
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

const config = require('../../../config');



// const week = [
//     {
//         value: '',
//         label: ''
//     },{
//         value: 1,
//         label: 'Week 1'
//     }, {
//         value: 2,
//         label: 'Week 2'
//     }, {
//         value: 3,
//         label: 'Week 3'
//     }, {
//         value: 4,
//         label: 'Week 4'
//     }, {
//         value: 5,
//         label: 'Week 5'
//     },
// ];

// <Grid
// item
// md={6}
// xs={12}
// >
// <TextField
//     fullWidth
//     label="Week"
//     name="week"
//     onChange={handleChange}
//     required
//     select
//     SelectProps={{ native: true }}
//     value={values.status}
//     variant="outlined"
// >
//     {week.map((option) => (
//         <option
//             key={option.value}
//             value={option.value}
//         >
//             {option.label}
//         </option>
//     ))}
// </TextField>
// </Grid>

const EntryForm = (props) => {

    return (
        <Formik
            initialValues={{
                op20: '',
                op40: '',
                op60: '',
                op65: '',
                op70: '',
                intervention: '',
                OEE: ''
            }}
            validationSchema={Yup.object().shape({
                op20: Yup.number().required('Scrap is required'),
                op40: Yup.number().required('Conversion loss is required'),
                op60: Yup.number().required('Tool consumption is required'),
                op65: Yup.number().required('Tool consumption is required'),
                op70: Yup.number().required('Tool consumption is required'),
                intervention: Yup.number().required('Tool consumption is required'),
                OEE: Yup.number().required('Tool consumption is required')
            })}

            //initial call to backend
            onSubmit={(op20, op40, op60, op65, op70, intervention, OEE) => {

            axios({
                method: 'post',
                url: `http://${config.host}:${config.port}/api/goals/service/insert`,
                headers: {'Content-Type': 'application/json; charset=utf-8'}, 
                data: {
                    depID: 5,
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
                            title="New Service Goal"
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