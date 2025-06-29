import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';

import { UserProfile } from '../models/UserProfile';
import { UserProfileService } from '../apis/user-profile.service';

import { Store } from '@ngrx/store';
import { mergeMap, map, catchError, of } from 'rxjs';
import { invokeUserProfilesFetchAPI, UserProfilesFetchAPI_Success, invokeUserProfileFetchAPI, UserProfileFetchAPI_Success, invokeUserProfileUpdateAPI, UserProfileUpdateAPI_Success, invokeUserProfileDeleteAPI, UserProfileDeleteAPI_Success, UserProfilesFetchAPI_Failure } from '../actions/user-profile.action';
import { ApiResponse } from '../models/ApiResponse';

@Injectable()
export class UserProfileEffect {
  constructor(
    private actions$: Actions,
    private UserProfileService: UserProfileService,
    private store: Store
  ) { }


  loadAllUserProfiles$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserProfilesFetchAPI),
      mergeMap(() => {
        return this.UserProfileService
          .getUserProfiles()
          .pipe(map((data: ApiResponse) => UserProfilesFetchAPI_Success({ allUserProfiles: data.data as UserProfile[] })),
            catchError((error: any) => {
              console.error('error fetching user profiles', error);
              return of(UserProfilesFetchAPI_Failure({ error: error.message, data: error.data }));
            }));
      }));
  });


  loadUserProfile$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserProfileFetchAPI),
      mergeMap((action) => {
        return this.UserProfileService
          .getUserProfile(action.userId)
          .pipe(map((data: ApiResponse) => UserProfileFetchAPI_Success({ userProfile: data.data as UserProfile })),
            catchError((error: any) => {
              console.error('error fetching user profile', error);
              return of(UserProfilesFetchAPI_Failure({ error: error.message, data: error.data }));
            }));
      }));
  });


  updateUserProfile$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserProfileUpdateAPI),
      mergeMap((action) => {
        return this.UserProfileService
          .updateUserProfile(action.userProfile)
          .pipe(map((data: ApiResponse) => UserProfileUpdateAPI_Success({ updatedUserProfile: data.data as UserProfile })),
            catchError((error: any) => {
              console.error('error updating user profile', error);
              return of(UserProfilesFetchAPI_Failure({ error: error.message, data: error.data }));
            }));
      }));
  });


  deleteUserProfile$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserProfileDeleteAPI),
      mergeMap((action) => {
        return this.UserProfileService
          .deleteUserProfile(action.userId)
          .pipe(map((data: ApiResponse) => UserProfileDeleteAPI_Success({ deletedUserProfile: data.data as UserProfile })),
            catchError((error: any) => {
              console.error('error deleting user profile', error);
              return of(UserProfilesFetchAPI_Failure({ error: error.message, data: error.data }));
            }));
      }));
  });
}