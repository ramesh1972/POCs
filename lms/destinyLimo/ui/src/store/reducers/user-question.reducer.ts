// // import the interface
import { createReducer, on } from '@ngrx/store';

import { UserAskedQuestionState } from '../states/user-question.state';
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

  on(UserQuestionsForUserFetchAPI_Success, (state, { allUserQuestions }) => {
    return { ...state, userQuestions: allUserQuestions };
  }),

  on(UserQuestionByIdFetchAPI_Success, (state, { question }) => {
    return { ...state, question: question };
  }),

  on(PublicQuestionsFetchAPI_Success, (state, { publicQuestions }) => {
    return { ...state, publicQuestions: publicQuestions };
  }),

  on(invokeUserQuestionDeleteAPI, (state, { questionId }) => {
    return { ...state, question: state.userQuestions.find((question) => question.id === questionId) };
  }
  ),

  on(createUserQuestion_Success, (state, { question }) => {
    const newUserQuestions = [...state.userQuestions];
    newUserQuestions.push(question);
    return { ...state, allUserQuestions: newUserQuestions };
  }),

  on(deleteUserQuestion_Success, (state, { success }) => {
    // splice the question from the userQuestions array
    const index = state.userQuestions.findIndex((question) => question.id === state.question?.id);
    const newUserQuestions = [...state.userQuestions];
    newUserQuestions.splice(index, 1);
    return { ...state, question: undefined, userQuestions: newUserQuestions };
  }),
);
