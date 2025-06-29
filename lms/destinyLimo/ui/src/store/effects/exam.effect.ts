import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { Store } from '@ngrx/store';
import { catchError, map, mergeMap, switchMap } from 'rxjs/operators';
import { Observable, of, throwError } from 'rxjs';

import { UserExam } from '../models/Exam';
import { ExamService } from '../apis/exam.service';

import { invokeUserExamsFetchAPI, UserExamsFetchAPI_Success, invokeUserExamsForUserFetchAPI, UserExamsForUserFetchAPI_Success, invokeUserExamByIdFetchAPI, UserExamByIdFetchAPI_Success, invokeUserExamCreateAPI, createUserExamSuccess, invokeSubmitUserExamAPI, ExamFetchById_Success, invokeExamByIdFetchAPI, invokeCreateUserExamByAdmin, createUserExamSuccessByAdmin, UserExamsFetchAPI_Failure, createUserExamFailure, createUserExamByAdmin_Failure, submitUserExam_Success, submitUserExam_Failure } from '../actions/exam.action';
import { UserExamAnswer } from '../models/UserExamAnswer';
import { ApiResponse } from '../models/ApiResponse';

@Injectable()
export class ExamEffect {
  constructor(
    private actions$: Actions,
    private UserExamService: ExamService,
    private store: Store
  ) { }

  loadAllUserExam$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserExamsFetchAPI),
      mergeMap((action) => {
        return this.UserExamService
          .getExams(action.onlyExamsNotStarted)
          .pipe(map((response: ApiResponse) => UserExamsFetchAPI_Success({ allExams: response.data as UserExam[] })),
          catchError((error: any) => {
            console.error('error fetching exams', error);
            return of(UserExamsFetchAPI_Failure({ error: error.message, data: error.data }));
          })
        );
      }
    ));
  }
  );

  loadAllUserExamForUser$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserExamsForUserFetchAPI),
      mergeMap((action) => {
        return this.UserExamService
          .getExamsForUser(action.userId)
          .pipe(map((response: ApiResponse) => UserExamsForUserFetchAPI_Success({ allUserExams: response.data as UserExam[] })),
          catchError((error: any) => {
            console.error('error fetching exams for user', error);
            return of(UserExamsFetchAPI_Failure({ error: error.message, data: error.data }));
          }
          )
        );
      }
    ));
  });

  loadUserExamById$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeExamByIdFetchAPI),
      mergeMap((action) => {
        return this.UserExamService
          .getUserExamByExamId(action.examId)
          .pipe(map((response: ApiResponse) => ExamFetchById_Success({ newExam: response.data as UserExam })),
          catchError((error: any) => {
            console.error('error fetching exam by id', error);
            return throwError(() => error);
          })    
          );
      }));
  });

  loadUserExamAnswers$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserExamByIdFetchAPI),
      mergeMap((action) => {
        return this.UserExamService
          .getUserExamsByExamId(action.examId)
          .pipe(map((response: ApiResponse) => UserExamByIdFetchAPI_Success({ examAnswers: response.data as UserExamAnswer[] })),
          catchError((error: any) => {
            console.error('error fetching exam answers', error);
            return of(UserExamsFetchAPI_Failure({ error: error.message, data: error.data }));
          })  
          );
      }));
  });

  submitUserExam$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeSubmitUserExamAPI),
      switchMap(action => {
        return this.UserExamService
          .submitExam(action.exam)
          .pipe(
            map((response: ApiResponse) => {
              console.log('exam submitted', response);
              return submitUserExam_Success({ exam: response.data as UserExam });
            }
            ),
            catchError((error: any) => {
              console.error('error submitting exam', error);
              return of(submitUserExam_Failure({ error: error.message, data: error.data }));
            })
          );
      }));
  });

  createUserExam$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserExamCreateAPI),
      switchMap(action => {
        return this.UserExamService
          .createExam(action.userId)
          .pipe(map((response: ApiResponse) => createUserExamSuccess({ newExam: response.data as UserExam })),
          catchError((error: any) => {
            console.error('error creating exam', error);
            return of(createUserExamFailure({ error: error.message, data: error.data }));
          })
          );
      }));
  });

  createUserExamByAdmin$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeCreateUserExamByAdmin),
      switchMap(action => {
        return this.UserExamService
          .createExamByAdmin(action.userId)
          .pipe(map((response: ApiResponse) => createUserExamSuccessByAdmin({ newExam: response.data as UserExam })),
          catchError((error: any) => {
            console.error('error creating exam by admin', error);
            return of(createUserExamByAdmin_Failure({ error: error.message, data: error.data }));
          })
          );
      }));
  });
}


