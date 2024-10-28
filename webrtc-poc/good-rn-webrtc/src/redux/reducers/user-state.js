import AsyncStorage from '@react-native-async-storage/async-storage';
import {
  SET_LOGIN_USER_DATA,
  SET_CURRENT_CHANNEL
} from '../actions/types';

const initialState = {
  userLoginData: null,
  currentChannelData: null,
};

export default function (state = initialState, action) {
  switch (action.type) {
    case SET_LOGIN_USER_DATA:
      console.log('SET_LOGIN_USER_DATA', action.payload);
      return {
        ...state,
        userLoginData: action.payload,
      };

      case SET_CURRENT_CHANNEL:
        console.log('SET_CURRENT_CHANNEL', action.payload);
        return {
          ...state,
          currentChannelData: action.payload,
        };
  
    default:
      return state;
  }
}
