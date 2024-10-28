import { View, Text, Image, StyleSheet, Platform, Pressable } from "react-native";
import React, { useState } from "react";

import {
  hp,
  wp,
  Colors,
  Icons
} from "@/src/constants";

import { useTheme } from "@react-navigation/native";
import { TouchableOpacity } from "react-native";
//import Image from "../app-image";
import { Menu } from "react-native-material-menu";
import { useDispatch, useSelector } from "react-redux";

import { CALL_EVENTS, getDisconnectingCallInfo } from "./call-events";
import { setCallInfo } from "@/src/redux/actions/call-action";

export default function CallStripChat() {
  const { colors } = useTheme();

  const dispatch = useDispatch();

  const { callInfo } = useSelector((state) => state.callState);

  const isCaller = true;
  console.log("isCaller", isCaller);
  const [isLeaveCallMenuVisible, setIsLeaveCallMenuVisible] = useState(false);

  const text = () => {
    const callType = callInfo?.callType === "audio" ? "Audio" : "Video";
    switch (callInfo?.event) {
      case CALL_EVENTS.outgoing:
        return "Calling on " + callType + "...";
      case CALL_EVENTS.incoming:
        return "Incoming " + callType + " Call...";
      case CALL_EVENTS.activeconnected:
        return callType + " Call in Progress...";
      case CALL_EVENTS.activenotconnected:
        return callType + " Call in Progress...";
      case CALL_EVENTS.reconnecting:
        return "Reconnecting " + callType + " Video Call...";
      default:
        return "";
    }
  };

  const buttonTitle = () => {
    switch (callInfo?.event) {
      case CALL_EVENTS.outgoing:
        return "Cancel";
      case CALL_EVENTS.incoming:
        return "Join";
      case CALL_EVENTS.activeconnected:
        return "End Call";
      case CALL_EVENTS.activenotconnected:
        return "Join";
      case CALL_EVENTS.reconnecting:
        return "Leave";
      default:
        return "";
    }
  };

  const onCallButtonPress = () => {
    console.log("onCallButtonPress event", callInfo?.event);
    if (callInfo !== null && callInfo !== undefined && callInfo.event === CALL_EVENTS.activeconnected) {
      console.log("onCallButtonPress active Connected");
      let callingInfo = getDisconnectingCallInfo(callInfo);
      if (callingInfo === null || callingInfo === undefined) {
        console.warn("callInfo is null");
        return;
      }

      dispatch(setCallInfo(callingInfo));

      console.log("onCallButtonPress cancel");
    }
    else if (isCaller && callInfo?.event != CALL_EVENTS.outgoing) {
      console.log("onButtonPress leave");
      setIsLeaveCallMenuVisible(true);
    }

    console.log("onCallButtonPress");
  };

  const onLeavePress = () => {
    console.log("onLeavePress");
    setIsLeaveCallMenuVisible(false);

    let callingInfo = getDisconnectingCallInfo(callInfo);
    if (callingInfo === null || callingInfo === undefined) {
      console.warn("onLeavePress callInfo is null");
      return;
    }

    dispatch(setCallInfo(callingInfo));
  };

  const onEndCallPress = () => {
    console.log("onEndCallPress");

    setIsLeaveCallMenuVisible(false);

    let callingInfo = getDisconnectingCallInfo(callInfo);
    if (callingInfo === null || callingInfo === undefined) {
      console.warn("onEndCallPress callInfo is null");
      return;
    }

    dispatch(setCallInfo(callingInfo));
  };

  if (callInfo && callInfo.event != CALL_EVENTS.closed) {
    return (
      <View style={[styles.root, { backgroundColor: 'blue', color: 'white' }]}>
        <Text size={hp("2%")} style={{ color: Colors.white }}>{text()}</Text>
        <View>
          <Menu
            visible={isLeaveCallMenuVisible}
            style={{
              backgroundColor: colors.transparent,
              elevation: 0,
            }}
            anchor={
              <TouchableOpacity
                style={[
                  styles.buttonContainer,
                  {
                    backgroundColor:
                      buttonTitle() == "Join" || buttonTitle() == "Cancel" || buttonTitle() == "End Call"
                        ? Colors.green
                        : colors.file_upload_error,
                  },
                ]}
                onPress={onCallButtonPress}
              >
                <Text size={hp("1.8%")} color={Colors.white}>
                  {buttonTitle()}
                </Text>
                {isCaller === false && callInfo?.event != CALL_EVENTS.outgoing ? (
                  <Image
                    size={wp("3.07%")}
                    source={Icons.back_arrow}
                    style={{
                      transform: [{ rotate: "270deg" }],
                      marginStart: 10,
                    }}
                  />
                ) : null}
              </TouchableOpacity>
            }
            onRequestClose={() => setIsLeaveCallMenuVisible(false)}
          >
            <View
              style={[
                styles.menu,
                { backgroundColor: colors.leave_call_menu_bg },
              ]}
            >
              <Pressable style={styles.iconTitleRow} onPress={onCallButtonPress}>
                <Image
                  size={wp("4%")}
                  source={Icons.phone_white}
                  tintColor={colors.white}
                  style={{
                    marginEnd: wp("3%"),
                    transform: [{ rotate: "135deg" }],
                  }}
                />
                <Text>{"Leave"}</Text>
              </Pressable>
              <Pressable
                style={[styles.iconTitleRow, { paddingTop: wp("3%") }]}
                onPress={onCallButtonPress}
              >
                <Image
                  size={wp("4%")}
                  source={Icons.phone_white}
                  tintColor={colors.white}
                  style={{
                    marginEnd: wp("3%"),
                    transform: [{ rotate: "135deg" }],
                  }}
                />
                <Text>{"End Call"}</Text>
              </Pressable>
            </View>
          </Menu>
        </View>
      </View>
    );
  }
  return <></>;
}

const styles = StyleSheet.create({
  root: {
    width: "100%",
    paddingVertical: hp("1.28%"),
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingHorizontal: wp("3%"),
    borderTopLeftRadius: 10,
    borderTopRightRadius: 10,
  },
  buttonContainer: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    paddingHorizontal: wp("5%"),
    paddingVertical: wp("1.5%"),
    borderRadius: 4,
  },
  menu: {
    padding: wp("2%"),
    borderRadius: wp("2%"),
    marginTop: Platform.OS === "ios" ? hp("4%") : hp("4.5%"),
    marginEnd: hp("1%"),
  },
  iconTitleRow: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: wp("1%"),
    paddingVertical: wp("1.5%"),
  },
});
