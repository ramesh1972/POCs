import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';

import { UserProfile } from '../models/UserProfile';
import { UserProfileService } from '../apis/user-profile.service';

import { Store } from '@ngrx/store';
import { mergeMap, map } from 'rxjs';
import { invokeUserProfilesFetchAPI, UserProfilesFetchAPI_Success, invokeUserProfileFetchAPI, UserProfileFetchAPI_Success, invokeUserProfileUpdateAPI, UserProfileUpdateAPI_Success, invokeUserProfileDeleteAPI, UserProfileDeleteAPI_Success } from '../actions/user-profile.action';

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
          .pipe(map((data: UserProfile[]) => UserProfilesFetchAPI_Success({ allUserProfiles: data as UserProfile[] }))
          );
      }));
  });

  loadUserProfile$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserProfileFetchAPI),
      mergeMap((action) => {
        return this.UserProfileService
          .getUserProfile(action.userId)
          .pipe(map((data: UserProfile) => UserProfileFetchAPI_Success({ userProfile: data as UserProfile }))
          );
      }));
  });

  updateUserProfile$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserProfileUpdateAPI),
      mergeMap((action) => {
        return this.UserProfileService
          .updateUserProfile(action.userProfile)
          .pipe(map((data: UserProfile) => UserProfileUpdateAPI_Success({ updatedUserProfile: data as UserProfile }))
          );
      }));
  });

  deleteUserProfile$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUserProfileDeleteAPI),
      mergeMap((action) => {
        return this.UserProfileService
          .deleteUserProfile(action.userId)
          .pipe(map((data: UserProfile) => UserProfileDeleteAPI_Success({ deletedUserProfile: data as UserProfile }))
          );
      }));
  });
}