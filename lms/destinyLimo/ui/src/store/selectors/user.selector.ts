import { createFeatureSelector, createSelector } from '@ngrx/store';

import { UserState } from '../states/user.state';

export const UserFeatureKey = 'users';

export const selectUserState = createFeatureSelector<UserState>(UserFeatureKey);

export const selectLoggedInUser = createSelector(
  selectUserState,
  (state: UserState) => state.loggedInUser
);

export const selectUsers = createSelector(
  selectUserState,
  (state: UserState) => state.allUsers
);

export const selectUser = createSelector(
  selectUserState,
  (state: UserState) => state.currentUser
);

export const selectNewUser = createSelector(
  selectUserState,
  (state: UserState) => state.newUser
);

export const selectUserById = (userId: number) => createSelector(
  selectUserState,
  (state: UserState) => state.allUsers.find(user => user.userId === userId)
);

export const selectUserByUserName = (userName: string) => createSelector(
  selectUserState,
  (state: UserState) => state.allUsers.find(user => user.username === userName)
);

export const selectUserByEmail = (email: string) => createSelector(
  selectUserState,
  (state: UserState) => state.allUsers.find(user => user.email === email)
);