import { createAction, props } from '@ngrx/store';

import { Content } from '../models/Content';

// fetch content
export const invokeContentFetchAPI = createAction(
  '[Content API] Invoke Content Fetch API'
);

export const contentFetchAPI_Success = createAction(
  '[Content API] Fetch API Success',
  props<{ msg: string, allContent: Content[] }>()
);

export const contentFetchAPI_Failure = createAction(
  '[Content API] Fetch API Failure',
  props<{ error: string, data: any }>()
);



export const invokeContentCreateAPI = createAction(
  '[Content API] Invoke Create Content API',
  props<{ content: Content }>()
);

export const contentCreateAPI_Success = createAction(
  '[Content API] Create API Success',
  props<{ msg: string, content: Content }>()
);

export const contentCreateAPI_Failure = createAction(
  '[Content API] Create API Failure',
  props<{ error: string, data: any }>()
);



export const invokeUpdateContentAPI = createAction(
  '[Content API] Invoke Update Content API',
  props<{ content: Content }>()
);

export const updateContentAPI_Success = createAction(
  '[Content API] Update API Success',
  props<{ msg: string, content: Content }>()
);

export const updateContentAPI_Failure = createAction(
  '[Content API] Update API Failure',
  props<{ error: string, data: any }>()
);


export const invokeDeleteContentAPI = createAction(
  '[Content API] Invoke Delete Content API',
  props<{ Id: number }>()
);

export const deleteContentAPI_Success = createAction(
  '[Content API] Delete API Success',
  props<{ msg: string, Id: number }>()
);

export const deleteContentAPI_Failure = createAction(
  '[Content API] Delete API Failure',
  props<{ error: string, data: any }>()
);