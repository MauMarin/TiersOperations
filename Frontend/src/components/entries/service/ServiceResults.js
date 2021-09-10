import * as React from 'react';
import { DataGrid, GridToolbar } from '@mui/x-data-grid';

import { useState } from 'react';

import {
  Box,
  Card,
  IconButton
} from '@material-ui/core';

import {
  Edit
} from 'react-feather';

import Popup from './Popup'

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
      field: 'reportDate',
      headerName: 'Report Date',
      width: 150,
      sortable: true,
    },
    {
      field: 'createdBy',
      headerName: 'Created By',
      sortable: true,
      width: 160
    },
    {
      field: 'createdDate',
      headerName: 'Creation Date',
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
      field: 'modifiedDate',
      headerName: 'Modification Date',
      sortable: true,
      width: 160
    },
    {
      field: 'op20',
      headerName: 'Op20: Machining',
      sortable: true,
      width: 160
    },
    {
      field: 'op40',
      headerName: 'Op40: Cleaning',
      sortable: true,
      width: 160
    },
    {
      field: 'op60',
      headerName: 'Op60: Final Inspection',
      sortable: true,
      width: 160
    },
    {
      field: 'op65',
      headerName: 'Op65: FDV',
      sortable: true,
      width: 160
    },
    {
      field: 'op70',
      headerName: 'Op70: Packaging',
      sortable: true,
      width: 160
    },
    {
      field: 'intervention',
      headerName: 'Maintenance Interventions',
      sortable: true,
      width: 160
    },
    {
      field: 'OEE',
      headerName: 'OEE',
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
              ColumnFilteredIcon
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
