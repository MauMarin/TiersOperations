import * as React from 'react';
import { DataGrid } from '@mui/x-data-grid';

import {
  Box,
  Card
} from '@material-ui/core';

import PerfectScrollbar from 'react-perfect-scrollbar';

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
    field: 'HOs',
    headerName: 'HOs',
    sortable: true,
    width: 160
  },
  {
    field: 'TRIR',
    headerName: 'TRIR',
    sortable: true,
    width: 160
  },
  {
    field: 'firstAid',
    headerName: 'First Aid',
    sortable: true,
    width: 160
  },
  {
    field: 'nearMiss',
    headerName: 'Near Miss',
    sortable: true,
    width: 160
  }
  
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
              pageSize={8}
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
