import * as React from 'react';
import { DataGrid } from '@mui/x-data-grid';

import {
  Box,
  Card,
  IconButton
} from '@material-ui/core';

import { useState } from 'react';

import Popup from './Popup'

import {
  Edit
} from 'react-feather';

import PerfectScrollbar from 'react-perfect-scrollbar';

export default function DataGridDemo({ customers, ...rest }) {
  const [openPopup, setOpenPopup] = useState(false);
  const [row, setRow] = useState('');

  const columns = [
    { field: 'id', headerName: 'Entry ID', width: 150 },
    {
      field: 'fiscalYear',
      headerName: 'Fiscal Year',
      width: 150,
      sortable: true,
    },
    {
      field: 'fiscalMonth',
      headerName: 'Fiscal Month',
      width: 150,
      sortable: true,
    },
    {
      field: 'eval6S',
      headerName: '6S Evaluation',
      sortable: true,
      width: 160
    },
    {
      field: 'tOT',
      headerName: 'Training On Time',
      sortable: true,
      width: 160
    },
    {
      field: 'cOT',
      headerName: 'Completed On Time',
      sortable: true,
      width: 160
    },
    {
      field: "",
      headerName: "Edit",
      sortable: false,
      width: 100,
      disableClickEventBubbling: true,
      renderCell: (params) => {
        const onClick = () => {
          setOpenPopup(true)
          setRow(params.row.id);
        };
  
        return <IconButton onClick={onClick}> <Edit /> </IconButton>;
  
      }
    }
  ];

  return (
    <Card {...rest}>
      <PerfectScrollbar>
        <Box >
          <div style={{ height: 800, width: '100%' }}>
            <DataGrid
              rows={customers}
              columns={columns}
              pageSize={8}
              checkboxSelection
              disableSelectionOnClick
              autoPageSize={true}
              disableExtendRowFullWidth={true}
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
