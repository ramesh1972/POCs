import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { Store } from '@ngrx/store';
import { catchError, map, mergeMap } from 'rxjs/operators';
import { of } from 'rxjs';

import { UserService } from '../apis/user.service';

import { invokeAuthenticateUser, AuthenticateUser_Success, registerUser, registerUser_Success, logoutUser, changePassword, changePassword_Success, forgotPassword, resetPassword, approveRejectUser, lockUser, approveRejectUser_Success, lockUser_Success, AuthenticateUser_Failure, resetPassword_Failure, resetPassword_Success, logoutUser_Success } from '../actions/user.action';
import { invokeUsersFetchAPI, UsersFetchAPI_Success, updateUser, updateUser_Success } from '../actions/user.action';
import { User } from '../models/User';
import { ApiResponse } from '../models/ApiResponse';

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
          .pipe(map((data: ApiResponse) => registerUser_Success({ registeredUser: data.data as User })),
            catchError((error: any) => {
              console.error('error registering user', error);
              return of(AuthenticateUser_Failure({ error: error.message }));
            }));
      }));
  });

  approveRejectUser$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(approveRejectUser),
      mergeMap((action) => {
        return this.userService
          .approveRejectUser(action.userId, action.isApproved, action.approveRejectReason, action.approvedRejectedBy)
          .pipe(map((data: ApiResponse) => approveRejectUser_Success({ message: data.data as string })),
            catchError((error: any) => {
              console.error('error approving/rejecting user', error);
              return of(AuthenticateUser_Failure({ error: error.message }));
            }));
      }));
  });

  lockUser$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(lockUser),
      mergeMap((action) => {
        return this.userService
          .lockUser(action.userId, action.isLocked)
          .pipe(map((data: ApiResponse) => lockUser_Success({ message: data.data as string })),
            catchError((error: any) => {
              console.error('error locking/unlocking user', error);
              return of(AuthenticateUser_Failure({ error: error.message }));
            }));
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
            map((data: ApiResponse) => AuthenticateUser_Success({ loggedInUser: data.data as User })),
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
          .pipe(map((data: ApiResponse) => logoutUser_Success({ loggedInUser: undefined })));
      }));
  });

  // change password
  changePassword$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(changePassword),
      mergeMap((action) => {
        return this.userService
          .changePassword(action.userId, action.oldPassword, action.newPassword)
          .pipe(map((data: ApiResponse) => changePassword_Success({ updatedUser: data.data as User })),
            catchError((error: any) => {
              console.error('error changing password', error);
              return of(AuthenticateUser_Failure({ error: error.message }));
            }));
      }));
  });



  // forgot password
  forgotPassword$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(forgotPassword),
      mergeMap((action) => {
        return this.userService
          .forgotPassword(action.email)
          .pipe(map((data: ApiResponse) => AuthenticateUser_Success({ loggedInUser: data.data as User })),
            catchError((error: any) => {
              console.error('error sending forgot password email', error);
              return of(AuthenticateUser_Failure({ error: error.message }));
            }));
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
            map((data: ApiResponse) => resetPassword_Success({ updatedUser: data.data as User })),
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
          .pipe(map((data: ApiResponse) => UsersFetchAPI_Success({ allUsers: data.data as User[] })),
            catchError((error: any) => {
              console.error('error fetching users', error);
              return of(AuthenticateUser_Failure({ error: error.message }));
            })
          );
      }));
  });

  updateUser$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(updateUser),
      mergeMap((action) => {
        return this.userService
          .updateUser(action.updatedUser, action.avatar)
          .pipe(map((data: ApiResponse) => updateUser_Success({ updatedUser: data.data as User })),
            catchError((error: any) => {
              console.error('error updating user', error);
              return of(AuthenticateUser_Failure({ error: error.message }));
            }));
      }));
  });
}

