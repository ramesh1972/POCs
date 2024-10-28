// // import the interface
import { createReducer, on } from '@ngrx/store';

import { MaterialCategory } from "../models/MaterialCategory";
import { TrainingMaterial } from '../models/Material'
import { MaterialFile } from '../models/MaterialFile';
import { MaterialText } from '../models/MaterialText';
import { MaterialVideo } from '../models/MaterialVideo';
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
  materialMCQ_UpdateAPI_Success
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
    return { ...state, categories: allMaterialCategory };
  }),
  on(materialFetchAPI_Success, (state, { allMaterials }) => {
    return { ...state, materials: allMaterials };
  }),
  on(materialFileFetchAPI_Success, (state, { allMaterialFiles }) => {
    console.log("all files", allMaterialFiles);
    return { ...state, files: allMaterialFiles };
  }),
  on(materialTextFetchAPI_Success, (state, { allMaterialTexts }) => {
    return { ...state, texts: allMaterialTexts };
  }),
  on(materialVideoFetchAPI_Success, (state, { allMaterialVideos }) => {
    return { ...state, videos: allMaterialVideos };
  }),
  on(materialMCQFetchAPI_Success, (state, { allMaterialMCQs }) => {
    return { ...state, mcqs: allMaterialMCQs };
  }),
  on(materialText_CreateAPI_Success, (state, { materialText }) => {
    return { ...state, materialText: materialText };
  }),
  on(materialText_UpdateAPI_Success, (state, { materialText }) => {
    return { ...state, materialText: materialText };
  }),
  on(materialMCQ_CreateAPI_Success, (state, { materialMCQ }) => {
    return { ...state, materialMCQ: materialMCQ };
  }),
  on(materialMCQ_UpdateAPI_Success, (state, { materialMCQ }) => {
    return { ...state, materialMCQ: materialMCQ };
  }),
);