import {
  Box,
  Button,
  // Card,
  // CardContent,
  // TextField,
  // InputAdornment,
  // SvgIcon
} from '@material-ui/core';
import Popup from 'reactjs-popup';
//import { Search as SearchIcon } from 'react-feather';

import { useState } from 'react';

export default function EntriesToolbar(props) {
  const [open, setOpen] = useState(false);
  const closeModal = () => setOpen(false);

  return (
    <Box {...props}>
      <Box
        sx={{
          display: 'flex',
          justifyContent: 'flex-end'
        }}
      >

        <Popup trigger={<Button
          color="primary"
          variant="contained"
        >
          Add new
        </Button>} position="right center">
          <div>Popup content here !!</div>
        </Popup>


      </Box>
    </Box>
  );
}
