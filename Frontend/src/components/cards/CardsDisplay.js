import * as React from 'react';
import { DataGrid, GridToolbar } from '@mui/x-data-grid';

import {
  Box,
  Button,
  Card,
  Menu,
  MenuItem
} from '@material-ui/core';

import {
  MoreVertical
} from 'react-feather';

import { useState } from 'react';

import {withStyles} from '@material-ui/styles';

import PerfectScrollbar from 'react-perfect-scrollbar';

import Popup from './Popup'

import Cookies from 'universal-cookie';

// Se usa para extener el tamaño de la celda
const StyledDataGrid = withStyles({
  root: {
    "& .MuiDataGrid-renderingZone": {
      maxHeight: "none !important",
    },
    "& .MuiDataGrid-cell": {
      lineHeight: "unset !important",
      maxHeight: "none !important",
      whiteSpace: "normal",
    },
    "& .MuiDataGrid-row": {
      maxHeight: "none !important",
    }
  }
})(DataGrid);

var state = true;

export default function DataGridDemo({ cards, ...rest }) {
  // Se utiliza para el menu 
  const [anchorEl, setAnchorEl] = React.useState(null);

  // Define si se muestra el popup o no
  const [openPopup, setOpenPopup] = useState(false);

  // Se utiliza para guardar la información de un row
  const [row, setRow] = useState('');

  // Carga la cookie y saca de ella el rol del usuario. En base a esto define si se deshabilita el botón de "New Card"
  const cookie = new Cookies();

  // Extra el rol para saber los permisos del mismo
  const { role } = cookie.get('userData');

  // Si el rol es mayor a 1, osea, cualquiera menos guest, habilita el botón
  if(role > 1) state = false;

  // Definición de columnas / headers
  const columns = [
    { field: 'id', headerName: 'Card ID', width: 150 },
    {
      field: 'status',
      headerName: 'Status',
      width: 150,
      sortable: true,
    },
    {
      field: 'dueDate',
      headerName: 'Due Date',
      width: 150,
      sortable: true,
    },
    {
      field: 'deparment',
      headerName: 'Department',
      width: 150,
      sortable: true,
    },
    {
      field: 'description',
      headerName: 'Description',
      sortable: true,
      width: 250
    },
    {
      field: 'submittedBy',
      headerName: 'By',
      sortable: true,
      width: 160
    },
    {
      field: 'directedTo',
      headerName: 'To',
      sortable: true,
      width: 160
    },
    {
      field: 'actionPlan',
      headerName: 'Action Plan',
      sortable: true,
      width: 250
    },
    {
      field: 'creationDate',
      headerName: 'Creation Date',
      sortable: true,
      width: 160
    },
    {
      field: 'createdBy',
      headerName: 'Created By',
      sortable: true,
      width: 160
    },
    {
      field: 'modifiedDate',
      headerName: 'Modified Date',
      sortable: true,
      width: 160
    },
    {
      field: 'modifiedBy',
      headerName: 'Modified By',
      sortable: true,
      width: 160
    },

    // Muestra columna de opciones, con la funcionalidad
    {
      field: "",
      headerName: "Options",
      sortable: false,
      width: 125,
      disableClickEventBubbling: true,
      renderCell: (params) => {

        const handleClick = (event) => {
          setAnchorEl(event.currentTarget);
        };

        const handleClose = (event) => {
          setAnchorEl(null);
        }
    
        // Cuando se presiona la opción, saca toda la información del row
        const onClick = () => {
          setAnchorEl(null);
          setOpenPopup(true)
          setRow(params.row.id);
        };
  
        return (
          <div>
            <Button aria-controls="simple-menu" aria-haspopup="true" onClick={handleClick}>
              <MoreVertical />
            </Button>
            <Menu
              id="simple-menu"
              anchorEl={anchorEl}
              keepMounted
              open={Boolean(anchorEl)}
              onClose={handleClose}
            >
              <MenuItem disabled={state} onClick={onClick}>Edit Card</MenuItem>
            </Menu>
          </div>
        );
      }
    },
    {
      field: 'modifiedBy',
      headerName: 'Modified By',
      sortable: true,
      width: 160
    },
    
  ];

  return (
    <Card {...rest}>
      <PerfectScrollbar>
        <Box >
          <div style={{ height: 800, width: '100%' }}>
            <StyledDataGrid
              rows={cards}
              columns={columns}
              pageSize={13}
              checkboxSelection
              disableSelectionOnClick
              
              autoPageSize={true}
              disableExtendRowFullWidth={true}
              components={{
                Toolbar: GridToolbar,
              }}
            />
          </div>
        </Box>
      </PerfectScrollbar>

      <Popup
        openPopup={openPopup}
        data = {row}
        type = {2}
        setOpenPopup={setOpenPopup}
      ></Popup>
    </Card>
  );
}
