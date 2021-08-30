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
    editable: true,
  },
  {
    field: 'fiscalMonth',
    headerName: 'Fiscal Month',
    width: 150,
    editable: true,
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
    field: 'fpy25',
    headerName: 'FPY Op 25',
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
              autoHeight={true}
              autoPageSize={true}
              disableExtendRowFullWidth={true}
            />
          </div>
        </Box>
      </PerfectScrollbar>
    </Card>
  );
}
