import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { select, Store, Action } from '@ngrx/store';
import { catchError, map, mergeMap, switchMap, withLatestFrom } from 'rxjs/operators';
import { Observable, of, throwError } from 'rxjs';

import { Content } from '../models/Content';
import { ContentService } from '../apis/content.service';

import { invokeContentFetchAPI, contentFetchAPI_Success, invokeContentCreateAPI, invokeUpdateContentAPI, invokeDeleteContentAPI, contentFetchAPI_Failure, updateContentAPI_Success, updateContentAPI_Failure, contentCreateAPI_Success, contentCreateAPI_Failure, deleteContentAPI_Success, deleteContentAPI_Failure } from '../actions/content.action';
import { ApiResponse } from '../models/ApiResponse';
import { data } from '@visactor/vtable';
import { create } from 'domain';

@Injectable()
export class ContentEffect {
  constructor(
    private actions$: Actions,
    private contentService: ContentService,
    private store: Store
  ) { }

  loadAllContent$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeContentFetchAPI),
      mergeMap(() => {
        return this.contentService
          .getContent()
          .pipe(map((data: ApiResponse) => contentFetchAPI_Success({ msg: data.message, allContent: data.data as Content[] })),
            catchError((error: any) => {
              console.error('error fetching content', error);
              return of(contentFetchAPI_Failure({ error: error.message, data: error.data }));
            })
          );
      }));
  });


  updateContent$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUpdateContentAPI),
      switchMap(action => {
        return this.contentService
          .updateContent(action.content)
          .pipe(
            map((data: ApiResponse) => {
              console.log('content updated');
              return updateContentAPI_Success({ msg: data.message, content: data.data as Content });
            }),
            catchError((error: any) => {
              console.error('error updating content', error);
              return of(updateContentAPI_Failure({ error: error.message, data: error.data }));
            })
          );
      }));
  });

  createContent$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeContentCreateAPI),
      switchMap(action => {
        return this.contentService
          .createContent(action.content)
          .pipe(
            map((data: ApiResponse) => {
              console.log('content created');
              return contentCreateAPI_Success({ msg: data.message, content: data.data as Content });
            }
            ),
            catchError((error: any) => {
              console.error('error creating content', error);
              return of(contentCreateAPI_Failure({ error: error.message, data: error.data }));
            })
          );
      }));
  });

  deleteContent$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeDeleteContentAPI),
      switchMap(action => {
        return this.contentService
          .deleteContent(action.Id)
          .pipe(
            map((data: ApiResponse) => {
              console.log('content deleted');
              return deleteContentAPI_Success({ msg: data.message, Id: data.data as number });
            }),
            catchError((error: any) => {
              console.error('error deleting content', error);
              return of(deleteContentAPI_Failure({ error: error.message, data: error.data }));
            })
          );
      })
    );
  });
}
