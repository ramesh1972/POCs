import { ActionDispatcher } from './index';
import { SET_WEBRTC_HANDLER, SET_CALL_INFO, SET_CALL_STATUS, SET_NEW_REMOTE_STREAM_CONNECTED } from './types';

export const setWebRTCHandler = webrtcHandler => dispatch => {
  dispatch(ActionDispatcher(SET_WEBRTC_HANDLER, webrtcHandler));
};

export const setCallInfo = (callInfo) => (dispatch) => {
  dispatch(ActionDispatcher(SET_CALL_INFO, callInfo));
};

export const setCallStatus = (callStatus) => (dispatch) => {
  dispatch(ActionDispatcher(SET_CALL_STATUS, callStatus));
};

export const setNewRemoteStreamConnected = (newConnectedMember) => (dispatch) => {
  dispatch(ActionDispatcher(SET_NEW_REMOTE_STREAM_CONNECTED, newConnectedMember));
};
