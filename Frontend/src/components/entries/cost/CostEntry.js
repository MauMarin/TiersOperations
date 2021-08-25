import { useState } from 'react';
import PropTypes from 'prop-types';
import PerfectScrollbar from 'react-perfect-scrollbar';
import {
  Box,
  Card,
  Checkbox,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TablePagination,
  TableRow,
  Typography
} from '@material-ui/core';

const EntryResults = ({ customers, ...rest }) => {
  const [selectedCustomerIds, setSelectedCustomerIds] = useState([]);
  const [limit, setLimit] = useState(10);
  const [page, setPage] = useState(0);

  const handleSelectAll = (event) => {
    let newSelectedCustomerIds;

    if (event.target.checked) {
      newSelectedCustomerIds = customers.map((customer) => customer.id);
    } else {
      newSelectedCustomerIds = [];
    }

    setSelectedCustomerIds(newSelectedCustomerIds);
  };

  const handleSelectOne = (event, id) => {
    const selectedIndex = selectedCustomerIds.indexOf(id);
    let newSelectedCustomerIds = [];

    if (selectedIndex === -1) {
      newSelectedCustomerIds = newSelectedCustomerIds.concat(selectedCustomerIds, id);
    } else if (selectedIndex === 0) {
      newSelectedCustomerIds = newSelectedCustomerIds.concat(selectedCustomerIds.slice(1));
    } else if (selectedIndex === selectedCustomerIds.length - 1) {
      newSelectedCustomerIds = newSelectedCustomerIds.concat(selectedCustomerIds.slice(0, -1));
    } else if (selectedIndex > 0) {
      newSelectedCustomerIds = newSelectedCustomerIds.concat(
        selectedCustomerIds.slice(0, selectedIndex),
        selectedCustomerIds.slice(selectedIndex + 1)
      );
    }

    setSelectedCustomerIds(newSelectedCustomerIds);
  };

  const handleLimitChange = (event) => {
    setLimit(event.target.value);
  };

  const handlePageChange = (event, newPage) => {
    setPage(newPage);
  };

  return (
    <Card {...rest}>
      <PerfectScrollbar>
        <Box sx={{ minWidth: 1050 }}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell padding="checkbox">
                  <Checkbox
                    checked={selectedCustomerIds.length === customers.length}
                    color="primary"
                    indeterminate={
                      selectedCustomerIds.length > 0
                      && selectedCustomerIds.length < customers.length
                    }
                    onChange={handleSelectAll}
                  />
                </TableCell>

                <TableCell>
                  Entry ID
                </TableCell>
                <TableCell>
                  Fiscal Year
                </TableCell>
                <TableCell>
                  Fiscal Month
                </TableCell>
                <TableCell>
                  Report Date
                </TableCell>
                <TableCell>
                  Created By
                </TableCell>
                <TableCell>
                  Creation Date
                </TableCell>
                <TableCell>
                  Modified By
                </TableCell>
                <TableCell>
                  Modification Date
                </TableCell>
                <TableCell>
                  Tier
                </TableCell>
                <TableCell>
                  Scrap
                </TableCell>
                <TableCell>
                  Conversion Loss
                </TableCell>
                <TableCell>
                  Tool Consumption
                </TableCell>
                <TableCell>
                  Tool Rate
                </TableCell>
                <TableCell>
                  Earn Hours
                </TableCell>
                <TableCell>
                  Energy Rate
                </TableCell>

              </TableRow>
            </TableHead>
            
            <TableBody>
              {customers.slice(0, limit).map((customer) => (
                <TableRow
                  hover
                  key={customer.id}
                  selected={selectedCustomerIds.indexOf(customer.id) !== -1}
                >
                  <TableCell padding="checkbox">
                    <Checkbox
                      checked={selectedCustomerIds.indexOf(customer.id) !== -1}
                      onChange={(event) => handleSelectOne(event, customer.id)}
                      value="true"
                    />
                  </TableCell>
                  <TableCell>
                    <Box
                      sx={{
                        alignItems: 'center',
                        display: 'flex'
                      }}
                    >
                      <Typography
                        color="textPrimary"
                        variant="body1"
                      >
                        {customer.entry}
                      </Typography>
                    </Box>
                  </TableCell>

                  <TableCell>
                    {customer.fiscalYear}
                  </TableCell>

                  <TableCell>
                    {customer.fiscalMonth}
                  </TableCell>
                  <TableCell>
                    {customer.reportDate}
                  </TableCell>
                  <TableCell>
                    {customer.createdBy}
                  </TableCell>
                  <TableCell>
                    {customer.createdDate}
                  </TableCell>
                  <TableCell>
                    {customer.modifiedBy}
                  </TableCell>
                  <TableCell>
                    {customer.modifiedDate}
                  </TableCell>
                  <TableCell>
                    {customer.tier}
                  </TableCell>
                  <TableCell>
                    {customer.scrap}
                  </TableCell>
                  <TableCell>
                    {customer.conversionLoss}
                  </TableCell>
                  <TableCell>
                    {customer.toolConsumption}
                  </TableCell>
                  <TableCell>
                    {customer.toolRate}
                  </TableCell>
                  <TableCell>
                    {customer.earnHours}
                  </TableCell>
                  <TableCell>
                    {customer.energyRate}
                  </TableCell>
                  

                </TableRow>
              ))}
            </TableBody>
          </Table>
        </Box>
      </PerfectScrollbar>
      <TablePagination
        component="div"
        count={customers.length}
        onPageChange={handlePageChange}
        onRowsPerPageChange={handleLimitChange}
        page={page}
        rowsPerPage={limit}
        rowsPerPageOptions={[10, 25]}
      />
    </Card>
  );
};

EntryResults.propTypes = {
  customers: PropTypes.array.isRequired
};

export default EntryResults;
