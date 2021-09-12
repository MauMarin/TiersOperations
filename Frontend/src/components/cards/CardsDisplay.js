import * as React from 'react';
import { DataGrid } from '@mui/x-data-grid';

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

import {withStyles} from '@material-ui/styles';

import PerfectScrollbar from 'react-perfect-scrollbar';

import axios from 'axios';

const config = require('../../config');

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

export default function DataGridDemo({ cards, ...rest }) {
  const [anchorEl, setAnchorEl] = React.useState(null);

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
    {
      field: "",
      headerName: "Change Status",
      sortable: false,
      width: 125,
      disableClickEventBubbling: true,
      renderCell: (params) => {

        const handleClick = (event) => {
          setAnchorEl(event.currentTarget);
        };
      
        const handleClose = (event) => {
          setAnchorEl(null);
          const id = params.row.id
          const newStatus = (event.nativeEvent.target.outerText.toLowerCase());

          axios({
            method: 'post',
            url: `http://http://${config.host}:${config.port}/api/cards/changeStatus`,
            headers: {'Content-Type': 'application/json; charset=utf-8'}, 
            data: {
                idCard: id,
                status:newStatus
            }
          })
          .then(()=>{
            window.location.reload();
          })
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
              <MenuItem onClick={handleClose}>Green</MenuItem>
              <MenuItem onClick={handleClose}>Yellow</MenuItem>
              <MenuItem onClick={handleClose}>Red</MenuItem>
            </Menu>
          </div>
        );
      }
    }
  ];

  //console.log(cards)
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
              disableExtendRowFullWidth={false}
            />
          </div>
        </Box>
      </PerfectScrollbar>
    </Card>
  );
}
