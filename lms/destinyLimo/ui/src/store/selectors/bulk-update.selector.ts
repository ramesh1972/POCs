import { createFeatureSelector, createSelector } from '@ngrx/store';

import { BulkUpdateState } from '../states/bulk-update.state';

export const contentFeatureKey = 'bulk-update';

export const selectBulkUpdateState = createFeatureSelector<BulkUpdateState>(contentFeatureKey);

export const selectBulkUpdateResult = createSelector(
  selectBulkUpdateState,
  (state: BulkUpdateState) => state.success
);

export const selectBulkActions = createSelector(
  selectBulkUpdateState,
  (state: BulkUpdateState) => state.bulkActions
);