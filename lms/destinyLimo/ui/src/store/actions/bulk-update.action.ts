import { createAction, props } from '@ngrx/store';

export const bulkUpdate = createAction(
    '[Bulk Update API] Initiate Bulk Update',
    props<{tableName:string, allActionRecords: any[], allFileUploads: any[] }>()
);

export const bulkUpdate_Success = createAction(
    '[Bulk Update API] Bulk Update Success',
    props<{ bulkActions: any[] }>()
);

export const bulkUpdate_Failure = createAction(
    '[Bulk Update API] Bulk Update Failure',
    props<{ bulkActions: any[]}>()
);