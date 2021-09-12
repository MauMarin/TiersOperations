import { Helmet } from 'react-helmet';
import { Box, Button, Card, CardHeader, Container } from '@material-ui/core';

import ServiceResults from '../components/entries/service/ServiceResults';
import axios from 'axios';
import { useState, useEffect } from 'react';
import Popup from '../components/entries/service/Popup'

import Cookies from 'universal-cookie';

var state = true;

const config = require('../config');

export default function ServiceEntriesList(props){

  const [isLoading, setLoading] = useState(true);
  const [entries, setEntries] = useState({});
  const [openPopup, setOpenPopup] = useState(false);

  useEffect(() => {
    axios.post(`http://${config.host}:${config.port}/api/entries/service/allEntries`).then(response => {
        setEntries(response.data)
      });
      const cookie = new Cookies();
    const { role } = cookie.get('userData');
    if(role > 1) state = false;
    setLoading(false)
  }, []);

  if (isLoading) {
    return <div className="App">Loading...</div>;
  }

  return (
    <>
    <Helmet>
      <title>Service Entries</title>
    </Helmet>

    <Card>

      <CardHeader
          subheader="Submit and veiw Service-related data"
          title="Service"
        />

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
            disabled={state}
            onClick={() => setOpenPopup(true)}
          >
            Add new
          </Button>


        </Box>

        {entries.length > 0 ? (
          <Box sx={{ pt: 3 }}>
            <ServiceResults customers={entries} />
          </Box>
        ) : (<Box></Box>)}
      </Container>
    </Box>

    <Popup
      openPopup={openPopup}
      setOpenPopup={setOpenPopup}
      type={1}
    >

    </Popup>
    </Card>
  </>
  )
};
