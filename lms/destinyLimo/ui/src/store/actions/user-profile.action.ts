import { createAction, props } from '@ngrx/store';

import { UserProfile } from '../models/UserProfile';

// UserProfiles
// fetches
export const invokeUserProfilesFetchAPI = createAction(
  '[UserProfile API] Invoke UserProfiles Fetch API'
);

export const UserProfilesFetchAPI_Success = createAction(
  '[UserProfile API] Fetch API Success',
  props<{ allUserProfiles: UserProfile[] }>()
);

export const invokeUserProfileFetchAPI = createAction(
  '[UserProfile API] Invoke UserProfile Fetch API',
  props<{ userId: number }>()
);

export const UserProfileFetchAPI_Success = createAction(
  '[UserProfile API] Fetch API Success',
  props<{ userProfile: UserProfile }>()
);

// modify
export const invokeUserProfileUpdateAPI = createAction(
  '[UserProfile API] Invoke Update UserProfile API',
  props<{ userProfile: UserProfile }>()
);

export const UserProfileUpdateAPI_Success = createAction(
  '[UserProfile API] Update API Success',
  props<{ updatedUserProfile: UserProfile }>()
);

export const UserProfileUpdateAPI_Failure = createAction(
  '[UserProfile API] Update API Failure',
  props<{ error: any }>()
);

export const invokeUserProfileDeleteAPI = createAction(
  '[UserProfile API] Invoke Delete UserProfile API',
  props<{ userId: number }>()
);

export const UserProfileDeleteAPI_Success = createAction(
  '[UserProfile API] Delete API Success',
  props<{ deletedUserProfile: UserProfile }>()
);

export const UserProfileDeleteAPI_Failure = createAction(
  '[UserProfile API] Delete API Failure',
  props<{ error: any }>()
);