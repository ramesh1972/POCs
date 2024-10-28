// // import the interface
import { createReducer, on } from '@ngrx/store';

import { Content } from '../models/Content';
import { BulkUpdateState } from '../states/bulk-update.state';
import { bulkUpdate_Success, bulkUpdate_Failure } from '../actions/bulk-update.action';

//create a dummy initial state
export const initialState: BulkUpdateState = {
  bulkActions: [],
  success: false,
};

export const bulkUpdateReducer = createReducer(
  initialState,
  on(bulkUpdate_Success, (state, { bulkActions }) => {
    return { ...state, bulkActions: bulkActions, success: true };
  }),

  on(bulkUpdate_Failure, (state, { bulkActions }) => {
    return { ...state, bulkActions: bulkActions, success: false };
  }),
);