import { MaterialMCQ } from "./MaterialMCQ";

export interface UserExamAnswer {
    exam_id: number;          // exam_id
    exam_question_id?: number; // exam_question_id
    mcq_id: number;           // mcq_id
    choice_1_answer: boolean; // choice_1_answer
    choice_2_answer: boolean; // choice_2_answer
    choice_3_answer: boolean; // choice_3_answer
    choice_4_answer: boolean; // choice_4_answer
    attempted: boolean;       // attempted
    is_correct: boolean;      // is_correct
}
