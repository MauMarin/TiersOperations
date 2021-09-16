import { Helmet } from 'react-helmet';
import { Box, Button, Card, CardHeader, Container } from '@material-ui/core';

import SafetyResults from '../components/entries/safety/SafetyResults';
import axios from 'axios';
import { useState, useEffect } from 'react';
import Popup from '../components/entries/safety/Popup'

import Cookies from 'universal-cookie';

var state = true;

const config = require('../config');

export default function SafetyEntryList(props){

  // Si es verdadero, se muestra un texto en vez del componente. Se pone mientras se carga la información
  const [isLoading, setLoading] = useState(true);

  // La información de los entries
  const [entries, setEntries] = useState({});

  // Define si se muestra el popup o no
  const [openPopup, setOpenPopup] = useState(false);

  useEffect(() => {

    // Llamado al API para conseguir todas los entries de safety
    axios.post(`http://${config.host}:${config.port}/api/entries/safety/allEntries`).then(response => {
        setEntries(response.data)
      });
    
    // Carga la cookie y saca de ella el rol del usuario. En base a esto define si se deshabilita el botón de "New Card"
    const cookie = new Cookies();

    // Extra el rol para saber los permisos del mismo
    const { role } = cookie.get('userData');

    // Si el rol es mayor a 1, osea, cualquiera menos guest, habilita el botón
    if(role > 1) state = false;

    // Cambia el estado de loading para que se muestre el componente
    setLoading(false);
  }, []);

  if (isLoading) {
    return <div className="App">Loading...</div>;
  }

  return (
    <>
    <Helmet>
      <title>Safety Entries</title>
    </Helmet>

    <Card>

      <CardHeader
          subheader="Submit and veiw Safety-related data"
          title="Safety"
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
            <SafetyResults customers={entries} />
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
