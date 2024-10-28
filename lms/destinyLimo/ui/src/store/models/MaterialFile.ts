import { TrainingMaterial } from "./Material";

export interface MaterialFile extends TrainingMaterial{
    file_id: number;
    material_id: number;
    file_name: string;
}
