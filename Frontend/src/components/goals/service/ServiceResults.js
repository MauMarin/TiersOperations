
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
