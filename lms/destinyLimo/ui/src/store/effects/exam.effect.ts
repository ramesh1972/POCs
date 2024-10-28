import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { select, Store, Action } from '@ngrx/store';
import { catchError, map, mergeMap, switchMap, withLatestFrom } from 'rxjs/operators';
import { Observable, throwError } from 'rxjs';

import { UserExam } from '../models/Exam';
import { ExamService } from '../apis/exam.service';

import { invokeUserExamsFetchAPI, UserExamsFetchAPI_Success, invokeUserExamsForUserFetchAPI, UserExamsForUserFetchAPI_Success, invokeUserExamByIdFetchAPI, UserExamByIdFetchAPI_Success, invokeUserExamCreateAPI, createUserExamSuccess, invokeSubmitUserExamAPI, ExamFetchById_Success, invokeExamByIdFetchAPI, invokeCreateUserExamByAdmin, createUserExamSuccessByAdmin } from '../actions/exam.action';
import { UserExamAnswer } from '../models/UserExamAnswer';

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
          .pipe(map((data: UserExam[]) => UserExamsFetchAPI_Success({ allExams: data as UserExam[] }))
          );
      }));
  });

  loadAllUserExamForUser$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserExamsForUserFetchAPI),
      mergeMap((action) => {
        return this.UserExamService
          .getExamsForUser(action.userId)
          .pipe(map((data: UserExam[]) => UserExamsForUserFetchAPI_Success({ allUserExams: data as UserExam[] }))
          );
      }));
  });

  loadUserExamById$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeExamByIdFetchAPI),
      mergeMap((action) => {
        return this.UserExamService
          .getUserExamByExamId(action.examId)
          .pipe(map((data: UserExam) => ExamFetchById_Success({ newExam: data as UserExam }))
          );
      }));
  });

  loadUserExamAnswers$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserExamByIdFetchAPI),
      mergeMap((action) => {
        return this.UserExamService
          .getUserExamsByExamId(action.examId)
          .pipe(map((data: UserExamAnswer[]) => UserExamByIdFetchAPI_Success({ examAnswers: data as UserExamAnswer[] }))
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
            map(() => {
              console.log('UserExam updated');
              return { type: 'UPDATE_UserExam_SUCCESS' } as Action<string>;
            }),
            catchError((error: any) => {
              console.error('error updating UserExam', error);
              return throwError(error);
            })
          );
      })
    );
  });

  createUserExam$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserExamCreateAPI),
      switchMap(action => {
        return this.UserExamService
          .createExam(action.userId)
          .pipe(map((data: UserExam) => createUserExamSuccess({ newExam: data as UserExam }))
          );
      }));
  });

  createUserExamByAdmin$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeCreateUserExamByAdmin),
      switchMap(action => {
        return this.UserExamService
          .createExamByAdmin(action.userId)
          .pipe(map((data: UserExam) => createUserExamSuccessByAdmin({ newExam: data as UserExam }))
          );
      }));
  });
}


