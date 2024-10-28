import { TrainingMaterial } from "./Material";

export interface MaterialVideo extends TrainingMaterial{
    video_id: number;
    material_id: number;
    url: string;
    is_vimeo: boolean;
}
