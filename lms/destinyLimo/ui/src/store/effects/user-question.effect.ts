import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { select, Store, Action } from '@ngrx/store';
import { catchError, map, mergeMap, switchMap, withLatestFrom } from 'rxjs/operators';
import { Observable, throwError } from 'rxjs';

import { UserAskedQuestion } from '../models/UserAskedQuestion';
import { UserAskedQuestionService } from '../apis/user-question.service';

import {
  invokeUserQuestionsFetchAPI, UserQuestionsFetchAPI_Success,
  invokeUserQuestionsForUserFetchAPI, UserQuestionsForUserFetchAPI_Success,
  invokeUserQuestionByIdFetchAPI, UserQuestionByIdFetchAPI_Success,
  invokePublicQuestionsFetchAPI, PublicQuestionsFetchAPI_Success,
  invokeUserQuestionCreateAPI, createUserQuestion_Success,
  invokeUserQuestionUpdateAPI, updateUserQuestion_Success,
  invokeAnswerUserQuestionAPI, answerUserQuestion_Success,
  invokeUserQuestionDeleteAPI, deleteUserQuestion_Success,
  invokeUserQuestionPublishAPI, publishUserQuestion_Success,
  invokeUserQuestionUnpublishAPI, unpublishUserQuestion_Success
} from '../actions/user-question.action';

@Injectable()
export class UserAskedQuestionEffect {
  constructor(
    private actions$: Actions,
    private userAskedQuestionService: UserAskedQuestionService,
    private store: Store
  ) { }

  invokeUserQuestionsFetchAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserQuestionsFetchAPI),
      switchMap((action) => this.userAskedQuestionService.getQuestions(action.includeOnlyAnswered)
        .pipe(
          map((allQuestions: UserAskedQuestion[]) => UserQuestionsFetchAPI_Success({ allQuestions })),
          catchError((error: any) => throwError(error))
        )))
  });

  invokeUserQuestionsForUserFetchAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserQuestionsForUserFetchAPI),
      switchMap((action) => this.userAskedQuestionService.getQuestionsForUser(action.userId)
        .pipe(
          map((allUserQuestions: UserAskedQuestion[]) => UserQuestionsForUserFetchAPI_Success({ allUserQuestions })),
          catchError((error: any) => throwError(error))
        )))
  });

  invokeUserQuestionByIdFetchAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserQuestionByIdFetchAPI),
      switchMap((action) => this.userAskedQuestionService.getQuestionById(action.questionId)
        .pipe(
          map((question: UserAskedQuestion) => UserQuestionByIdFetchAPI_Success({ question })),
          catchError((error: any) => throwError(error))
        )))
  });

  invokePublicQuestionsFetchAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokePublicQuestionsFetchAPI),
      switchMap(() => this.userAskedQuestionService.getPublicQuestions()
        .pipe(
          map((publicQuestions: UserAskedQuestion[]) => PublicQuestionsFetchAPI_Success({ publicQuestions })),
          catchError((error: any) => throwError(error))
        )))
  });

  invokeUserQuestionCreateAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserQuestionCreateAPI),
      switchMap((action) => this.userAskedQuestionService.submitNewQuestion(action.question)
        .pipe(
          map(() => createUserQuestion_Success({ question: action.question })),
          catchError((error: any) => throwError(error))
        )))
  });

  invokeUserQuestionUpdateAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserQuestionUpdateAPI),
      switchMap((action) => this.userAskedQuestionService.updateQuestion(action.questionId, action.question)
        .pipe(
          map(() => updateUserQuestion_Success({ success: true })),
          catchError((error: any) => throwError(error))
        )))
  });

  invokeAnswerUserQuestionAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeAnswerUserQuestionAPI),
      switchMap((action) => this.userAskedQuestionService.answerQuestion(action.questionId, action.answer, action.admin_user_id)
        .pipe(
          map(() => answerUserQuestion_Success({ success: true })),
          catchError((error: any) => throwError(error))
        )))
  });

  invokeUserQuestionDeleteAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserQuestionDeleteAPI),
      switchMap((action) => this.userAskedQuestionService.deleteQuestion(action.questionId)
        .pipe(
          map(() => deleteUserQuestion_Success({ success: true })),
          catchError((error: any) => throwError(error))
        )))
  });

  invokeUserQuestionPublishAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserQuestionPublishAPI),
      switchMap((action) => this.userAskedQuestionService.makePublic(action.questionId)
        .pipe(
          map(() => publishUserQuestion_Success({ success: true })),
          catchError((error: any) => throwError(error))
        )))
  });

  invokeUserQuestionUnpublishAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserQuestionUnpublishAPI),
      switchMap((action) => this.userAskedQuestionService.makePrivate(action.questionId)
        .pipe(
          map(() => unpublishUserQuestion_Success({ success: true })),
          catchError((error: any) => throwError(error))
        )))
  });
}

