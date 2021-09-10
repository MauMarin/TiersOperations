import * as React from 'react';

import {
  Box,
  Card,
  IconButton
} from '@material-ui/core';

import { DataGrid, GridToolbar } from '@mui/x-data-grid';

import PerfectScrollbar from 'react-perfect-scrollbar';

import CostPopup from './CostPopup';
import { useState } from 'react';

import {
  Edit
} from 'react-feather';

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
      field: 'scrap',
      headerName: 'Scrap',
      sortable: true,
      width: 160
    },
    {
      field: 'conversionLoss',
      headerName: 'Conversion Loss',
      sortable: true,
      width: 160
    },
    {
      field: 'toolConsumption',
      headerName: 'Tool Consumption',
      sortable: true,
      width: 160
    },
    {
      field: 'toolRate',
      headerName: 'Tool Rate',
      sortable: true,
      width: 160
    },
    {
      field: 'earnHours',
      headerName: 'Earn Hours',
      sortable: true,
      width: 160
    },
    {
      field: 'energyRate',
      headerName: 'Energy Rate',
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
              pageSize={13}
              ColumnFilteredIcon
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

      <CostPopup
        openPopup={openPopup}
        data = {row}
        type = {2}
        setOpenPopup={setOpenPopup}
      ></CostPopup>
    </Card>
  );
}
