import { UserAskedQuestion } from "../models/UserAskedQuestion";

// state interface
export interface UserAskedQuestionState {
    allQuestions: UserAskedQuestion[];
    userQuestions: UserAskedQuestion[];
    publicQuestions: UserAskedQuestion[];
    question?: UserAskedQuestion;
}