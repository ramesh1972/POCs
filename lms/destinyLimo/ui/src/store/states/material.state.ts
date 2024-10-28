import { MaterialCategory } from "../models/MaterialCategory";
import { TrainingMaterial } from '../models/Material'
import { MaterialFile } from '../models/MaterialFile';
import { MaterialText } from '../models/MaterialText';
import { MaterialVideo } from '../models/MaterialVideo';
import { MaterialMCQ } from '../models/MaterialMCQ';

// state interface
export interface MaterialState {
    categories: MaterialCategory[];
    selectedCategory?: MaterialCategory;
    materials: TrainingMaterial[];
    selectedMaterial?: TrainingMaterial;
    videos: MaterialVideo[];
    files: MaterialFile[];
    texts: MaterialText[];
    mcqs: MaterialMCQ[];
    materialText?: MaterialText;
    materialMCQ?: MaterialMCQ;
}