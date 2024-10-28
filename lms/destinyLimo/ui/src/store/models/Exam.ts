import { MaterialMCQ } from "./MaterialMCQ";
import { UserExamAnswer } from "./UserExamAnswer";

export interface UserExam {
    examId: number;
    userId: number;
    dateCreated: Date;
    dateCreatedString: string;
    dateStarted: Date;
    dateCompleted: Date;
    score: number;
    result: number;
    certificateUrl: string;

    examQuestions: MaterialMCQ[];
    examAnswers: UserExamAnswer[];
  }