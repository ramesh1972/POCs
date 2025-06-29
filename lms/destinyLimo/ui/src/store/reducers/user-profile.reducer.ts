// // import the interface
import { createReducer, on } from '@ngrx/store';

import { UserProfileState } from '../states/user-profile.state';
import { UserProfilesFetchAPI_Success, UserProfileFetchAPI_Success, UserProfileUpdateAPI_Success, UserProfileFetchAPI_Failure, UserProfilesFetchAPI_Failure, UserProfileUpdateAPI_Failure } from '../actions/user-profile.action';

//create a dummy initial state
export const initialState: UserProfileState = {
  loggedInUser: undefined,
  allUserProfiles: [],
  userProfile: undefined,
  newUserProfile: undefined
};

export const userProfileReducer = createReducer(
  initialState,

   on(UserProfilesFetchAPI_Success, (state, { allUserProfiles }) => {
    return { ...state, allUserProfiles: allUserProfiles };
  }),

  on(UserProfilesFetchAPI_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(UserProfileFetchAPI_Success, (state, { userProfile }) => {
    return { ...state, userProfile: userProfile };
  }),

  on(UserProfileFetchAPI_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(UserProfileUpdateAPI_Success, (state, { updatedUserProfile }) => {
    return { ...state, userProfile: updatedUserProfile };
  }),

  on(UserProfileUpdateAPI_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),
);