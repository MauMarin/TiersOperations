import { Helmet } from 'react-helmet';

import axios from 'axios';
import { useState, useEffect } from 'react';

import {
  Box,
  Container,
  Grid,
  Pagination
} from '@material-ui/core';
import DepartmentCard from '../components/department_cards/DepartmentCard';

const config = require('../config');

export default function DepartmentCards({section}) {

  // Si es verdadero, se muestra un texto en vez del componente. Se pone mientras se carga la información
  const [isLoading, setLoading] = useState(true);

  // La información de los entries
  const [entries, setEntries] = useState();

  useEffect(() => {

    // Llamado al API para conseguir todos los departamentos
    axios.get(`http://${config.host}:${config.port}/api/department/allDepartments`).then(response => {
      // Asigna el valor obtenido de la base de datos a la variable entries
      setEntries(response.data)

      // Cambia el estado de loading para que se muestre el componente
      setLoading(false);
    });
  }, []);

  // Mostrar esto mientras se hace un fetch a la base y muestran los componentes
  if (isLoading) {
    return <div className="App">Loading...</div>;
  }

  return(
  <>
    <Helmet>
      <title>Departments</title>
    </Helmet>
    <Box
      sx={{
        backgroundColor: 'background.default',
        minHeight: '100%',
        py: 3
      }}
    >
      <Container maxWidth={false}>
        
        <Box sx={{ pt: 3 }}>
          <Grid
            container
            spacing={3}
          >
            {entries.map((product) => (
              <Grid
                item
                key={product.id}
                lg={4}
                md={6}
                xs={12}
              >
                <DepartmentCard product={product} section={section} />
              </Grid>
            ))}
          </Grid>
        </Box>
        <Box
          sx={{
            display: 'flex',
            justifyContent: 'center',
            pt: 3
          }}
        >
          <Pagination
            color="primary"
            count={3}
            size="small"
          />
        </Box>
      </Container>
    </Box>
  </>
);
}
