import { Helmet } from 'react-helmet';

import {
  Box,
  Button,
  Card,
  CardContent,
  CardHeader,
  Container,
  Divider,
  FormControlLabel,
  FormHelperText,
  Grid,
  Radio,
  RadioGroup
} from '@material-ui/core';


import axios from 'axios';
import { useState, useEffect } from 'react';

export default function CostEntryList(props) {

  useEffect(() => {
    setLoading(false);
  }, []);

  const [value, setValue] = useState('');
  const [helperText, setHelperText] = useState('');

  const [isLoading, setLoading] = useState(true);
  const [entries, setEntries] = useState({});

  const handleRadioChange = (event) => {
    setValue(event.target.value);
  };

  const handleSubmit = (event) => {
    event.preventDefault();
    console.log(value)
    if (value === 'green' || value === 'yellow' || value === 'red') {
      axios.post("http://localhost:8080/api/cards/getByStatus", { "status": value }).then(response => {
        console.log(response.data)
        setEntries(response.data)
      });
    } else {
      setHelperText('Please select an option.');
    }
  };

  useEffect(() => {
    setLoading(false);
  }, []);

  if (isLoading) {
    return <div className="App">Loading...</div>;
  }

  return (
    <>
      <Helmet>
        <title>Cards</title>
      </Helmet>
      <Box
        sx={{
          backgroundColor: 'background.default',
          minHeight: '100%',
          py: 3
        }}
      >
        <Container maxWidth="lg">


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
                  View Cards
                </Button>
              </Box>
            </Card>
          </form>

          {entries.length > 0 ? (
            <Box sx={{ pt: 3 }}>

            </Box>
          ) : (<Box></Box>)}

          

        </Container>
      </Box>
    </>
  )
};

// CostEntryList;
