import { Helmet } from 'react-helmet';
import {
  Box
} from '@material-ui/core';

const Home = () => {

  return (
    <>
      <Helmet>
        <title>Home</title>
      </Helmet>
      <Box
        sx={{
          backgroundColor: 'background.default',
          minHeight: '100%',
          py: 3
        }}
      >
        AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa
      </Box>
    </>
  );
}

export default Home;
