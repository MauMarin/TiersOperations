import { 
    Dialog,
    DialogContent,
    DialogTitle
} from '@material-ui/core';
import React from 'react'

import EntryForm from './EntryForm';

function CostPopup(props) {
    const {title, children, openPopup, setOpenPopup} = props;
    return (
        <Dialog open={openPopup} maxWidth="md">
            <DialogTitle>

            </DialogTitle>
                <EntryForm />
            <DialogContent>
            </DialogContent>
        </Dialog>
    )
}

export default CostPopup
