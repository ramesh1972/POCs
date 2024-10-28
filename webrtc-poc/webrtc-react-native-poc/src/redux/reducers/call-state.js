//import { call } from "react-native-reanimated";
import { SET_WEBRTC_HANDLER, SET_CALL_INFO, SET_CALL_STATUS, SET_NEW_REMOTE_STREAM_CONNECTED } from "../actions/types";

const initialState = {
  webRTCHandler: null,
  callInfo: null,
  callStatus: false,
  newConnectedMember: null,
}

export default function (state = initialState, action) {

  switch (action.type) {
    case SET_WEBRTC_HANDLER:
      console.log("SET_WEBRTC_HANDLER", action.payload);
      return {
        ...state,
        webRTCHandler: action.payload,
      };

    case SET_CALL_STATUS:
      console.log("SET_CALL_STATUS", action.payload);
      return {
        ...state,
        callStatus: action.payload,
      };

    case SET_CALL_INFO:
      console.log("SET_CALL_INFO", action.payload);
      return {
        ...state,
        callInfo: action.payload,
      };

    case SET_NEW_REMOTE_STREAM_CONNECTED:
      console.log("SET_NEW_REMOTE_STREAM_CONNECTED", action.payload);
      return {
        ...state,
        newConnectedMember: action.payload,
      };

    default:
      return state;
  }
};