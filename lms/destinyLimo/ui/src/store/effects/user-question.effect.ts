import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { Store, Action } from '@ngrx/store';
import { catchError, map, switchMap } from 'rxjs/operators';
import { Observable, of } from 'rxjs';

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
  invokeUserQuestionUnpublishAPI, unpublishUserQuestion_Success,
  UserQuestionsFetchAPI_Failure
} from '../actions/user-question.action';
import { ApiResponse } from '../models/ApiResponse';

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
          map((allQuestions: ApiResponse) => UserQuestionsFetchAPI_Success({ allQuestions: allQuestions.data as UserAskedQuestion[] })),
          catchError((error: any) => {
            console.error('error fetching questions', error);
            return of(UserQuestionsFetchAPI_Failure({ error: error.message, data: error.data }));
          })
        )))
  });


  invokeUserQuestionsForUserFetchAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserQuestionsForUserFetchAPI),
      switchMap((action) => this.userAskedQuestionService.getQuestionsForUser(action.userId)
        .pipe(
          map((allUserQuestions: ApiResponse) => UserQuestionsForUserFetchAPI_Success({ allUserQuestions: allUserQuestions.data as UserAskedQuestion[] })),
          catchError((error: any) => {
            console.error('error fetching questions for user', error);
            return of(UserQuestionsFetchAPI_Failure({ error: error.message, data: error.data }));
          })
        )))
  });

  invokeUserQuestionByIdFetchAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserQuestionByIdFetchAPI),
      switchMap((action) => this.userAskedQuestionService.getQuestionById(action.questionId)
        .pipe(
          map((question: ApiResponse) => UserQuestionByIdFetchAPI_Success({ question: question.data as UserAskedQuestion })),
          catchError((error: any) => {
            console.error('error fetching question by id', error);
            return of(UserQuestionsFetchAPI_Failure({ error: error.message, data: error.data }));
          })
        )))
  });

  invokePublicQuestionsFetchAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokePublicQuestionsFetchAPI),
      switchMap(() => this.userAskedQuestionService.getPublicQuestions()
        .pipe(
          map((publicQuestions: ApiResponse) => PublicQuestionsFetchAPI_Success({ publicQuestions: publicQuestions.data as UserAskedQuestion[] })),
          catchError((error: any) => {
            console.error('error fetching public questions', error);
            return of(UserQuestionsFetchAPI_Failure({ error: error.message, data: error.data }));
          })
        )))
  });

  invokeUserQuestionCreateAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserQuestionCreateAPI),
      switchMap((action) => this.userAskedQuestionService.submitNewQuestion(action.question)
        .pipe(
          map((data: ApiResponse) => createUserQuestion_Success({ question: data.data as UserAskedQuestion })),
          catchError((error: any) => {
            console.error('error creating question', error);
            return of(UserQuestionsFetchAPI_Failure({ error: error.message, data: error.data }));
          })
        )))
  });

  invokeUserQuestionUpdateAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserQuestionUpdateAPI),
      switchMap((action) => this.userAskedQuestionService.updateQuestion(action.questionId, action.question)
        .pipe(
          map((data: ApiResponse) => updateUserQuestion_Success({ success: data.data as boolean })),
          catchError((error: any) => {
            console.error('error updating question', error);
            return of(UserQuestionsFetchAPI_Failure({ error: error.message, data: error.data }));
          })
        )))
  });

  invokeAnswerUserQuestionAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeAnswerUserQuestionAPI),
      switchMap((action) => this.userAskedQuestionService.answerQuestion(action.questionId, action.answer, action.admin_user_id)
        .pipe(
          map((data: ApiResponse) => answerUserQuestion_Success({ success: true })),
          catchError((error: any) => {
            console.error('error answering question', error);
            return of(UserQuestionsFetchAPI_Failure({ error: error.message, data: error.data }));
          })
        )))
  });

  invokeUserQuestionDeleteAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserQuestionDeleteAPI),
      switchMap((action) => this.userAskedQuestionService.deleteQuestion(action.questionId)
        .pipe(
          map(() => deleteUserQuestion_Success({ success: true })),
          catchError((error: any) => {
            console.error('error deleting question', error);
            return of(UserQuestionsFetchAPI_Failure({ error: error.message, data: error.data }));
          })
        )))
  });

  invokeUserQuestionPublishAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserQuestionPublishAPI),
      switchMap((action) => this.userAskedQuestionService.makePublic(action.questionId)
        .pipe(
          map(() => publishUserQuestion_Success({ success: true })),
          catchError((error: any) => {
            console.error('error publishing question', error);
            return of(UserQuestionsFetchAPI_Failure({ error: error.message, data: error.data }));
          })
        )))
  });

  invokeUserQuestionUnpublishAPI$: Observable<Action> = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserQuestionUnpublishAPI),
      switchMap((action) => this.userAskedQuestionService.makePrivate(action.questionId)
        .pipe(
          map(() => unpublishUserQuestion_Success({ success: true })),
          catchError((error: any) => {
            console.error('error unpublishing question', error);
            return of(UserQuestionsFetchAPI_Failure({ error: error.message, data: error.data }));
          })
        )))
  });
}

