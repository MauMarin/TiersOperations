import { Helmet } from 'react-helmet';
import { Box, Button, Container } from '@material-ui/core';


import UserResults from '../components/users/UserResults';
import axios from 'axios';
import { useState, useEffect } from 'react';
import UserPopup from '../components/users/UserPopup'

const config = require('../config');

export default function Users(props){

  // Si es verdadero, se muestra un texto en vez del componente. Se pone mientras se carga la información
  const [isLoading, setLoading] = useState(true);

  // La información de los entries
  const [entries, setEntries] = useState({});

  // Define si se muestra el popup o no
  const [openPopup, setOpenPopup] = useState(false);

  useEffect(() => {

    // Llamado al API para conseguir la ifnormación de todos los usuarios
    axios.post(`http://${config.host}:${config.port}/api/users/getAll`).then(response => {
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
