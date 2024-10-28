import { createFeatureSelector, createSelector } from '@ngrx/store';

import { UserProfileState } from '../states/user-profile.state';

export const UserFeatureKey = 'user_profiles';

export const selectUserState = createFeatureSelector<UserProfileState>(UserFeatureKey);

export const selectLoggedInUser = createSelector(
  selectUserState,
  (state: UserProfileState) => state.loggedInUser
);

export const selectUserProfiles = createSelector(
  selectUserState,
  (state: UserProfileState) => state.allUserProfiles
);

export const selectUserProfile = createSelector(
  selectUserState,
  (state: UserProfileState) => state.userProfile
);

export const selectNewUserProfile = createSelector(
  selectUserState,
  (state: UserProfileState) => state.newUserProfile
);

export const selectUserProfileById = (userId: number) => createSelector(
  selectUserState,
  (state: UserProfileState) => state.allUserProfiles.find(userProfile => userProfile.userId === userId)
);

export const selectUserProfileByUserName = (userName: string) => createSelector(
  selectUserState,
  (state: UserProfileState) => state.allUserProfiles.find(userProfile => userProfile.username === userName)
);

export const selectUserProfileByEmail = (email: string) => createSelector(
  selectUserState,
  (state: UserProfileState) => state.allUserProfiles.find(userProfile => userProfile.email === email)
);

export const selectUserProfileByPhone = (phone: string) => createSelector(
  selectUserState,
  (state: UserProfileState) => state.allUserProfiles.find(userProfile => userProfile.phoneNumber === phone)
);