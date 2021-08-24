import React from 'react';

import {
    Box,
    Button,
    Card,
    CardContent,
    CardHeader,
    Divider,
    FormControlLabel,
    FormHelperText,
    Grid,
    Radio,
    RadioGroup
} from '@material-ui/core';

import axios from 'axios';

export default function CardSelector(props) {

    const [value, setValue] = React.useState('');
    const [helperText, setHelperText] = React.useState('');

    const handleRadioChange = (event) => {
        setValue(event.target.value);
      };

      const handleSubmit = (event) => {
        event.preventDefault();
        console.log(value)
        if (value === 'green' || value === 'yellow' || value === 'red') {
            axios.post("http://localhost:8080/api/cards/getByStatus", {"status":value}).then(response => {
                console.log(response.data)
            });
        } else {
          setHelperText('Please select an option.');
        }
      };

    return (
        <form onSubmit={handleSubmit} {...props}>
            <Card>
                <CardHeader
                    subheader="Select card status"
                    title="Cards"
                />
                <Divider />
                <CardContent>
                    <Grid
                        container
                        spacing={6}
                        wrap="wrap"
                    >
                        <Grid
                            item
                            md={4}
                            sm={6}
                            sx={{
                                display: 'flex'
                            }}
                            xs={12}
                        >    
                            <RadioGroup value={value} onChange={handleRadioChange}>
                                <FormControlLabel value="green" control={<Radio />} label="Green status" />
                                <FormControlLabel value="yellow" control={<Radio />} label="Yellow status" />
                                <FormControlLabel value="red" control={<Radio />} label="Red status" />
                            </RadioGroup>
                        </Grid>
                    </Grid>
                    <FormHelperText>{helperText}</FormHelperText>
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
                        type="submit"
                    >
                        View Status
                    </Button>
                </Box>
            </Card>
        </form>
    );
}
