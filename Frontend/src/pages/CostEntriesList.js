import { Helmet } from 'react-helmet';
import { Box, Button, Container } from '@material-ui/core';

import Popup from 'reactjs-popup';

import EntryResults from '../components/entries/cost/CostEntry';
import axios from 'axios';
import { useState, useEffect } from 'react';
import CostPopup from '../components/entries/cost/CostPopup';

export default function CostEntryList() {

  const [isLoading, setLoading] = useState(true);
  const [entries, setEntries] = useState();
  const [openPopup, setOpenPopup] = useState(false);

  useEffect(() => {
    const depID = 1;
    axios.post("http://localhost:8080/api/entries/cost/allEntries", { depID }).then(response => {
      console.log(response.data)
      setEntries(response.data)
      setLoading(false);
    });
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
              onClick = {() => setOpenPopup(true)}
            >
              Add new
            </Button>


          </Box>

          <Box sx={{ pt: 3 }}>
            <EntryResults customers={entries} />
          </Box>
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
