import 'react-perfect-scrollbar/dist/css/styles.css';
import { useRoutes } from 'react-router-dom';
import { ThemeProvider } from '@material-ui/core';
import GlobalStyles from './components/GlobalStyles';
import theme from './theme';
import routes from './routes/routes';

/*
En vez de llamar a un componente, se llama al archivo de rutas, el cual, mediante el
hook useRoute() se puede usar para acceder a distintos URLs

La variable routing tiene la característica de ser componentes compuestos, donde se
llama al componente padre (el layout general de la ventana) y luego el componente
hijo, el cual define la ruta usada para acceder a dicho componente.

Todos los archivos llamados desde routes se encuentran en la carpeta de "pages"m y estos
conforman la estrucutra base de la página. Cada página llama a sus componentes respectivos
con el fin de hacer lo indicado
*/


const App = () => {
  const routing = useRoutes(routes);

  return (
    <ThemeProvider theme={theme}>
      <GlobalStyles />
      {routing}
    </ThemeProvider>
  );
};

export default App;