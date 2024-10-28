import AsyncStorage from '@react-native-async-storage/async-storage';
import { legacy_createStore as createStore } from 'redux';
import { applyMiddleware } from 'redux';
import { combineReducers } from 'redux';
import { thunk } from 'redux-thunk';

import rootReducer from './reducers';

const store = createStore(rootReducer, applyMiddleware(thunk));

export { store };
