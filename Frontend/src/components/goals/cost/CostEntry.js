import * as React from 'react';
import { DataGrid } from '@mui/x-data-grid';

import {
  Box,
  Card,
  IconButton
} from '@material-ui/core';

import PerfectScrollbar from 'react-perfect-scrollbar';

import { useState } from 'react';

import CostPopup from './CostPopup'

import {
  Edit
} from 'react-feather';

export default function DataGridDemo({ customers, ...rest }) {
  const [openPopup, setOpenPopup] = useState(false);
  const [row, setRow] = useState('');

  const columns = [
    { field: 'id', headerName: 'Goal ID', width: 150 },
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
              checkboxSelection
              disableSelectionOnClick
              autoPageSize={true}
              disableExtendRowFullWidth={true}
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
