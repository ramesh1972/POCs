import AsyncStorage from '@react-native-async-storage/async-storage';
import {combineReducers} from 'redux';
import {ActionDispatcher} from '../actions';
import userState from './user-state';
import chatState from './chat-state';
import callState from './call-state';

const allReducers = combineReducers({
  userState: userState,
  chatState: chatState,
  callState: callState,
});

const rootReducer = (state, action) => {
  return allReducers(state, action);
};

export default rootReducer;
