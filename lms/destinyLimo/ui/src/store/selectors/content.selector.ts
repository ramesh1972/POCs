import { createFeatureSelector, createSelector } from '@ngrx/store';

import { ContentState } from '../states/content.state';
import { Content } from '../models/Content';

export const contentFeatureKey = 'content';

export const selectContentState = createFeatureSelector<ContentState>(contentFeatureKey);

export const selectContents = createSelector(
  selectContentState,
  (state: ContentState) => state.content
);

export const selectContentById = (contentId: number) => createSelector(
  selectContents,
  (content: Content[]) => content.find(c => c.content_type_id === contentId)
);

export const selectServices = createSelector(
  selectContents,
  (content: Content[])  => content.filter(item => item.content_type_id === 2)
);

export const selectProcesses = createSelector(
  selectContents,
  (content: Content[])  => content.filter(item => item.content_type_id === 3)
);

export const selectPosts = createSelector(
  selectContentState,
  (state:ContentState) => state.content.filter(item => item.content_type_id === 6)
);

export const selectFAQs = createSelector(
  selectContentState,
  (state:ContentState) => state.content.filter(item => item.content_type_id === 7)
);