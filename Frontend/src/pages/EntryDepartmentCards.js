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

export default function DepartmentCards({section}) {

  const [isLoading, setLoading] = useState(true);
  const [entries, setEntries] = useState();

  console.log(section);

  useEffect(() => {
    axios.get("http://localhost:8080/api/department/allDepartments").then(response => {
      console.log(response.data)
      setEntries(response.data)
      setLoading(false);
    });
  }, []);


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
