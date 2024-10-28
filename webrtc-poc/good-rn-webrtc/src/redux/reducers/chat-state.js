import {
  SET_CURRENT_CHANNEL,
} from "../actions/types";

const INITAL_STATE = {
  chatInfo: null,
};

export default function (state = INITAL_STATE, action) {
  // const newState = {...state};

  switch (action.type) {
    case SET_CURRENT_CHANNEL:
      return {
        ...state,
        chatInfo: action.payload,
      };

    default:
      return state;
  }
}
