// // import the interface
import { createReducer, on } from '@ngrx/store';

import { MaterialMCQ } from '../models/MaterialMCQ';

import  {
  materialCategoryFetchAPI_Success,
  materialFetchAPI_Success,
  materialFileFetchAPI_Success,
  materialTextFetchAPI_Success,
  materialVideoFetchAPI_Success,
  materialMCQFetchAPI_Success,
  materialText_CreateAPI_Success,
  materialText_UpdateAPI_Success,
  materialMCQ_CreateAPI_Success,
  materialMCQ_UpdateAPI_Success,
  materialFetchAPI_Failure,
  materialFileFetchAPI_Failure,
  materialMCQ_CreateAPI_Failure,
  materialMCQ_UpdateAPI_Failure,
  materialMCQFetchAPI_Failure,
  materialText_CreateAPI_Failure,
  materialText_UpdateAPI_Failure,
  materialTextFetchAPI_Failure,
  materialVideoFetchAPI_Failure
} from '../actions/material.action';

// state interface
import { MaterialState } from '../states/material.state';

//create a dummy initial state
export const initialState: MaterialState = {
  categories: [],
  selectedCategory: undefined,
  materials: [],
  selectedMaterial: undefined,
  videos: [],
  files: [],
  texts: [],
  mcqs: [],
  materialText: undefined
};

export const materialReducer = createReducer(
  initialState,
  on(materialCategoryFetchAPI_Success, (state, { allMaterialCategory }) => {
    console.log("all cats2", allMaterialCategory);
    return { ...state, categories: allMaterialCategory };
  }),
  
  on(materialFetchAPI_Success, (state, { allMaterials }) => {
    return { ...state, materials: allMaterials };
  }),
  
  on(materialFetchAPI_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(materialFileFetchAPI_Success, (state, { allMaterialFiles }) => {
    console.log("all files", allMaterialFiles);
    return { ...state, files: allMaterialFiles };
  }),

  on(materialFileFetchAPI_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(materialTextFetchAPI_Success, (state, { allMaterialTexts }) => {
    return { ...state, texts: allMaterialTexts };
  }),

  on(materialTextFetchAPI_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(materialVideoFetchAPI_Success, (state, { allMaterialVideos }) => {
    return { ...state, videos: allMaterialVideos };
  }),

  on(materialVideoFetchAPI_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(materialMCQFetchAPI_Success, (state, { allMaterialMCQs }) => {
    return { ...state, mcqs: allMaterialMCQs };
  }),

  on(materialMCQFetchAPI_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(materialText_CreateAPI_Success, (state, { materialText }) => {
    return { ...state, materialText: materialText };
  }),

  on(materialText_CreateAPI_Failure , (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(materialText_UpdateAPI_Success, (state, { materialText }) => {
    return { ...state, materialText: materialText };
  }),

  on(materialText_UpdateAPI_Failure , (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(materialMCQ_CreateAPI_Success, (state, { materialMCQ }) => {
    return { ...state, materialMCQ: materialMCQ };
  }),

  on(materialMCQ_CreateAPI_Failure , (state, { error }) => {
    return { ...state, error: error };
  } 
  ),

  on(materialMCQ_UpdateAPI_Success, (state, { materialMCQ }) => {
    return { ...state, materialMCQ: materialMCQ };
  }),

  on(materialMCQ_UpdateAPI_Failure , (state, { error }) => {
    return { ...state, error: error };
  })
);