import { Helmet } from 'react-helmet';
import { Box, Button, Container } from '@material-ui/core';

import SafetyResults from '../components/entries/safety/SafetyResults';
import axios from 'axios';
import { useState, useEffect } from 'react';
import Popup from '../components/entries/safety/Popup'

export default function SafetyEntryList(props){

  const [isLoading, setLoading] = useState(true);
  const [entries, setEntries] = useState({});
  const [openPopup, setOpenPopup] = useState(false);


  useEffect(() => {
    axios.post("http://localhost:8080/api/entries/safety/allEntries").then(response => {
        console.log(response.data)
        setEntries(response.data)
      });
    setLoading(false)
  }, []);

  if (isLoading) {
    return <div className="App">Loading...</div>;
  }

  return (
    <>
    <Helmet>
      <title>Safety Entries</title>
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
            onClick={() => setOpenPopup(true)}
          >
            Add new
          </Button>


        </Box>

        {entries.length > 0 ? (
          <Box sx={{ pt: 3 }}>
            <SafetyResults customers={entries} />
          </Box>
        ) : (<Box></Box>)}
      </Container>
    </Box>

    <Popup
      openPopup={openPopup}
      setOpenPopup={setOpenPopup}
    >

    </Popup>
  </>
  )
};
