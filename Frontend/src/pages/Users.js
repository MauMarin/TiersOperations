import { Helmet } from 'react-helmet';
import { Box, Button, Container } from '@material-ui/core';


import UserResults from '../components/users/UserResults';
import axios from 'axios';
import { useState, useEffect } from 'react';
import UserPopup from '../components/users/UserPopup'

const config = require('../config');

export default function Users(props){

  const [isLoading, setLoading] = useState(true);
  const [entries, setEntries] = useState();
  const [openPopup, setOpenPopup] = useState(false);

  useEffect(() => {
    const depID = 1;
    axios.post(`http://${config.host}:${config.port}/api/users/getAll`, {depID}).then(response => {
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
      <title>Users</title>
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
              Add new user
            </Button>


          </Box>

        <Box sx={{ pt: 3 }}>
            <UserResults customers={entries} />
        </Box>
      </Container>
    </Box>

    <UserPopup
        openPopup={openPopup}
        setOpenPopup={setOpenPopup}
      >

      </UserPopup>

  </>
  )
};
