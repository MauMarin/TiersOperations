import { useEffect } from 'react';
import { Link as RouterLink, useLocation } from 'react-router-dom';
import PropTypes from 'prop-types';
import {
    Avatar,
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
    Tool,
    Square,
    Users as UsersIcon,
} from 'react-feather';
import NavItem from './NavItem';

const user = {
    avatar: '/static/images/default_icon.jpg',
    jobTitle: 'Role',
    name: 'Name'
};

const items = [
    {
        href: '/app/entries-c',
        icon: Square,
        title: 'Cards'
    },
    {
        href: '/app/opex-entries',
        icon: BarChartIcon,
        title: 'Dashboard'
    },
    {
        href: '/app/entries-a',
        icon: Activity,
        title: 'Department Entries'
    },
    {
        href: '/app/account',
        icon: Target,
        title: 'Goals'
    },
    {
        href: '/app/settings',
        icon: Tool,
        title: 'Roles'
    },
    {
        href: '/app/customers',
        icon: UsersIcon,
        title: 'Users'
    },
];

const DashboardSidebar = ({ onMobileClose, openMobile }) => {
    const location = useLocation();

    useEffect(() => {
        if (openMobile && onMobileClose) {
            onMobileClose();
        }
    }, [location.pathname]);

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
                <Avatar
                    component={RouterLink}
                    src={user.avatar}
                    sx={{
                        cursor: 'pointer',
                        width: 64,
                        height: 64
                    }}
                    to="/app/account"
                />
                <Typography
                    color="textPrimary"
                    variant="h5"
                >
                    {user.name}
                </Typography>
                <Typography
                    color="textSecondary"
                    variant="body2"
                >
                    {user.jobTitle}
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