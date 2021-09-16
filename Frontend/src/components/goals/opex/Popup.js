import { 
    Dialog
} from '@material-ui/core';
import React from 'react'

import EntryForm from './EntryForm';
import UpdateForm from './UpdateForm'

function Popup({data, openPopup, type}) {
    
    if(type === 1){
        return (
            <Dialog open={openPopup} maxWidth="md">
                <EntryForm />
            </Dialog>
        )
    }
    else{
        return (
            <Dialog open={openPopup} maxWidth="md">
                <UpdateForm data={data} />
            </Dialog>
        )
    }

}

export default Popup
