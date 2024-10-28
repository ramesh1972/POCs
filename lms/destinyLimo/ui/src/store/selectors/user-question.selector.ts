import { createFeatureSelector, createSelector } from '@ngrx/store';

import { UserAskedQuestion } from '../models/UserAskedQuestion';
import { UserAskedQuestionState } from '../states/user-question.state';

export const UserAskedQuestionFeatureKey = 'user-questions';

export const selectUserAskedQuestionState = createFeatureSelector<UserAskedQuestionState>(UserAskedQuestionFeatureKey);

export const selectAllQuestions = createSelector(
  selectUserAskedQuestionState,
  (state: UserAskedQuestionState) => state.allQuestions
);

export const selectUserQuestions = createSelector(
  selectUserAskedQuestionState,
  (state: UserAskedQuestionState) => state.userQuestions
);

export const selectPublicQuestions = createSelector(
  selectUserAskedQuestionState,
  (state: UserAskedQuestionState) => state.publicQuestions
);

export const selectQuestion = createSelector(
  selectUserAskedQuestionState,
  (state: UserAskedQuestionState) => state.question
);

export const selectQuestionById = (questionId: number) => createSelector(
  selectAllQuestions,
  (allQuestions: UserAskedQuestion[]) => allQuestions.find(q => q.id === questionId)
);

