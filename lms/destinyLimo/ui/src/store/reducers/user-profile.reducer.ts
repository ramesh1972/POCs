// // import the interface
import { createReducer, on } from '@ngrx/store';

import { UserProfileState } from '../states/user-profile.state';
import { UserProfilesFetchAPI_Success, UserProfileFetchAPI_Success, UserProfileUpdateAPI_Success } from '../actions/user-profile.action';

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

  on(UserProfileFetchAPI_Success, (state, { userProfile }) => {
    return { ...state, userProfile: userProfile };
  }),

  on(UserProfileUpdateAPI_Success, (state, { updatedUserProfile }) => {
    return { ...state, userProfile: updatedUserProfile };
  }),
);