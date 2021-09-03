import { Helmet } from 'react-helmet';
import {
  Box
} from '@material-ui/core';
// import Budget from 'src/components/dashboard//Budget';
// import LatestOrders from 'src/components/dashboard//LatestOrders';
// import LatestProducts from 'src/components/dashboard//LatestProducts';
// import Sales from 'src/components/dashboard//Sales';
// import TasksProgress from 'src/components/dashboard//TasksProgress';
// import TotalCustomers from 'src/components/dashboard//TotalCustomers';
// import TotalProfit from 'src/components/dashboard//TotalProfit';
// import TrafficByDevice from 'src/components/dashboard//TrafficByDevice';

const Home = () => (
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
      Equipo Meraki UwU
    </Box>
  </>
);

export default Home;
