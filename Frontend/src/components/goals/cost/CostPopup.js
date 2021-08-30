import { 
    Dialog
} from '@material-ui/core';
import React from 'react'

import EntryForm from './EntryForm';

function CostPopup(props) {
    const {openPopup} = props;
    return (
        <Dialog open={openPopup} maxWidth="md">
            <EntryForm />
        </Dialog>
    )
}

export default CostPopup
