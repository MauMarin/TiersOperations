import { Helmet } from 'react-helmet';
import { Box, Button, Card, CardHeader, Container } from '@material-ui/core';

import EntryResults from '../components/goals/opex/OpExResults';
import axios from 'axios';
import { useState, useEffect } from 'react';
import CostPopup from '../components/goals/opex/Popup';

const config = require('../config');

export default function CostEntryList(props) {

  // Si es verdadero, se muestra un texto en vez del componente. Se pone mientras se carga la información
  const [isLoading, setLoading] = useState(true);

  // La información de los entries
  const [entries, setEntries] = useState({});

  // Define si se muestra el popup o no
  const [openPopup, setOpenPopup] = useState(false);


  useEffect(() => {

    // Llamado al API para conseguir todos los goals de opex
    axios.post(`http://${config.host}:${config.port}/api/goals/opex/allGoals`).then(response => {
        // Asigna el valor obtenido de la base de datos a la variable entries
        setEntries(response.data)
      });

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
        <title>OpEx Goals</title>
      </Helmet>

      <Card>

      <CardHeader
          subheader="Submit and veiw OpEx-related goals"
          title="OpEx"
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

// CostEntryList;
