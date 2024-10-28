import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { select, Store, Action } from '@ngrx/store';
import { catchError, map, mergeMap, switchMap, withLatestFrom } from 'rxjs/operators';
import { Observable, of, throwError } from 'rxjs';

import { UserProfile } from '../models/UserProfile';
import { UserService } from '../apis/user.service';

import { invokeAuthenticateUser, AuthenticateUser_Success, registerUser, registerUser_Success, logoutUser, changePassword, changePassword_Success, forgotPassword, resetPassword, approveRejectUser, lockUser, approveRejectUser_Success, lockUser_Success, AuthenticateUser_Failure, resetPassword_Failure, resetPassword_Success, logoutUser_Success } from '../actions/user.action';
import { invokeUsersFetchAPI, UsersFetchAPI_Success, updateUser, updateUser_Success } from '../actions/user.action';
import { User } from '../models/User';

@Injectable()
export class UserEffect {
  constructor(
    private actions$: Actions,
    private userService: UserService,
    private store: Store
  ) { }

  // register
  registerUser$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(registerUser),
      mergeMap((action) => {
        return this.userService
          .registerUser(action.user, action.avatar)
          .pipe(map((data: User) => registerUser_Success({ registeredUser: data as User }))
          );
      }));
  });

  approveRejectUser$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(approveRejectUser),
      mergeMap((action) => {
        return this.userService
          .approveRejectUser(action.userId, action.isApproved, action.approveRejectReason, action.approvedRejectedBy)
          .pipe(map((data: any) => approveRejectUser_Success({ message: data }))
          );
      }));
  });

  lockUser$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(lockUser),
      mergeMap((action) => {
        return this.userService
          .lockUser(action.userId, action.isLocked)
          .pipe(map((data: any) => lockUser_Success({ message: data }))
          );
      }));
  });
  
  // authenticate
  authenticateUser$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeAuthenticateUser),
      mergeMap((action) => {
        return this.userService
          .authenticateUser(action.userName, action.password)
          .pipe(
            map((data: User) => AuthenticateUser_Success({ loggedInUser: data as User })),
            catchError((error: any) => of(AuthenticateUser_Failure({ error: error })))
          );
        }));
  });

  logOutUser$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(logoutUser),
      mergeMap(() => {
        return this.userService
          .logoutUser()
          .pipe(map((data: User) => logoutUser_Success({ loggedInUser: undefined })));
        }));
  });

  // change password
  changePassword$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(changePassword),
      mergeMap((action) => {
        return this.userService
          .changePassword(action.userId, action.oldPassword, action.newPassword)
          .pipe(map((data: User) => changePassword_Success({ updatedUser: data as User })));
        }));
  });

  // forgot password
  forgotPassword$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(forgotPassword),
      mergeMap((action) => {
        return this.userService
          .forgotPassword(action.email)
          .pipe(map((data: User) => AuthenticateUser_Success({ loggedInUser: data as User })));
        }));
  });

  // reset password
  resetPassword$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(resetPassword),
      mergeMap((action) => {
        return this.userService
          .resetPassword(action.username, action.newPassword)
          .pipe(
            map((data: User) => resetPassword_Success({ updatedUser: data as User })),
            catchError((error: any) => of(resetPassword_Failure({ error: error })))
          );
        }));
  });

  // fetch all users
  loadAllUsers$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeUsersFetchAPI),
      mergeMap(() => {
        return this.userService
          .getUsers()
          .pipe(map((data: User[]) => UsersFetchAPI_Success({ allUsers: data as User[] }))
          );
      }));
  });

  updateUser$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(updateUser),
      mergeMap((action) => {
        return this.userService
          .updateUser(action.updatedUser, action.avatar)
          .pipe(map((data: User) => updateUser_Success({ updatedUser: data as User }))
          );
      }));
  });
}

