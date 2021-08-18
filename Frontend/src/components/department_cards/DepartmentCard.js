import PropTypes from 'prop-types';

import {
  Avatar,
  Box,
  Card,
  CardContent,
  Divider,
  Grid,
  Typography
} from '@material-ui/core';
import AccessTimeIcon from '@material-ui/icons/AccessTime';
import Update from '@material-ui/icons/Update';

import { useNavigate } from 'react-router-dom';

const clickHandle = (navigate, product) =>{
  switch(product.title){
    case "Cost":
      console.log("Cost case");
      navigate('/app/entries-c', { replace: true });
      break;
    case "OpEx":
      console.log("OpEx case");
      navigate('/app/opex-entries', { replace: true });
      break;
    case "Quality":
      console.log("Quality case");
      navigate('/app/quality-entries', { replace: true });
      break;
    case "Safety":
      console.log("Safety case");
      navigate('/app/safety-entries', { replace: true });
      break;
    case "Service":
      console.log("Service case");
      navigate('/app/service-entries', { replace: true });
      break;
    default:
      console.log("hsdgvzcg");
  }
}

export default function DepartmentCard ({ product, ...rest }) {

  const navigate = useNavigate();

  return (
  <Card
    onClick = {() => clickHandle(navigate, product)}
    sx={{
      display: 'flex',
      flexDirection: 'column',
      height: '100%'
    }}
    {...rest}
  >
    <CardContent>
      <Box
        sx={{
          display: 'flex',
          justifyContent: 'center',
          pb: 3
        }}
      >
        <Avatar
          alt="Product"
          src={product.media}
          variant="square"
        />
      </Box>
      <Typography
        align="center"
        color="textPrimary"
        gutterBottom
        variant="h4"
      >
        {product.title}
      </Typography>
      <Typography
        align="center"
        color="textPrimary"
        variant="body1"
      >
        {product.description}
      </Typography>
    </CardContent>
    <Box sx={{ flexGrow: 1 }} />
    <Divider />
    <Box sx={{ p: 2 }}>
      <Grid
        container
        spacing={2}
        sx={{ justifyContent: 'space-between' }}
      >
        <Grid
          item
          sx={{
            alignItems: 'center',
            display: 'flex'
          }}
        >
          <AccessTimeIcon color="action" />
          <Typography
            color="textSecondary"
            display="inline"
            sx={{ pl: 1 }}
            variant="body2"
          >
            Last updated
          </Typography>
        </Grid>
        <Grid
          item
          sx={{
            alignItems: 'center',
            display: 'flex'
          }}
        >
          <Update color="action" />
          <Typography
            color="textSecondary"
            display="inline"
            sx={{ pl: 1 }}
            variant="body2"
          >
            Amount of entries
          </Typography>
        </Grid>
      </Grid>
    </Box>
  </Card>
  )
};

DepartmentCard.propTypes = {
  product: PropTypes.object.isRequired
};
