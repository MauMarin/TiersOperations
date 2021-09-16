import { Navigate } from 'react-router-dom';

// Importa el layout una vez que se ingresa sesiós
import DashboardLayout from '../components/DashboardLayout'

// Pagina dedicada a mostrar los departamentos en pantalla mediante cards
// y así se capaz de elegir el departamento deseado
import DepartmentCards from '../pages/EntryDepartmentCards';

// Importa las páginas de Entries
import CostEntriesList from '../pages/CostEntriesList';
import OpexEntriesList from '../pages/OpexEntriesList';
import QualityEntriesList from '../pages/QualityEntriesList';
import SafetyEntriesList from '../pages/SafetyEntriesList';
import ServiceEntriesList from '../pages/ServiceEntriesList';

// Importa las páginas de Goals
import GoalsCost from '../pages/GoalsCost';
import GoalsOpex from '../pages/GoalsOpex';
import GoalsQuality from '../pages/GoalsQuality';
import GoalsSafety from '../pages/GoalsSafety';
import GoalsService from '../pages/GoalsService';

// Importa la página de Users
import Users from '../pages/Users'

// Importa la página de Cards
import Cards from '../pages/Cards'

// Lading page cuando se ingresa sesión
import Home from '../pages/Home';

// Layout en página de inicio de sesión
import MainLayout from '../components/MainLayout';
import NotFound from '../pages/NotFound';
import Login from '../pages/Login';

/**
 * Cualquier componente que se llame con /app/ va a tener Dashboard Layout
 * Cualquier que se llame desde "/" tiene el MainLayout
 */

const routes = [
    {
      path: 'app',
      element: <DashboardLayout />,
      children: [
        // Se pasa valor section para indicarle que debe redirigir a las entries
        { path: 'entries-a', element: <DepartmentCards section="1" /> },

        { path: 'entries-c', element: <CostEntriesList /> },
        { path: 'opex-entries', element: <OpexEntriesList /> },
        { path: 'quality-entries', element: <QualityEntriesList /> },
        { path: 'service-entries', element: <ServiceEntriesList /> },
        { path: 'safety-entries', element: <SafetyEntriesList /> },

        // Se pasa valor section para indicarle que debe redirigir a los goals
        { path: 'goals', element: <DepartmentCards section="2" /> },
        
        { path: 'cost-goals', element: <GoalsCost /> },
        { path: 'opex-goals', element: <GoalsOpex /> },
        { path: 'quality-goals', element: <GoalsQuality /> },
        { path: 'service-goals', element: <GoalsService /> },
        { path: 'safety-goals', element: <GoalsSafety /> },

        { path: 'users', element: <Users /> },
        { path: 'cards', element: <Cards /> },
        { path: 'home', element: <Home /> },
        { path: '*', element: <Navigate to="/404" /> }
      ]
    },
    {
      path: '/',
      element: <MainLayout />,
      children: [
        { path: 'login', element: <Login /> },
        { path: '404', element: <NotFound /> },
        { path: '/', element: <Login /> },
        { path: '*', element: <Navigate to="/404" /> },
      ]
    }
  ];
  
  export default routes;