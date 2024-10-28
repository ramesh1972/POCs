
import { ActionDispatcher } from "./index";
import {
  SET_CURRENT_CHANNEL,
} from "./types";

export const setCurrentChannel = (channel) => (dispatch) => {
    dispatch(ActionDispatcher(SET_CURRENT_CHANNEL, channel));
};