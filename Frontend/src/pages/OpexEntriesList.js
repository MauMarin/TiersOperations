import { Helmet } from 'react-helmet';
import { Box, Container } from '@material-ui/core';
import EntriesToolbar from '../components/entries/EntryToolbar';
import OpExResults from '../components/entries/OpExResults';
import customers from '../__mocks__/OpExPlaceholder';

const OpExEntryList = () => (
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
            <OpExResults customers={customers} />
        </Box>
      </Container>
    </Box>
  </>
);

export default OpExEntryList;
