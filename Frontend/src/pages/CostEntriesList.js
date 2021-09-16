import { Helmet } from 'react-helmet';
import { Box, Button, Card, CardHeader, Container } from '@material-ui/core';

import axios from 'axios';
import { useState, useEffect } from 'react';

import CostPopup from '../components/entries/cost/CostPopup';
import EntryResults from '../components/entries/cost/CostEntry';

import Cookies from 'universal-cookie';

// Variable que define si un botón de deshabilita o no
var state = true;

const config = require('../config');

export default function CostEntryList(props) {

  // Variables utilizadas para componentes
    // Si es verdadero, se muestra un texto en vez del componente. Se pone mientras se carga la información
  const [isLoading, setLoading] = useState(true);

  // La información de los entries
  const [entries, setEntries] = useState({});

  // Define si se muestra el popup o no
  const [openPopup, setOpenPopup] = useState(false);


  useEffect(() => {
    // Llamado al API para conseguir todas las entradas de costo
    axios.post(`http://${config.host}:${config.port}/api/entries/cost/allEntries`).then(response => {
        // Asigna el valor obtenido de la base de datos a la variable entries
        setEntries(response.data)
    });

    // Carga la cookie y saca de ella el rol del usuario. En base a esto define si se deshabilita el botón de "New Cost Entry"
    const cookie = new Cookies();
    
    // Extra el rol para saber los permisos del mismo
    const { role } = cookie.get('userData');

    // Si el rol es mayor a 1, osea, cualquiera menos guest, habilita el botón
    if(role > 1) state = false;

    // Cambia el estado de loading para que se muestre el componente
    setLoading(false);
  }, []);

  // Mostrar esto mientras se hace un fetch a la base y muestran los componentes
  if (isLoading) {
    return <div className="App">Loading...</div>;
  }

  return (
    <>
      <Helmet>
        <title>Cost Entries</title>
      </Helmet>

      <Card>

      <CardHeader
          subheader="Submit and veiw cost-related data"
          title="Cost"
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
