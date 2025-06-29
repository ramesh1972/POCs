import { createAction, props } from '@ngrx/store';

import { UserExam } from '../models/Exam';
import { UserExamAnswer } from '../models/UserExamAnswer';

// fetch UserExam
export const invokeUserExamsFetchAPI = createAction(
  '[UserExam API] Invoke UserExam Fetch API',
  props<{ onlyExamsNotStarted: boolean }>()
);

export const UserExamsFetchAPI_Success = createAction(
  '[UserExam API] Fetch API Success',
  props<{ allExams: UserExam[] }>()
);

export const UserExamsFetchAPI_Failure = createAction(
  '[UserExam API] Fetch API Failure',
  props<{ error: string, data: any }>()
);


export const invokeUserExamsForUserFetchAPI = createAction(
  '[UserExam API] Invoke UserExam For User Fetch API',
  props<{ userId: number }>()
);

export const UserExamsForUserFetchAPI_Success = createAction(
  '[UserExam API] Fetch API Success',
  props<{ allUserExams: UserExam[] }>()
);

export const UserExamsForUserFetchAPI_Failure = createAction(
  '[UserExam API] Fetch API Failure',
  props<{ error: string, data: any }>()
);


export const invokeExamByIdFetchAPI = createAction(
  '[UserExam API] Invoke UserExam By examId Fetch API',
  props<{ examId: number }>()
);

export const ExamFetchById_Success = createAction(
  '[UserExam API] Fetch UserExam Success',
  props<{ newExam: UserExam }>()
);

export const ExamFetchById_Failure = createAction(
  '[UserExam API] Fetch API Failure',
  props<{ error: string, data: any }>()
);


export const invokeUserExamByIdFetchAPI = createAction(
  '[UserExam API] Invoke UserExam By Id Fetch API',
  props<{ examId: number }>()
);

export const UserExamByIdFetchAPI_Success = createAction(
  '[UserExam API] Fetch API Success',
  props<{ examAnswers: UserExamAnswer[] }>()
);

export const UserExamByIdFetchAPI_Failure = createAction(
  '[UserExam API] Fetch API Failure',
  props<{ error: string, data: any }>()
);


// create & submit UserExam
export const invokeUserExamCreateAPI = createAction(
  '[UserExam API] Invoke Create UserExam API',
  props<{ userId: number }>()
);

export const createUserExam = createAction(
  '[UserExam API] Create UserExam',
  props<{ userId: number }>()
);

export const createUserExamSuccess = createAction(
  '[UserExam API] Create UserExam Success',
  props<{ newExam: UserExam }>()
);

export const createUserExamSuccess_Failure = createAction(
  '[UserExam API] Fetch API Failure',
  props<{ error: string, data: any }>()
);

export const createUserExamFailure = createAction(
  '[UserExam API] Create UserExam Failure',
  props<{ error: string, data: any }>()
);

export const invokeCreateUserExamByAdmin = createAction(
  '[UserExam API] Create UserExam',
  props<{ userId: number }>()
);

export const createUserExamSuccessByAdmin = createAction(
  '[UserExam API] Create UserExam Success',
  props<{ newExam: UserExam }>()
);

export const createUserExamByAdmin_Failure = createAction(
  '[UserExam API] Fetch API Failure',
  props<{ error: string, data: any }>()
);

export const invokeSubmitUserExamAPI = createAction(
  '[UserExam API] Invoke Submit UserExam API',
  props<{ exam: UserExam }>()
);

export const submitUserExam = createAction(
  '[UserExam API] Update UserExam',
  props<{ exam: UserExam }>()
);

export const submitUserExam_Success = createAction(
  '[UserExam API] Submit UserExam Success',
  props<{ exam: UserExam }>()
);

export const submitUserExam_Failure = createAction(
  '[UserExam API] Fetch API Failure',
  props<{ error: string, data: any }>()
);