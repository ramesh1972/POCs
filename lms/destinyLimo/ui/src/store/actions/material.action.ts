import { createAction, props } from '@ngrx/store';

import { MaterialCategory } from '../models/MaterialCategory';
import { TrainingMaterial } from '../models/Material'
import { MaterialFile } from '../models/MaterialFile';
import { MaterialText } from '../models/MaterialText';
import { MaterialVideo } from '../models/MaterialVideo';
import { MaterialMCQ } from '../models/MaterialMCQ';

// fetch MaterialCategory
export const invokeMaterialCategoryFetchAPI = createAction(
  '[MaterialCategory API] Invoke MaterialCategory Fetch API'
);

export const materialCategoryFetchAPI_Success = createAction(
  '[MaterialCategory API] Fetch API Success',
  props<{ allMaterialCategory: MaterialCategory[] }>()
);

// fetch TrainingMaterial
export const invokeMaterialFetchAPI = createAction(
  '[Material API] Invoke Material Fetch API'
);

export const materialFetchAPI_Success = createAction(
  '[Material API] Fetch API Success',
  props<{ allMaterials: TrainingMaterial[] }>()
);

// fetch MaterialFile
export const invokeMaterialFileFetchAPI = createAction(
  '[MaterialFile API] Invoke MaterialFile Fetch API',
  props<{ isPublic: boolean }>()
);

export const materialFileFetchAPI_Success = createAction(
  '[MaterialFile API] Fetch API Success',
  props<{ allMaterialFiles: MaterialFile[] }>()
);

// fetch MaterialText
export const invokeMaterialTextFetchAPI = createAction(
  '[MaterialText API] Invoke MaterialText Fetch API',
  props<{ isPublic: boolean }>()
);

export const materialTextFetchAPI_Success = createAction(
  '[MaterialText API] Fetch API Success',
  props<{ allMaterialTexts: MaterialText[] }>()
);

export const invokeMaterialText_CreateAPI = createAction(
  '[MaterialText API] Invoke MaterialText Create API',
  props<{ materialText: MaterialText }>()
);

export const materialText_CreateAPI_Success = createAction(
  '[MaterialText API] Create API Success',
  props<{ materialText: any }>()
);

export const invokeMaterialText_CreateAPI_Failure = createAction(
  '[MaterialText API] Create API Failure',
  props<{ error: any }>()
);

export const invokeMaterialText_UpdateAPI = createAction(
  '[MaterialText API] Invoke MaterialText Update API',
  props<{ materialText: MaterialText }>()
);

export const materialText_UpdateAPI_Success = createAction(
  '[MaterialText API] Update API Success',
  props<{ materialText: MaterialText }>()
);

export const invokeMaterialText_UpdateAPI_Failure = createAction(
  '[MaterialText API] Update API Failure',
  props<{ error: any }>()
);

export const invokeMaterialText_DeleteAPI = createAction(
  '[MaterialText API] Invoke MaterialText Delete API',
  props<{ material_id: number }>()
);

export const materialText_DeleteAPI_Success = createAction(
  '[MaterialText API] Delete API Success',
  props<{ success: boolean }>()
);

export const invokeMaterialText_DeleteAPI_Failure = createAction(
  '[MaterialText API] Delete API Failure',
  props<{ error: any }>()
);


// fetch MaterialVideo
export const invokeMaterialVideoFetchAPI = createAction(
  '[MaterialVideo API] Invoke MaterialVideo Fetch API',
  props<{ isPublic: boolean }>()
);

export const materialVideoFetchAPI_Success = createAction(
  '[MaterialVideo API] Fetch API Success',
  props<{ allMaterialVideos: MaterialVideo[] }>()
);

// fetch MaterialMCQ
export const invokeMaterialMCQFetchAPI = createAction(
  '[MaterialMCQ API] Invoke MaterialMCQ Fetch API',
  props<{ isPublic: boolean }>()
);

export const materialMCQFetchAPI_Success = createAction(
  '[MaterialMCQ API] Fetch API Success',
  props<{ allMaterialMCQs: MaterialMCQ[] }>()
);

export const invokeMaterialMCQ_CreateAPI = createAction(
  '[MaterialMCQ API] Invoke MaterialMCQ Create API',
  props<{ materialMCQ: MaterialMCQ }>()
);

export const materialMCQ_CreateAPI_Success = createAction(
  '[MaterialMCQ API] Create API Success',
  props<{ materialMCQ: MaterialMCQ }>()
);

export const invokeMaterialMCQ_UpdateAPI = createAction(
  '[MaterialMCQ API] Invoke MaterialMCQ Update API',
  props<{ materialMCQ: MaterialMCQ }>()
);

export const materialMCQ_UpdateAPI_Success = createAction(
  '[MaterialMCQ API] Update API Success',
  props<{ materialMCQ: MaterialMCQ }>()
);

export const invokeMaterialMCQ_DeleteAPI = createAction(
  '[MaterialMCQ API] Invoke MaterialMCQ Delete API',
  props<{ material_id: number }>()
);

export const materialMCQ_DeleteAPI_Success = createAction(
  '[MaterialMCQ API] Delete API Success',
  props<{ success: boolean }>()
);



