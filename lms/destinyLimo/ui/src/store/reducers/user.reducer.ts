// // import the interface
import { createReducer, on } from '@ngrx/store';

import { UserState } from '../states/user.state';
import { approveRejectUser_Failure, approveRejectUser_Success, AuthenticateUser_Failure, AuthenticateUser_Success, changePassword_Failure, changePassword_Success, forgotPassword_Failure, forgotPassword_Success, lockUser_Failure, lockUser_Success, logoutUser_Failure, logoutUser_Success, registerUser_Failure, registerUser_Success, resetPassword_Failure, resetPassword_Success, updateUser_Failure, updateUser_Success, UsersFetchAPI_Failure, UsersFetchAPI_Success } from '../actions/user.action';

//create a dummy initial state
export const initialState: UserState = {
  loggedInUser: undefined,
  allUsers: [],
  newUser: undefined,
  currentUser: undefined,
  message: undefined
};

export const userReducer = createReducer(
  initialState,

  on(AuthenticateUser_Success, (state, { loggedInUser }) => {
    return { ...state, loggedInUser: loggedInUser };
  }),

  on(AuthenticateUser_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(registerUser_Success, (state, { registeredUser }) => {
    return { ...state, newUser: registeredUser };
  }),

  on(registerUser_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(resetPassword_Success, (state, { updatedUser }) => {
    return { ...state, currentUser: updatedUser };
  }),

  on(resetPassword_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(changePassword_Success, (state, { updatedUser }) => {
    return { ...state, currentUser: updatedUser };
  }),

  on(changePassword_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(forgotPassword_Success, (state, { updatedUser }) => {
    return { ...state, currentUser: updatedUser };
  }),
  
  on(forgotPassword_Failure, (state, { error }) => {
    return { ...state, error: error };  
  }
  ),

  on(approveRejectUser_Success, (state, { message }) => {
    return { ...state, message: message };
  }),

  on(approveRejectUser_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(lockUser_Success, (state, { message }) => {
    return { ...state, message: message };
  }),

  on(lockUser_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),
  
  on(logoutUser_Success, (state) => {
    return { ...state, loggedInUser: undefined };
  }),

  on(logoutUser_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),

  on(UsersFetchAPI_Success, (state, { allUsers }) => {
    console.log('all users', allUsers);
    return { ...state, allUsers: allUsers };
  }),

  on(UsersFetchAPI_Failure, (state, { error }) => {
    return { ...state, error: error };  
  }
  ),

  on(updateUser_Success, (state, { updatedUser }) => {  
    return { ...state, currentUser: updatedUser, loggedInUser: updatedUser };
  }),

  on(updateUser_Failure, (state, { error }) => {
    return { ...state, error: error };
  }
  ),
);