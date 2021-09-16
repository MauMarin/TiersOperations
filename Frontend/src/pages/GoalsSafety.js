import { Helmet } from 'react-helmet';
import { Box, Button, Card, CardHeader, Container } from '@material-ui/core';

import EntryResults from '../components/goals/safety/SafetyResults';
import axios from 'axios';
import { useState, useEffect } from 'react';
import CostPopup from '../components/goals/safety/Popup';

const config = require('../config');

export default function CostEntryList(props) {

  // Si es verdadero, se muestra un texto en vez del componente. Se pone mientras se carga la información
  const [isLoading, setLoading] = useState(true);

  // La información de los entries
  const [entries, setEntries] = useState({});

  // Define si se muestra el popup o no
  const [openPopup, setOpenPopup] = useState(false);

  useEffect(() => {

    // Llamado al API para conseguir todas los goals de safety
    axios.post(`http://${config.host}:${config.port}/api/goals/safety/allGoals`).then(response => {
        setEntries(response.data)
      });

    // Cambia el estado de loading para que se muestre el componente
    setLoading(false);
  }, []);

  if (isLoading) {
    return <div className="App">Loading...</div>;
  }

  return (
    <>
      <Helmet>
        <title>Safety Goals</title>
      </Helmet>

      <Card>

      <CardHeader
          subheader="Submit and veiw Safety-related goals"
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
