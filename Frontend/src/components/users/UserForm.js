
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

const departments = [
    {
        value: '',
        label: ''
    },{
        value: 1,
        label: 'Cost'
    }, {
        value: 2,
        label: 'OpEx'
    }, {
        value: 3,
        label: 'Quality'
    }, {
        value: 4,
        label: 'Safety'
    }, {
        value: 5,
        label: 'Service'
    },
];

const roles = [
    {
        value: '',
        label: ''
    }, {
        value: 2,
        label: 'Default'
    }, {
        value: 3,
        label: 'Manager'
    }, {
        value: 4,
        label: 'Administrator'
    }
];


const EntryForm = (props) => {

    return (
        <Formik
            initialValues={{
                name: '',
                username: '',
                depID: '',
                role: '',
                password: ''
            }}
            validationSchema={Yup.object().shape({
                name: Yup.string().required('Name is required'),
                username: Yup.string().required('Username is required'),
                depID: Yup.number().required('Number is required'),
                role: Yup.number().required('Number is required'),
                password: Yup.string().required('Number is required'),
            })}

            //initial call to backend
            onSubmit={(name, username, depID, role, password) => {

                console.log(name, username, depID, role, password)

                axios({
                    method: 'post',
                    url: 'http://localhost:8080/api/users/insert',
                    headers: { 'Content-Type': 'application/json; charset=utf-8' },
                    data: {
                        name: name,
                        username: username,
                        depID: depID,
                        role: role,
                        password: password
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
                            title="New User"
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
                                        label="Name"
                                        name="name"
                                        onChange={handleChange}
                                        required
                                        value={values.name}
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
                                        label="Username"
                                        name="username"
                                        onChange={handleChange}
                                        required
                                        value={values.username}
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
                                        label="Department"
                                        name="depID"
                                        onChange={handleChange}
                                        required
                                        select
                                        type="number"
                                        SelectProps={{ native: true }}
                                        value={values.depID}
                                        variant="outlined"
                                    >
                                        {departments.map((option) => (
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
                                        fullWidth
                                        label="Role"
                                        name="role"
                                        onChange={handleChange}
                                        required
                                        select
                                        type="number"
                                        SelectProps={{ native: true }}
                                        value={values.role}
                                        variant="outlined"
                                    >
                                        {roles.map((option) => (
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
                                        fullWidth
                                        label="Password"
                                        name="password"
                                        onChange={handleChange}
                                        required
                                        value={values.password}
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