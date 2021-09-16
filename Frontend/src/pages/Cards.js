import { Helmet } from 'react-helmet';

import {
  Box,
  Button,
  Card,
  CardContent,
  CardHeader,
  Container,
  Divider,
  FormControlLabel,
  FormHelperText,
  Grid,
  Radio,
  RadioGroup
} from '@material-ui/core';


import axios from 'axios';
import { useState, useEffect } from 'react';

import CardsDisplay from '../components/cards/CardsDisplay'
import CostPopup from '../components/cards/Popup';

import Cookies from 'universal-cookie';

const config = require('../config');

var state = true;

export default function CostEntryList(props) {

  // Variables utilizadas para componentes
  
  // El valor del checkbox
  const [value, setValue] = useState('');

  // Texto que aparece cuando no se selecciona nada
  const [helperText, setHelperText] = useState('');

  // Si es verdadero, se muestra un texto en vez del componente. Se pone mientras se carga la información
  const [isLoading, setLoading] = useState(true);

  // La información de las cartas
  const [entries, setEntries] = useState({});

  // Color que entra por parámetro para hacer la búsqueda dentro de la DB
  const [color, setColor] = useState();

  // Define si se muestra el popup o no
  const [openPopup, setOpenPopup] = useState(false);

  // Se llama cuando hay un cambio en los checkbox
  const handleRadioChange = (event) => {
    setValue(event.target.value);
  };

  // Llama a la base de datos y retorna los valores de las cartas dado el color
  const handleSubmit = (event) => {
    event.preventDefault();
    if (value === 'green' || value === 'yellow' || value === 'red') {
      axios.post(`http://${config.host}:${config.port}/api/cards/getByStatus`, { "status": value }).then(response => {
        setEntries(response.data)
        setColor(value)
      });
    } else {
      setHelperText('Please select an option.');
    }
  };

  // Carga al inicio de la página
  useEffect(() => {
    // Carga la cookie y saca de ella el rol del usuario. En base a esto define si se deshabilita el botón de "New Card"
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
        <title>Cards</title>
      </Helmet>
      <Box
        sx={{
          backgroundColor: 'background.default',
          minHeight: '100%',
          py: 3
        }}
      >
        <Container maxWidth={false}>

          <form onSubmit={handleSubmit} {...props}>
            <Card>
              <CardHeader
                subheader="Select card status"
                title="Cards"
              />
              <Divider />
              <CardContent>
                <Grid
                  container
                  spacing={6}
                  wrap="wrap"
                >
                  <Grid
                    item
                    md={4}
                    sm={6}
                    sx={{
                      display: 'flex'
                    }}
                    xs={12}
                  >
                    <RadioGroup value={value} onChange={handleRadioChange}>
                      <FormControlLabel value="green" control={<Radio />} label="Green status" />
                      <FormControlLabel value="yellow" control={<Radio />} label="Yellow status" />
                      <FormControlLabel value="red" control={<Radio />} label="Red status" />
                    </RadioGroup>
                  </Grid>
                </Grid>
                <FormHelperText>{helperText}</FormHelperText>
              </CardContent>
              <Divider />
              <Box
                sx={{
                  display: 'flex',
                  justifyContent: 'flex-end',
                  p: 2
                }}
              >
                <Button
                  color="primary"
                  variant="contained"
                  type="submit"
                >
                  View Cards
                </Button>
              </Box>
            </Card>
          </form>
        </Container>

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
              <CardsDisplay cards={entries} color={color} />
            </Box>
          ) : (<Box></Box>)}

        </Container>
      </Box>
      </Box>



      <CostPopup
        openPopup={openPopup}
        setOpenPopup={setOpenPopup}
        type={1}
      >

      </CostPopup>
    </>
  )
};

// CostEntryList;
