import { TrainingMaterial } from './Material';

export interface MaterialText extends TrainingMaterial {
    file_id: number;
    material_id: number;
    text: string;
}
