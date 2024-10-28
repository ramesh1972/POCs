import { createFeatureSelector, createSelector } from '@ngrx/store';

import { ExamState } from '../states/exam.state';
import { UserExam } from '../models/Exam';

export const UserExamFeatureKey = 'exams';

export const selectUserExamState = createFeatureSelector<ExamState>(UserExamFeatureKey);

export const selectUserExams = createSelector(
  selectUserExamState,
  (state: ExamState) => state.allExams
);

export const selectUserExamsById = (userId: number) => createSelector(
  selectUserExamState,
  (state: ExamState) => state.allUserExams
);

export const selectnewExam = () => createSelector(
  selectUserExamState,
  (state: ExamState) => state.newExam
);

export const selectExamAnswers = () => createSelector(
  selectUserExamState,
  (state: ExamState) => state.examAnswers
);

export const selectExam = (examId: number) => createSelector(
  selectUserExams,
  (allExams: UserExam[]) => allExams.find(e => e.examId === examId)
);