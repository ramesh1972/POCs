import { createAction, props } from '@ngrx/store';

import { UserAskedQuestion } from '../models/UserAskedQuestion';

// create all actiions fot apis/user-question.service.ts
export const invokeUserQuestionsFetchAPI = createAction(
  '[UserQuestion API] Invoke UserQuestion Fetch API',
  props<{ includeOnlyAnswered: boolean }>()
);

export const UserQuestionsFetchAPI_Success = createAction(
  '[UserQuestion API] Fetch API Success',
  props<{ allQuestions: UserAskedQuestion[] }>()
);

export const invokeUserQuestionsForUserFetchAPI = createAction(
  '[UserQuestion API] Invoke UserQuestion For User Fetch API',
  props<{ userId: number }>()
);

export const UserQuestionsForUserFetchAPI_Success = createAction(
  '[UserQuestion API] Fetch API Success',
  props<{ allUserQuestions: UserAskedQuestion[] }>()
);

export const invokeUserQuestionByIdFetchAPI = createAction(
  '[UserQuestion API] Invoke UserQuestion By Id Fetch API',
  props<{ questionId: number }>()
);

export const UserQuestionByIdFetchAPI_Success = createAction(
  '[UserQuestion API] Fetch API Success',
  props<{ question: UserAskedQuestion }>()
);

export const invokePublicQuestionsFetchAPI = createAction(
  '[UserQuestion API] Invoke Public Questions Fetch API'
);

export const PublicQuestionsFetchAPI_Success = createAction(
  '[UserQuestion API] Fetch API Success',
  props<{ publicQuestions: UserAskedQuestion[] }>()
);

export const invokeUserQuestionCreateAPI = createAction(
  '[UserQuestion API] Invoke Create UserQuestion API',
  props<{ question: UserAskedQuestion }>()
);

export const createUserQuestion_Success = createAction(
  '[UserQuestion API] Create UserQuestion Success',
  props<{ question: UserAskedQuestion }>()
);

export const invokeUserQuestionUpdateAPI = createAction(
  '[UserQuestion API] Invoke Update UserQuestion API',
  props<{ questionId: number, question: UserAskedQuestion }>()
);

export const updateUserQuestion_Success = createAction(
  '[UserQuestion API] Update UserQuestion Success',
  props<{ success: boolean }>()
);

export const invokeUserQuestionDeleteAPI = createAction(
  '[UserQuestion API] Invoke Delete UserQuestion API',
  props<{ questionId: number }>()
);

export const deleteUserQuestion_Success = createAction(
  '[UserQuestion API] Delete UserQuestion Success',
  props<{ success: boolean }>()
);

export const invokeAnswerUserQuestionAPI = createAction(
  '[UserQuestion API] Invoke Answer UserQuestion API',
  props<{ questionId: number, admin_user_id: number, answer: string }>()
);

export const answerUserQuestion_Success = createAction(
  '[UserQuestion API] Answer UserQuestion Success',
  props<{ success: boolean }>()
);

export const invokeUserQuestionPublishAPI = createAction(
  '[UserQuestion API] Invoke Publish UserQuestion API',
  props<{ questionId: number }>()
);

export const publishUserQuestion_Success = createAction(
  '[UserQuestion API] Publish UserQuestion Success',
  props<{ success: boolean }>()
);

export const invokeUserQuestionUnpublishAPI = createAction(
  '[UserQuestion API] Invoke Unpublish UserQuestion API',
  props<{ questionId: number }>()
);

export const unpublishUserQuestion_Success = createAction(
  '[UserQuestion API] Unpublish UserQuestion Success',
  props<{ success: boolean }>()
);

