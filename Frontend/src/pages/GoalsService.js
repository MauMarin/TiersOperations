import { Helmet } from 'react-helmet';
import { Box, Button, Card, CardHeader, Container } from '@material-ui/core';

import EntryResults from '../components/goals/service/ServiceResults';
import axios from 'axios';
import { useState, useEffect } from 'react';
import CostPopup from '../components/goals/service/Popup';

const config = require('../config');

export default function CostEntryList(props) {

  const [isLoading, setLoading] = useState(true);
  const [entries, setEntries] = useState({});
  const [openPopup, setOpenPopup] = useState(false);


  useEffect(() => {
    axios.post(`http://${config.host}:${config.port}/api/goals/service/allGoals`).then(response => {
        console.log(response.data)
        setEntries(response.data)
      });
    setLoading(false);
  }, []);

  if (isLoading) {
    return <div className="App">Loading...</div>;
  }

  return (
    <>
      <Helmet>
        <title>Service Goals</title>
      </Helmet>

      <Card>

      <CardHeader
          subheader="Submit and veiw Service-related goals"
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
        type={1}
      >

      </CostPopup>
      </Card>
    </>
  )
};