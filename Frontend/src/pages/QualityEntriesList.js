import { Helmet } from 'react-helmet';
import { Box, Button, Container } from '@material-ui/core';

import QualityResults from '../components/entries/quality/QualityResults';
import axios from 'axios';
import { useState, useEffect } from 'react';
import Popup from '../components/entries/quality/Popup'


export default function QualityList(props) {

  const [isLoading, setLoading] = useState(true);
  const [entries, setEntries] = useState({});
  const [openPopup, setOpenPopup] = useState(false);

  useEffect(() => {
    axios.post("http://localhost:8080/api/entries/quality/allEntries").then(response => {
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
        <title>Quality Entries</title>
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
              <QualityResults customers={entries} />
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
