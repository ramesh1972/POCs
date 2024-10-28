import { TrainingMaterial } from './Material';

export interface    MaterialMCQ extends TrainingMaterial {
    question_id: number;
    material_id: number;
    question_text: string;
    answer_1: string;
    answer_2: string;
    answer_3: string;
    answer_4: string;
    correct_1: boolean;
    correct_2: boolean;
    correct_3: boolean;
    correct_4: boolean;
}
