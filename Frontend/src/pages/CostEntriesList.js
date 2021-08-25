import { Helmet } from 'react-helmet';
import { Box, Button, Container } from '@material-ui/core';

import EntryResults from '../components/entries/cost/CostEntry';
import axios from 'axios';
import { useState, useEffect } from 'react';
import CostPopup from '../components/entries/cost/CostPopup';

import {
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

export default function CostEntryList(props) {

  const [isLoading, setLoading] = useState(true);
  const [entries, setEntries] = useState({});
  const [openPopup, setOpenPopup] = useState(false);

  const [value, setValue] = useState('');
  const [helperText, setHelperText] = useState('');

  const handleRadioChange = (event) => {
    setValue(event.target.value);
  };

  const handleSubmit = (event) => {
    event.preventDefault();
    console.log(value)
    if (value === '2' || value === '3') {
      axios.post("http://localhost:8080/api/entries/cost/allEntries", { tier: value }).then(response => {
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
        <title>Entries</title>
      </Helmet>

      <Box
        sx={{
          py: 3
        }}
      >
        <Container maxWidth="lg">
          <Box sx={{ pt: 3 }}>
            <form onSubmit={handleSubmit} {...props}>
              <Card>
                <CardHeader
                  subheader="Select tier to visualize"
                  title="Tier"
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
                        <FormControlLabel value="2" control={<Radio />} label="Tier 2" />
                        <FormControlLabel value="3" control={<Radio />} label="Tier 3" />
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
                    View Tier
                  </Button>
                </Box>
              </Card>
            </form>
          </Box>
        </Container>
      </Box>

      <Box
        sx={{
          backgroundColor: 'background.default',
          minHeight: '100%',
          py: 3
        }}
      >
        <Container maxWidth={false}>
          <Box
            sx={{
              display: 'flex',
              justifyContent: 'flex-end'
            }}
          >

            <Button
              color="primary"
              variant="contained"
              onClick={() => setOpenPopup(true)}
            >
              Add new
            </Button>


          </Box>

          {entries.length > 0 ? (
            <Box sx={{ pt: 3 }}>
              <EntryResults customers={entries} />
            </Box>
          ) : (<Box></Box>)}
        </Container>
      </Box>

      <CostPopup
        openPopup={openPopup}
        setOpenPopup={setOpenPopup}
      >

      </CostPopup>
    </>
  )
};

// CostEntryList;
