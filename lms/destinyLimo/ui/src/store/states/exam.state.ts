import { UserExam } from '../models/Exam';
import { UserExamAnswer } from '../models/UserExamAnswer';

// state interface
export interface ExamState {
    allExams: UserExam[];
    allUserExams: UserExam[];
    newExam?: UserExam;
    exam?: UserExam;
    examAnswers: UserExamAnswer[];
}