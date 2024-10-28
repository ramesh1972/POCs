// // import the interface
import { createReducer, on } from '@ngrx/store';

import { UserExam } from '../models/Exam';
import { ExamState } from '../states/exam.state';
import { ExamFetchById_Success, UserExamByIdFetchAPI_Success, UserExamsFetchAPI_Success,  UserExamsForUserFetchAPI_Success, createUserExamSuccess, createUserExamSuccessByAdmin } from '../actions/exam.action';

//create a dummy initial state
export const initialState: ExamState = {
  allExams: [],
  allUserExams: [],
  newExam : undefined,
  exam: undefined,
  examAnswers: []
};

export const examReducer = createReducer(
  initialState,
  on(UserExamsFetchAPI_Success, (state, { allExams }) => {
    return { ...state, allExams: allExams };
  }),

  on(UserExamsForUserFetchAPI_Success, (state, { allUserExams }) => {
    return { ...state, allUserExams: allUserExams };
  }),

  on(UserExamByIdFetchAPI_Success, (state, { examAnswers }) => {
    return { ...state, examAnswers: examAnswers };
  }),

  on(ExamFetchById_Success, (state, { newExam }) => {
    return { ...state, newExam: newExam };
  }),
  
  on(createUserExamSuccess, (state, { newExam }) => {
    return { ...state, newExam: newExam };
  }),

  on(createUserExamSuccessByAdmin, (state, { newExam }) => {
    return { ...state, newExam: newExam };
  })
);

