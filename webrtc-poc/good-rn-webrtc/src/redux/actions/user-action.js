import {ActionDispatcher} from './index';
import {
  SET_LOGIN_USER_DATA,
  SET_CURRENT_CHANNEL
} from './types';

export const setLoginUserData = data => dispatch => {
  console.log('setLoginUserData', data);
  dispatch(ActionDispatcher(SET_LOGIN_USER_DATA, data));
};

export const setCurrentChannel = data => dispatch => {
  console.log('setCurrentChannel', data);
  dispatch(ActionDispatcher(SET_CURRENT_CHANNEL, data));
};