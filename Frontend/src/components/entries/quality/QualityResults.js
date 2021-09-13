import * as React from 'react';
import { DataGrid, GridToolbar } from '@mui/x-data-grid';

import { useState, useEffect } from 'react';

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

import Cookies from 'universal-cookie';
var state = true;

export default function DataGridDemo({ customers, ...rest }) {
  const [openPopup, setOpenPopup] = useState(false);
  const [row, setRow] = useState('');

  const [isLoading, setLoading] = useState(true);

  useEffect(() => {
    const cookie = new Cookies();
    const { role } = cookie.get('userData');
    if(role > 1) state = false;
    setLoading(false);
  }, []);

  if (isLoading) {
    return <div className="App">Loading...</div>;
  }

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
      field: 'larOverall',
      headerName: 'Lot Acceptance Rate - Overall',
      sortable: true,
      width: 160
    },
    {
      field: 'larHumacao',
      headerName: 'Lot Acceptance Rate - Humacao',
      sortable: true,
      width: 160
    },
    {
      field: 'larWarsaw',
      headerName: 'Lot Acceptance Rate - Warsaw',
      sortable: true,
      width: 160
    },
  
    {
      field: 'fly65',
      headerName: 'FPY Op 65',
      sortable: true,
      width: 160
    },
    {
      field: 'NCROpen',
      headerName: 'NCRs Open',
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
  
        return <IconButton disabled={state} onClick={onClick}> <Edit /> </IconButton>;
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
