import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { Store } from '@ngrx/store';
import { map, catchError, mergeMap } from 'rxjs/operators';
import { of } from 'rxjs';

import { BulkUpdateService } from '../apis/bulk-update.service';

import { bulkUpdate, bulkUpdate_Success, bulkUpdate_Failure } from '../actions/bulk-update.action';
import { ApiResponse } from '../models/ApiResponse';

@Injectable()
export class BulkUpdateEffect {
  constructor(
    private actions$: Actions,
    private bulkUpdateService: BulkUpdateService,
    private store: Store
  ) { }

  bulkUpdateAll$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(bulkUpdate),
      mergeMap((action: any) => {
        return this.bulkUpdateService
          .bulkUpdate(action.tableName, action.allActionRecords, action.allFileUploads)
          .pipe(
            map((response: ApiResponse) => response.success ?
              bulkUpdate_Success(action.allActionRecords) : bulkUpdate_Failure(action.allActionRecords)),
            catchError((error) => of(bulkUpdate_Failure(action.allActionRecords)))
          );
      })
    );
  });
}