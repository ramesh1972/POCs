import { createAction, props } from '@ngrx/store';

import { User } from '../models/User';
import { UserProfile } from '../models/UserProfile';


// auth, login, registration, change password
// register
export const registerUser = createAction(
  '[User API] Register User',
  props<{ user: User, avatar: File}>()
);

export const registerUser_Success = createAction(
  '[User API] Register User Success',
  props<{ registeredUser: User }>()
);

export const registerUser_Failure = createAction(
  '[User API] Register User Failure',
  props<{ error: any }>()
);

// authenticate
export const invokeAuthenticateUser = createAction(
  '[User API] Invoke Get Login User Fetch API',
  props<{ userName: string, password: string }>()
);

export const AuthenticateUser_Success = createAction(
  '[User API] Fetch API Success',
  props<{ loggedInUser: User }>()
);

export const AuthenticateUser_Failure = createAction(
  '[User] Authenticate User Failure',
  props<{ error: any }>()
);

export const logoutUser = createAction(
  '[User API] Logout User'
);

export const logoutUser_Success = createAction(
  '[User API] Logout User Success',
  props<{ loggedInUser?: User }>()
);

export const logoutUser_Failure = createAction(
  '[User API] Logout User Failure',
  props<{ error: any }>()
);

// change password
export const changePassword = createAction(
  '[User API] Change Password',
  props<{ userId: number, oldPassword: string, newPassword: string }>()
);

export const changePassword_Success = createAction(
  '[User API] Change Password Success',
  props<{ updatedUser: User }>()
);

export const changePassword_Failure = createAction(
  '[User API] Change Password Failure',
  props<{ error: any }>()
);

// forgot password
export const forgotPassword = createAction(
  '[User API] Forgot Password',
  props<{ email: string }>()
);

export const forgotPassword_Success = createAction(
  '[User API] Forgot Password Success',
  props<{ updatedUser: User }>()
);

export const forgotPassword_Failure = createAction(
  '[User API] Forgot Password Failure',
  props<{ error: any }>()
);

// reset password
export const resetPassword = createAction(
  '[User API] Reset Password',
  props<{ username: string, newPassword: string }>()
);

export const resetPassword_Success = createAction(
  '[User API] Reset Password Success',
  props<{ updatedUser: User }>()
);

export const resetPassword_Failure = createAction(
  '[User API] Reset Password Failure',
  props<{ error: any }>()
);

export const approveRejectUser = createAction(
  '[User API] Approve/Reject User',
  props<{ userId: number, isApproved: boolean, approveRejectReason: string, approvedRejectedBy: number }>()
);

export const approveRejectUser_Success = createAction(
  '[User API] Approve/Reject User Success',
  props<{ message: any }>()
);

export const approveRejectUser_Failure = createAction(
  '[User API] Approve/Reject User Failure',
  props<{ error: any }>()
);

export const lockUser = createAction(
  '[User API] Lock User',
  props<{ userId: number, isLocked: boolean }>()
);

export const lockUser_Success = createAction(
  '[User API] Lock User Success',
  props<{ message: any }>()
);

export const lockUser_Failure = createAction(
  '[User API] Lock User Failure',
  props<{ error: any }>()
);

// manage users
export const invokeUsersFetchAPI = createAction(
  '[User API] Invoke Users Fetch API'
);

export const UsersFetchAPI_Success = createAction(
  '[User API] Fetch API Success',
  props<{ allUsers: User[] }>()
);

export const UsersFetchAPI_Failure = createAction(
  '[User API] Fetch API Failure',
  props<{ error: any }>()
);

export const updateUser = createAction(
  '[User API] Update User',
  props<{ updatedUser: User , avatar: File }>()
);

export const updateUser_Success = createAction(
  '[User API] Update User Success',
  props<{ updatedUser: User }>()
);

export const updateUser_Failure = createAction(
  '[User API] Update User Failure',
  props<{ error: any }>()
);