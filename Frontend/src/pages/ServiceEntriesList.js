import { Helmet } from 'react-helmet';
import { Box, Container } from '@material-ui/core';
import EntriesToolbar from '../components/entries/EntryToolbar';
import ServiceResults from '../components/entries/ServiceResults';
//import customers from '../__mocks__/OpExPlaceholder';
import axios from 'axios';
import { useState, useEffect } from 'react';

export default function OpExEntryList(){

  const [isLoading, setLoading] = useState(true);
  const [entries, setEntries] = useState();

  useEffect(() => {
    const depID = 1;
    axios.post("http://localhost:8080/api/entries/service/allEntries", {depID}).then(response => {
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
      <title>Entries</title>
    </Helmet>
    <Box
      sx={{
        backgroundColor: 'background.default',
        minHeight: '100%',
        py: 3
      }}
    >
      <Container maxWidth={false}>
        <EntriesToolbar />
        <Box sx={{ pt: 3 }}>
            <ServiceResults customers={entries} />
        </Box>
      </Container>
    </Box>
  </>
  )
};
