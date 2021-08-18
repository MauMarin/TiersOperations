import { Helmet } from 'react-helmet';
import { Box, Container } from '@material-ui/core';
import EntriesToolbar from '../components/entries/EntryToolbar';
import QualityResults from '../components/entries/QualityResults';
//import customers from '../__mocks__/OpExPlaceholder';
import axios from 'axios';
import { useState, useEffect } from 'react';

export default function OpExEntryList(){

  const [isLoading, setLoading] = useState(true);
  const [entries, setEntries] = useState();

  useEffect(() => {
    const depID = 1;
    axios.post("http://localhost:8080/api/entries/quality/allEntries", {depID}).then(response => {
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
            <QualityResults customers={entries} />
        </Box>
      </Container>
    </Box>
  </>
  )
};
