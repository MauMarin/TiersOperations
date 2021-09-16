
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

import { useEffect, useState } from 'react';

const config = require('../../../config');

const monthP = [
    {
        value: '',
        label: ''
    },{
        value: "P1",
        label: 'P1'
    }, {
        value: "P2",
        label: 'P2'
    },{
        value: "P3",
        label: 'P3'
    },{
        value: "P4",
        label: 'P4'
    },{
        value: "P5",
        label: 'P5'
    },{
        value: "P6",
        label: 'P6'
    },{
        value: "P7",
        label: 'P7'
    },{
        value: "P8",
        label: 'P8'
    },{
        value: "P9",
        label: 'P9'
    },{
        value: "P10",
        label: 'P10'
    },{
        value: "P11",
        label: 'P11'
    },{
        value: "P12",
        label: 'P12'
    },
];

const EntryForm = ({data}) => {

    const [isLoading, setLoading] = useState(true);
    const [goal, setGoal] = useState({});

    useEffect(() => {
        axios({
            method: 'post',
            url: `http://${config.host}:${config.port}/api/goals/cost/select`,
            headers: {'Content-Type': 'application/json; charset=utf-8'}, 
            data: {
                idGoal: data
            }
        })
        .then((response) => {
            setGoal(response.data.CostEntry)
            console.log(response.data.CostEntry)
            setLoading(false);
        });
      }, [data]);

      if (isLoading) {
        return <div className="App">Loading...</div>;
      }

    return (
        <Formik
            initialValues={{
                idGoal: goal.id,
                depID: goal.depID,
                fiscalYear: goal.fiscalYear,
                fiscalMonth: goal.fiscalMonth,
                scrap: goal.scrap,
                conversionLoss: goal.conversionLoss,
                toolConsumption: goal.toolConsumption,
                toolRate: goal.toolRate,
                earnHours: goal.earnHours,
                energyRate: goal.energyRate,
            }}
            validationSchema={Yup.object().shape({
                scrap: Yup.number().required('Scrap is required'),
                conversionLoss: Yup.number().required('Conversion loss is required'),
                toolConsumption: Yup.number().required('Tool consumption is required'),
                toolRate: Yup.number().required('Tool rate is required'),
                earnHours: Yup.number().required('Energy hours is required'),
                energyRate: Yup.number().required('Energy rate is required'),
            })}

            //initial call to backend
            onSubmit={(scrap, conversionLoss, toolConsumption, toolRate, earnHours, energyRate) => {

            axios({
                method: 'post',
                url: `http://${config.host}:${config.port}/api/goals/cost/update`,
                headers: {'Content-Type': 'application/json; charset=utf-8'}, 
                data: {
                    depID: 1,
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
                            title="Update Cost Goal"
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
                                        select
                                        SelectProps={{ native: true }}
                                        value={values.depID}
                                        variant="outlined"
                                    >
                                        {monthP.map((option) => (
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