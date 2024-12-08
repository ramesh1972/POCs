// // import the interface
import { createReducer, on } from '@ngrx/store';

import { Content } from '../models/Content';
import { ContentState } from '../states/content.state';
import { contentCreateAPI_Failure, contentCreateAPI_Success, contentFetchAPI_Failure, contentFetchAPI_Success, deleteContentAPI_Success } from '../actions/content.action';
import { ApiResponseState } from '../states/api.response.state';

//create a dummy initial state
export const initialApiResposeState: ApiResponseState = {
  success: false,
  HttpCode: 0,
  msg: '',
  error: '',
  data: null
};

export const initialState: ContentState = {
  ...initialApiResposeState,
  content: []
};

export const contentReducer = createReducer(
  initialState,
  on(contentFetchAPI_Success, (state, { allContent }) => {
    return { ...state, content: allContent };
  }),

  on(contentFetchAPI_Failure, (state, { error, data }) => {
    return { ...state, error: error, data: data };
  }),

  on(contentCreateAPI_Success, (state, { content }) => {
    return { ...state, content: [...state.content, content] };
  }),

  on(contentCreateAPI_Failure, (state, { error, data }) => {
    return { ...state, error: error, data: data };
  }),
  
  on(deleteContentAPI_Success, (state, { Id }) => {
    return { ...state, content: state.content.filter(c => c.Id !== Id) };
  }),

  on(contentCreateAPI_Failure, (state, { error, data }) => {
    return { ...state, error: error, data: data };
  }),
);

