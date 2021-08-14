import { Navigate } from 'react-router-dom';

import DashboardLayout from './components/DashboardLayout'
import DepartmentCards from './pages/DepartmentCards';

import CostEntriesList from './pages/CostEntriesList';
import OpexEntriesList from './pages/OpexEntriesList';
// import QualityEntriesList from './pages/QualityEntriesList';
// import SafetyEntriesList from './pages/SafetyEntriesList';
// import ServiceEntriesList from './pages/ServiceEntriesList';

import Home from './pages/Home';
import MainLayout from './components/MainLayout';
import NotFound from './pages/NotFound';
import Login from './pages/Login';

const routes = [
    {
      path: 'app',
      element: <DashboardLayout />,
      children: [
        { path: 'entries-a', element: <DepartmentCards /> },
        { path: 'entries-c', element: <CostEntriesList /> },
        { path: 'opex-entries', element: <OpexEntriesList /> },
        // { path: 'customers', element: <CustomerList /> },
        { path: 'home', element: <Home /> },
        // { path: 'products', element: <ProductList /> },
        // { path: 'settings', element: <Settings /> },
        { path: '*', element: <Navigate to="/404" /> }
      ]
    },
    {
      path: '/',
      element: <MainLayout />,
      children: [
        { path: 'login', element: <Login /> },
        //{ path: 'register', element: <Register /> },
        { path: '404', element: <NotFound /> },
        { path: '/', element: <Login /> },
        { path: '*', element: <Navigate to="/404" /> },
      ]
    }
  ];
  
  export default routes;