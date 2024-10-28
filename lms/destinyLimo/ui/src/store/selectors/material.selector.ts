import { createFeatureSelector, createSelector } from '@ngrx/store';

import { MaterialState } from '../states/material.state'

export const MaterialFeatureKey = 'material';

export const selectMaterialState = createFeatureSelector<MaterialState>(MaterialFeatureKey);

export const selectMaterials = createSelector(
  selectMaterialState,
  (state: MaterialState) => state.materials
);

export const selectMaterialCategorys = createSelector(
  selectMaterialState,
  (state: MaterialState) => state.categories
);

export const selectMaterialVideos = createSelector(
  selectMaterialState,
  (state: MaterialState) => state.videos
);

export const selectMaterialFiles = createSelector(
  selectMaterialState,
  (state: MaterialState) => state.files
);

export const selectMaterialTexts = createSelector(
  selectMaterialState,
  (state: MaterialState) => state.texts
);

export const selectMaterialMCQs = createSelector(
  selectMaterialState,
  (state: MaterialState) => state.mcqs
);

export const selectSelectedMaterial = createSelector(
  selectMaterialState,
  (state: MaterialState) => state.selectedMaterial
);

export const selectSelectedCategory = createSelector(
  selectMaterialState,
  (state: MaterialState) => state.selectedCategory
);