import { 
    Dialog
} from '@material-ui/core';
import React from 'react'

import UserForm from './UserForm';

function CostPopup(props) {
    const {openPopup} = props;
    return (
        <Dialog open={openPopup} maxWidth="md">
            <UserForm />
        </Dialog>
    )
}

export default CostPopup
