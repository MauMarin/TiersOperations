import { useEffect } from 'react';
import { useLocation } from 'react-router-dom';
import PropTypes from 'prop-types';
import {
    Box,
    Divider,
    Drawer,
    Hidden,
    List,
    Typography
} from '@material-ui/core';

import {
    Activity,
    BarChart as BarChartIcon,
    Target,
    Square,
    Users as UsersIcon,
} from 'react-feather';

import NavItem from './NavItem';

import Cookies from 'universal-cookie';

// Se definen los íconos y rutas que aparecen en el sidebar
// Level define el nivel mínimo de permiso/rol
const getSection = (role) => {
    const items = [
        {
            href: '/app/cards',
            icon: Square,
            title: 'Cards',
            level: 1
        },
        {
            href: '/app/dashboard',
            icon: BarChartIcon,
            title: 'Dashboard',
            level: 1
        },
        {
            href: '/app/entries-a',
            icon: Activity,
            title: 'Department Entries',
            level: 1
        },
        {
            href: '/app/goals',
            icon: Target,
            title: 'Goals',
            level: 3
        },
        {
            href: '/app/users',
            icon: UsersIcon,
            title: 'Users',
            level: 4
        },
    ];

    var temp = [];

    if(role === 4){
        return items;
    }
    // Filta los items que corresponden a un permiso dado
    else{
        items.forEach(i => {
            if( i.level <= role ) temp.push(i);
        })
        return temp;
    }

}

const DashboardSidebar = ({ onMobileClose, openMobile }) => {
    const location = useLocation();

    useEffect(() => {
        if (openMobile && onMobileClose) {
            onMobileClose();
        }
    }, [location.pathname]);

    const cookie = new Cookies();

    // Información que se muestra en la parte superior del sidebar
    const { name, RoleName, role } = cookie.get('userData');

    const items = getSection(role)
    
    const content = (
        <Box
            sx={{
                display: 'flex',
                flexDirection: 'column',
                height: '100%'
            }}
        >
            <Box
                sx={{
                    alignItems: 'center',
                    display: 'flex',
                    flexDirection: 'column',
                    p: 2
                }}
            >
                
                <Typography
                    color="textPrimary"
                    variant="h5"
                >
                    {name}
                </Typography>
                <Typography
                    color="textSecondary"
                    variant="body2"
                >
                    {RoleName}
                </Typography>
            </Box>
            <Divider />
            <Box sx={{ p: 2 }}>
                <List>
                    {items.map((item) => (
                        <NavItem
                            href={item.href}
                            key={item.title}
                            title={item.title}
                            icon={item.icon}
                        />
                    ))}
                </List>
            </Box>
            <Box sx={{ flexGrow: 1 }} />
            
        </Box>
    );

    return (
        <>
            <Hidden lgUp>
                <Drawer
                    anchor="left"
                    onClose={onMobileClose}
                    open={openMobile}
                    variant="temporary"
                    PaperProps={{
                        sx: {
                            width: 256
                        }
                    }}
                >
                    {content}
                </Drawer>
            </Hidden>
            <Hidden lgDown>
                <Drawer
                    anchor="left"
                    open
                    variant="persistent"
                    PaperProps={{
                        sx: {
                            width: 256,
                            top: 64,
                            height: 'calc(100% - 64px)'
                        }
                    }}
                >
                    {content}
                </Drawer>
            </Hidden>
        </>
    );
};

DashboardSidebar.propTypes = {
    onMobileClose: PropTypes.func,
    openMobile: PropTypes.bool
};

DashboardSidebar.defaultProps = {
    onMobileClose: () => { },
    openMobile: false
};

export default DashboardSidebar;
