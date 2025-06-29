// // import the interface
import { createReducer, on } from '@ngrx/store';

import { UserAskedQuestionState } from '../states/user-question.state';

import {
  UserQuestionsFetchAPI_Success,
  UserQuestionsForUserFetchAPI_Success,
  UserQuestionByIdFetchAPI_Success,
  PublicQuestionsFetchAPI_Success,
  createUserQuestion_Success,
  deleteUserQuestion_Success,
  createUserQuestion_Failure,
  deleteUserQuestion_Failure,
  PublicQuestionsFetchAPI_Failure,
  UserQuestionByIdFetchAPI_Failure,
  UserQuestionsFetchAPI_Failure,
  UserQuestionsForUserFetchAPI_Failure
} from '../actions/user-question.action';

//create a dummy initial state
export const initialState: UserAskedQuestionState = {
  allQuestions: [],
  userQuestions: [],
  publicQuestions: [],
  question: undefined
};


export const userAskedQuestionReducer = createReducer(
  initialState,
  on(UserQuestionsFetchAPI_Success, (state, { allQuestions }) => {
    return { ...state, allQuestions: allQuestions };
  }),

  on(UserQuestionsFetchAPI_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(UserQuestionsForUserFetchAPI_Success, (state, { allUserQuestions }) => {
    return { ...state, userQuestions: allUserQuestions };
  }),

  on(UserQuestionsForUserFetchAPI_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(UserQuestionByIdFetchAPI_Success, (state, { question }) => {
    return { ...state, question: question };
  }),

  on(UserQuestionByIdFetchAPI_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(PublicQuestionsFetchAPI_Success, (state, { publicQuestions }) => {
    return { ...state, publicQuestions: publicQuestions };
  }),

  on(PublicQuestionsFetchAPI_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),



  on(createUserQuestion_Success, (state, { question }) => {
    const newUserQuestions = [...state.userQuestions];
    newUserQuestions.push(question);
    return { ...state, allUserQuestions: newUserQuestions };
  }),

  on(createUserQuestion_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(deleteUserQuestion_Success, (state, { success }) => {
    // splice the question from the userQuestions array
    const index = state.userQuestions.findIndex((question) => question.id === state.question?.id);
    const newUserQuestions = [...state.userQuestions];
    newUserQuestions.splice(index, 1);
    return { ...state, question: undefined, userQuestions: newUserQuestions };
  }),

  on(deleteUserQuestion_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),
);
