import { Helmet } from 'react-helmet';
import {
  Box,
  Card,
  CardHeader
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
        <Card>
        <CardHeader
          title="Medtronic internal organization"
        />
          <img src={'/static/images/home2.jpeg'} alt="Operations diagram" />
        </Card>
      </Box>
    </>
  );
}

export default Home;
