import { Helmet } from 'react-helmet';
import { Box, Container } from '@material-ui/core';
import EntriesToolbar from '../components/entries/EntryToolbar';
import EntryResults from '../components/entries/CostEntry';
import customers from '../__mocks__/CostPlaceholder';

const CostEntryList = () => (
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
            <EntryResults customers={customers} />
        </Box>
      </Container>
    </Box>
  </>
);

export default CostEntryList;
