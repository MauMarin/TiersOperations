import { Link as RouterLink, useNavigate } from 'react-router-dom';
import { Helmet } from 'react-helmet';
import * as Yup from 'yup';
import { Formik } from 'formik';
import {
  Box,
  Button,
  Container,
  Link,
  Snackbar,
  TextField,
  Typography
} from '@material-ui/core';

import {useState} from 'react';

import {
  Alert,
  AlertTitle,
} from '@material-ui/lab';

import axios from 'axios';

import Cookies from 'universal-cookie';

const config = require('../config');


const Login = () => {
  
  const navigate = useNavigate();
  const [open, setOpen] = useState(false);

  const handleClick = () => {
    setOpen(true);
  };

  const handleClose = (event, reason) => {
    if (reason === 'clickaway') {
      return;
    }

    setOpen(false);
  };

  const cookie = new Cookies();

  return (
    <>
      <Helmet>
        <title>Login | Tiers Operations</title>
      </Helmet>
      <Box
        sx={{
          backgroundColor: 'background.default',
          display: 'flex',
          flexDirection: 'column',
          height: '100%',
          justifyContent: 'center'
        }}
      >
        <Container maxWidth="sm">
          <Formik
            initialValues={{
              username: '',
              password: ''
            }}
            validationSchema={Yup.object().shape({
              username: Yup.string().required('Username is required'),
              password: Yup.string().max(255).required('Password is required')
            })}

            //initial call to backend
            onSubmit={(username, password) => {
              axios.post(`http://${config.host}:${config.port}/api/users/validate`, {username, password})
              .then((response) => {
                const data = response.data;
                if(data !== ""){
                  cookie.set('userData', data, {path: '/'})
                  navigate('/app/home', { replace: true });
                }
                else{
                  console.log("WTF");
                  handleClick()
                }
              }, (error) => {
                console.log(error);
              });
            }}

          >
            {({
              errors,
              handleBlur,
              handleChange,
              handleSubmit,
              isSubmitting,
              touched,
              values
            }) => (
              <form onSubmit={handleSubmit}>
                <Box sx={{ mb: 3 }}>
                  <Typography
                    color="textPrimary"
                    variant="h2"
                  >
                    Sign in
                  </Typography>
                  <Typography
                    color="textSecondary"
                    gutterBottom
                    variant="body2"
                  >
                    Sign in on the internal platform with your internal credentials
                  </Typography>
                </Box>
                <Box
                  sx={{
                    pb: 1,
                    pt: 3
                  }}
                >
                  <Typography
                    align="center"
                    color="textSecondary"
                    variant="body1"
                  >
                  </Typography>
                </Box>
                <TextField
                  error={Boolean(touched.username && errors.username)}
                  fullWidth
                  helperText={touched.username && errors.username}
                  label="Username Address"
                  margin="normal"
                  name="username"
                  onBlur={handleBlur}
                  onChange={handleChange}
                  type="username"
                  value={values.username}
                  variant="outlined"
                />
                <TextField
                  error={Boolean(touched.password && errors.password)}
                  fullWidth
                  helperText={touched.password && errors.password}
                  label="Password"
                  margin="normal"
                  name="password"
                  onBlur={handleBlur}
                  onChange={handleChange}
                  type="password"
                  value={values.password}
                  variant="outlined"
                />
                <Box sx={{ py: 2 }}>
                  <Button
                    color="primary"
                    fullWidth
                    size="large"
                    type="submit"
                    variant="contained"
                  >
                    Sign in now
                  </Button>
                </Box>
                <Typography
                  color="textSecondary"
                  variant="body1"
                >
                  Don&apos;t have an account?
                  {' '}
                  <Link
                    component={RouterLink}
                    to="/app/home"
                    variant="h6"
                    onClick={ cookie.set('userData',
                      {
                        name: "Guest user",
                        username: "GU",
                        role: 1,
                        
                      }
                    , {path: '/'})}
                  >
                    View page as guest
                  </Link>
                </Typography>
              </form>
            )}
          </Formik>
        </Container>
      </Box>

      <Snackbar open={open} autoHideDuration={6000} onClose={handleClose}>
        <Alert severity="info">
          <AlertTitle>Incorrect Credentials</AlertTitle>
            Please try again
          </Alert>
      </Snackbar>
    </>
  );
};

export default Login;
