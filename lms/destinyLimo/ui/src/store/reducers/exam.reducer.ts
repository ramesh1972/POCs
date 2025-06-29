// // import the interface
import { createReducer, on } from '@ngrx/store';

import { ExamState } from '../states/exam.state';
import { ExamFetchById_Failure, ExamFetchById_Success, UserExamByIdFetchAPI_Failure, UserExamByIdFetchAPI_Success, UserExamsFetchAPI_Failure, UserExamsFetchAPI_Success, UserExamsForUserFetchAPI_Failure, UserExamsForUserFetchAPI_Success, createUserExamByAdmin_Failure, createUserExamSuccess, createUserExamSuccessByAdmin, createUserExamSuccess_Failure, submitUserExam_Failure, submitUserExam_Success } from '../actions/exam.action';

//create a dummy initial state
export const initialState: ExamState = {
  allExams: [],
  allUserExams: [],
  newExam: undefined,
  exam: undefined,
  examAnswers: []
};

export const examReducer = createReducer(
  initialState,
  on(UserExamsFetchAPI_Success, (state, { allExams }) => {
    return { ...state, allExams: allExams };
  }),

  on(UserExamsFetchAPI_Failure, (state, { error }) => {
    return { ...state, error: error };
  }),

  on(UserExamsForUserFetchAPI_Success, (state, { allUserExams }) => {
    return { ...state, allUserExams: allUserExams };
  }),

  on(UserExamsForUserFetchAPI_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(UserExamByIdFetchAPI_Success, (state, { examAnswers }) => {
    return { ...state, examAnswers: examAnswers };
  }),

  on(ExamFetchById_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(ExamFetchById_Success, (state, { newExam }) => {
    return { ...state, newExam: newExam };
  }),

  on(UserExamByIdFetchAPI_Success, (state, { examAnswers }) => {
    return { ...state, examAnswers: examAnswers };
  }
  ),

  on(UserExamByIdFetchAPI_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(createUserExamSuccess, (state, { newExam }) => {
    return { ...state, newExam: newExam };
  }),

  on(createUserExamSuccess_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(createUserExamSuccessByAdmin, (state, { newExam }) => {
    return { ...state, newExam: newExam };
  }
  ),

  on(createUserExamByAdmin_Failure, (state, { error }) => {
    return { ...state, error: error };
  }),

  on(submitUserExam_Success, (state, { exam }) => {
    return { ...state, exam: exam };
  }
  ),

  on(submitUserExam_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  )
);

