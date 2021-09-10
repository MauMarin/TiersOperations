import * as React from 'react';
import { DataGrid } from '@mui/x-data-grid';

import {
  Box,
  Card
} from '@material-ui/core';

import PerfectScrollbar from 'react-perfect-scrollbar';

const columns = [
  { field: 'id', headerName: 'User ID', width: 150 },
  {
    field: 'name',
    headerName: 'Name',
    width: 150,
    sortable: true,
  },
  {
    field: 'username',
    headerName: 'Username',
    width: 150,
    sortable: true,
  },
  {
    field: 'Department',
    headerName: 'Department',
    width: 150,
    sortable: true,
  },
  {
    field: 'Role',
    headerName: 'Role',
    sortable: true,
    width: 160
  },
];


export default function DataGridDemo({ customers, ...rest }) {
  return (
    <Card {...rest}>
      <PerfectScrollbar>
        <Box >
          <div style={{ height: 800, width: '100%' }}>
            <DataGrid
              rows={customers}
              columns={columns}
              pageSize={13}
              checkboxSelection
              disableSelectionOnClick
              autoPageSize={true}
              disableExtendRowFullWidth={true}
            />
          </div>
        </Box>
      </PerfectScrollbar>
    </Card>
  );
}