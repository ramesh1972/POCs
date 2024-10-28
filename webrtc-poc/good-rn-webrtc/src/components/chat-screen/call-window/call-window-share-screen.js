import { View, Text, StyleSheet, Platform, Pressable, NativeModules, findNodeHandle } from "react-native";
import React, { useEffect, useState, useRef } from "react";
import { useTheme } from "@react-navigation/native";
import { useDispatch, useSelector } from "react-redux";
import { mediaDevices, RTCView } from "react-native-webrtc";
import notifee, { AndroidImportance } from '@notifee/react-native';

import colabLog from "@/src/libs/webrtc/utils/colabLog";

import { setCallInfo, setNewRemoteStreamConnected } from "@/src/redux/actions/call-action";
import WebRTCHandler from '@/src/libs/webrtc/WebRTCHandler';
import { WebRTCDataChannelLabel, WebRTCDataChannelType, WebRTCDataChannelStreamType } from '@/src/libs/webrtc/models/DataChannelLabel';
import { CALL_EVENTS, getClosedCallInfo, getActiveCallInfo } from "../call-strip/call-events";

import { startScreenCapture } from './screen-capture';

function CallWindowShareScreen(props) {
  console.log('CallWindowShareScreen props', props);

  const dispatch = useDispatch();

  const videoWidth = 340;
  const aspectRatio = 16 / 9;
  const videoHeight = videoWidth / aspectRatio;

  // store
  const { callInfo, webRTCHandler } = new useSelector((state) => state.callState);

  // state
  const [isScreenSharingOn, setisScreenSharingOn] = useState(false);
  const [localStream, setLocalStream] = useState(null);
  const [remoteStream, setRemoteStream] = useState(null);
  const [screenSharingDCLabel, setscreenSharingDCLabel] = useState(null);
  const [members, setMembers] = useState([]);

  // ui related
  const { colors } = useTheme();

  // screen share picker ref
  const screenPickerRef = useRef(null);
  // effect init
  useEffect(() => {
    console.log('CallWindowShareScreen useEffect init');

    if (callInfo?.event === CALL_EVENTS.disconnecting) {
      console.log('CallWindowShareScreen useEffect event disconnecting');
      StopScreenSharing(false);
    }
    else if (callInfo?.event === CALL_EVENTS.closed) {
      console.log('CallWindowShareScreen: callInfo is closed');
      CloseItAll();
    }
    else if (props.onGoingCallInfo !== null && props.onGoingCallInfo !== undefined) {
      console.log(props.onGoingCallInfo.fromChannel?.name, ' --> CallWindowShareScreen useEffect onGoingCallInfo', props.onGoingCallInfo);
      console.log(props.onGoingCallInfo.fromChannel?.name, ' --> CallWindowShareScreen useEffect onGoingCallInfo event', props.onGoingCallInfo.event);

      if (props.onGoingCallInfo.event === CALL_EVENTS.outgoing) {
        console.log('CallWindowShareScreen useEffect event outgoing');

        // show notifee or whatever
        setupNotifee(props.onGoingCallInfo);

        // show the picker
        //const reactTag = findNodeHandle(screenPickerRef.current);
        //NativeModules.ScreenCapturePickerViewManager.show(reactTag);

        handleScreenSharingByIntiator(props.onGoingCallInfo).then((isSuccess) => {
          console.log('CallWindowShareScreen useEffect handleScreenSharingByIntiator completed');
        }).catch((error) => {
          console.error('CallWindowShareScreen useEffect handleScreenSharingByIntiator failed', error);
        });
      }
      else if (props.onGoingCallInfo.event === CALL_EVENTS.incoming) {
        console.log('CallWindowShareScreen useEffect event incoming');
        handleScreenSharingByReceiver(props.onGoingCallInfo).then((isSuccess) => {
          console.log('CallWindowShareScreen useEffect handleScreenSharingByReceiver completed');
        }).catch((error) => {
          console.error('CallWindowShareScreen useEffect handleScreenSharingByReceiver failed', error);
        });
      }
    }
  }, [props.onGoingCallInfo, props.onGoingCallInfo?.event, props.onGoingCallInfo?.callType, callInfo?.event, callInfo?.callType]);

  // setup notifee
  async function setupNotifee(callInfo) {
    try {
      const channelId = await notifee.createChannel({
        id: 'screen_capture',
        name: 'Screen Capture',
        lights: false,
        vibration: false,
        importance: AndroidImportance.DEFAULT
      });

      await notifee.displayNotification({
        title: 'Screen Capture',
        body: 'This notification will be here until you stop capturing.',
        android: {
          channelId,
          asForegroundService: true
        }
      });
    } catch (err) {
      console.error('Failed to setup notifee', err);
    };
  }

  // IMPORTANT: handle screen sharing setup and call
  // when the current user clicks on the screen share call button
  async function handleScreenSharingByIntiator(callingInfo) {
    console.log(callingInfo?.fromChannel?.name, ' --> CallWindowShareScreen: Starting screen sharing');

    if (screenSharingDCLabel !== null && screenSharingDCLabel !== undefined) {
      console.log('CallWindowShareScreen: Screen sharing already on');
      return false;
    }

    if (webRTCHandler === null) {
      console.error('WebRTC handler not found');
      return false;
    }

    if (callingInfo === null || callingInfo === undefined) {
      console.error('Calling info is null');
      return false;
    }

    // create the screen share channel label
    console.log(callingInfo?.fromChannel?.name, ' --> CallWindowShareScreen: You are the initiator of the call');

    // create this user's side of the peer connection
    // NOTE: the data used here is from callInfo which is set on call button click in chat header component
    await webRTCHandler.ConnectDataChannel(WebRTCDataChannelType.P2P, 1,
      callingInfo?.fromChannel, callingInfo?.toChannel, WebRTCDataChannelStreamType).then(async (screenSharingDataChannelLabel) => {
        if (screenSharingDataChannelLabel === null || screenSharingDataChannelLabel === undefined) {
          console.error('CallWindowShareScreen: screenSharingDataChannelLabel is null');
          return false;
        }
        else {
          colabLog(screenSharingDataChannelLabel, 'CallWindowShareScreen: screenSharingDataChannelLabel', screenSharingDataChannelLabel.dataChannelName);
          colabLog(screenSharingDataChannelLabel, 'CallWindowShareScreen: from User', screenSharingDataChannelLabel.fromChannel?.id);

          // set it prt of the state used for stopping the screen sharing
          setscreenSharingDCLabel(screenSharingDataChannelLabel);

          // setup and handle screen sharing callbacks when the other peer accepts the screen share call
          // set remoteStream on receive remote stream callback
          //webRTCHandler.SetMediaStreamReceiveCallback(screenSharingDataChannelLabel, receiveRemoteStream);

          await startScreenCapture().then(async (captureData) => {
            // start the screen sharing setup and call
            // get access to camera and microphone
            var strm = await mediaDevices.getUserMedia({
              mandatory: {
                chromeMediaSource: 'desktop',
                chromeMediaSourceId: captureData,
              }
            });

            console.debug('CallWindowShareScreen: handleSCreenSharing: local stream', strm);
            setLocalStream(strm);
            setRemoteStream(null);

            // init the event handlers for peer connection callbacks
            await webRTCHandler.Init(true, screenSharingDataChannelLabel, strm);

            // set the initiate screen sharing callback which is called when the other peer accepts the video call
            webRTCHandler.SetStartCallCallBack(screenSharingDataChannelLabel, initiateScreenSharingHandler);

            // this callback will be called when peer sends call stopped message
            webRTCHandler.SetStopCallCallBack(screenSharingDataChannelLabel, StopScreenSharing);

            // send to the other peer that the call is initiated on my end
            webRTCHandler.SendInitiateCallMessage(screenSharingDataChannelLabel);

            colabLog(screenSharingDataChannelLabel, 'CallWindowShareScreen: completed handleScreenSharingByIntiator');

            return true;
          }).catch((error) => {
            console.error('CallWindowShareScreen: startScreenCapture failed', error);
            console.error('CallWindowShareScreen: Screen sharing setup failed at the initiator end');
            return false;
          });
        }
      });
  }

  async function handleScreenSharingByReceiver(callingInfo) {
    console.log(callingInfo?.toChannel?.name, ' --> CallWindowShareScreen: You are the receiver of the call');

    if (screenSharingDCLabel !== null && screenSharingDCLabel !== undefined) {
      console.log('CallWindowShareScreen: Screen sharing already on');
      return false;
    }

    if (callingInfo === null || callingInfo === undefined) {
      console.error('callinginfo is null in receiver end');
      return false
    }

    await webRTCHandler.ConnectDataChannel(WebRTCDataChannelType.P2P, 1,
      callingInfo?.fromChannel, callingInfo?.toChannel, WebRTCDataChannelStreamType.SCREEN).then(async (screenSharingDataChannelLabel) => {
        if (screenSharingDataChannelLabel === null || screenSharingDataChannelLabel === undefined) {
          console.error('CallWindowShareScreen: screenSharingDataChannelLabel is null');
          return false;
        }
        else {
          colabLog(screenSharingDataChannelLabel, 'CallWindowShareScreen: screenSharingDataChannelLabel', screenSharingDataChannelLabel.dataChannelName);

          // set it prt of the state used for stopping the screen sharing
          setscreenSharingDCLabel(screenSharingDataChannelLabel);

          // start the screen sharing setup and call
          // get access to camera and microphone
          /* var strm = await mediaDevices.getUserMedia({
            audio: false,
            video: true
          });

          console.debug('CallWindowShareScreen: handleVideoStreaming: local stream', strm);
          setLocalStream(strm); */

          setRemoteStream(null);

          // setup and handle screen sharing callbacks when the other peer accepts the scree share call
          // set remoteStream on receive remote stream callback
          webRTCHandler.SetMediaStreamReceiveCallback(screenSharingDataChannelLabel, receiveRemoteStream);

          // init the connetion
          await webRTCHandler.Init(false, screenSharingDataChannelLabel, null);

          // this callback will be called when peer sends call started message
          webRTCHandler.SetStartCallCallBack(screenSharingDataChannelLabel, initiateScreenSharing);

          // this callback will be called when peer sends call stopped message
          webRTCHandler.SetStopCallCallBack(screenSharingDataChannelLabel, StopScreenSharing);

          // let the peer know that the call is initiated on my end
          webRTCHandler.SendCallInitiatedlMessage(screenSharingDataChannelLabel);

          colabLog(screenSharingDataChannelLabel, 'CallWindowShareScreen: completed handleScreenSharingByReceiver');
          return true;
        }
      }).catch((error) => {
        console.error('CallWindowShareScreen: ConnectDataChannel failed', error);
        console.error('CallWindowShareScreen: Screen sharing setup failed at the initiator end');
        return false;
      });
  }

  async function initiateScreenSharingHandler(screenSharingDataChannelLabel) {
    console.log(screenSharingDataChannelLabel.toChannel?.name, ' --> CallWindowShareScreen: In initiateScreenSharingHandler');

    await initiateScreenSharing(screenSharingDataChannelLabel);
    console.log(screenSharingDataChannelLabel.toChannel?.name, ' --> CallWindowShareScreen: initiateScreenSharingHandler: initiated screen sharing');

    webRTCHandler.SendCallStartedMessage(screenSharingDataChannelLabel);
  }

  // initiate screen sharing
  async function initiateScreenSharing(screenSharingDataChannelLabel) {
    console.log(screenSharingDataChannelLabel.toChannel?.name, ' -- >CallWindowShareScreen: In initiateScreenSharing');

    colabLog(screenSharingDataChannelLabel, 'CallWindowShareScreen: initiateScreenSharing: isScreenSharingOn', isScreenSharingOn);

    if (isScreenSharingOn) {
      console.log('CallWindowShareScreen: Screen sharing already on');
      return false;
    }

    if (screenSharingDataChannelLabel === null || screenSharingDataChannelLabel === undefined) {
      console.error('CallWindowShareScreen: screenSharingDataChannelLabel is null');
      return false;
    }

    console.debug(screenSharingDataChannelLabel.toChannel?.name, ' --> CallWindowShareScreen: initiateScreenSharing: screenSharingDataChannelLabel', screenSharingDataChannelLabel?.dataChannelName);

    // !!! initiate screen sharing
    const isSuccess = await webRTCHandler?.StartScreenShare(screenSharingDataChannelLabel);
    console.log(screenSharingDataChannelLabel.toChannel?.name, ' --> CallWindowShareScreen: initiateScreenSharing: StartScreenSharing', isSuccess);

    //    if (isSuccess == true) {
    setisScreenSharingOn(true);

    dispatch(setCallInfo(getActiveCallInfo(props.onGoingCallInfo)));

    console.log(screenSharingDataChannelLabel.toChannel?.name, 'Screen sharing setup completed!!!!');

    return true;
    // TODO: to check the reture value
  /*   } else {
      console.error(screenSharingDataChannelLabel.fromChannel?.name, ' --> Screen sharing setup failed');
      setisScreenSharingOn(false);
      return false;
    }
 */  }

  // callback from webrtc handler when remote stream is created/received from the peer
  function receiveRemoteStream(remoteStream) {
    console.log('CallWindowShareScreen: receiveRemoteStream: OnRemoteStream', remoteStream);

    //const newMember = {};
    //newMember.stream = remoteStream;

    setRemoteStream(remoteStream);
    console.log('CallWindowShareScreen: receiveRemoteStream: remoteStream is set');
  }

  // called when cancel or leave button is clicked on the call strip
  async function StopScreenSharing(force) {
    console.log('CallWindowShareScreen: Stopping screen sharing');

    colabLog(screenSharingDCLabel, 'CallWindowShareScreen: StopScreenSharing: isScreenSharingOn', isScreenSharingOn);

    if (!force && !isScreenSharingOn) {
      console.log('CallWindowShareScreen: Screen sharing already off');
    }
    else if (webRTCHandler === null) {
      console.error('WebRTC handler not found');
    }
    else {
      console.log('CallWindowShareScreen: Stopping screen sharing');

      if (webRTCHandler.IsConnected()) {
        // before you destroy yourself, send a message to your peer 
        if (screenSharingDCLabel !== null && screenSharingDCLabel !== undefined) {
          // sending stop to the other peer
          colabLog(screenSharingDCLabel, 'CallWindowShareScreen: signaling to the peer to stop screen sharing');
          webRTCHandler.SendCallStoppedMessage(screenSharingDCLabel);
        }

        // start shutdown process
        const isStopped = webRTCHandler?.StopScreenShare();
        console.log('CallWindowShareScreen: StopScreenShare', isStopped);

        if (isStopped) {
          DestroyStreams();

          const closedCallInfo = getClosedCallInfo(props.onGoingCallInfo);
          dispatch(setCallInfo(closedCallInfo));

          // notiffe
          try {
            await notifee.stopForegroundService();
          } catch (err) {
            // Handle Error
            console.error('Failed to stop notifee foreground service', err);
          };

        }
        else {
          console.error('Screen sharing stop failed');
        }
      }
      else
        colabLog(screenSharingDCLabel, 'CallWindowShareScreen: StopScreenSharing: already disconnected');

    }
  }

  function CloseItAll() {
    console.log('CallWindowShareScreen: CloseItAll', isScreenSharingOn);

    // make the callInfo null
    dispatch(setCallInfo(null));

    // remove yourself from the DOM
    props.OnRemoveSelf();

    setisScreenSharingOn(false);

    setLocalStream(null);
    setRemoteStream(null);

    setMembers([]);

    console.log('Screen sharing finally stopped');
  }

  function DestroyStreams() {
    console.log('CallWindowShareScreen: Destroying streams');

    if (localStream !== null) {
      localStream.getTracks().forEach((track) => {
        track.stop();
      });
    }

    if (remoteStream !== null) {
      remoteStream.getTracks().forEach((track) => {
        track.stop();
      });
    }
  }

  function getFirstName(fullName) {
    return fullName.split(" ")[0];
  }

  // rendeer UI based on members list and their streams set at different stages of connection
  return (
    <View style={{
      flexDirection: "row",
      justifyContent: 'space-evenly',
      alignItems: 'center',
      justifyItems: 'center',
      height: videoHeight + 60,
      backgroundColor: 'white',
      paddingTop: 120,
      paddingBottom: 100,
      paddingLeft: 60,
      paddingRight: 60,
    }}>
      {localStream &&
        <View style={{ flexDirection: 'column' }}>
          <RTCView style=
            {{
              width: videoWidth,
              height: videoHeight,
            }}
            mirror={true}
            objectFit={"contain"}
            streamURL={localStream.toURL()}
          />
          <Text style={{ fontSize: 18, color: 'black', fontWeight: 'bold', textAlign: 'center' }}>You</Text>
        </View>}
      {remoteStream &&
        <View style={{ flexDirection: 'column', alignItems: 'center' }}>
          <RTCView style=
            {{
              width: videoWidth,
              height: videoHeight,
            }}
            mirror={true}
            objectFit={"contain"}
            streamURL={remoteStream.toURL()} />
          <Text style={{ flexDirection: 'row', flexWrap: 'wrap', fontSize: 18, fontWeight: 'bold', color: 'black', textAlign: 'center' }}>{getFirstName(props.onGoingCallInfo?.toChannel?.name)}</Text>
        </View>}
    </View>
  );
}

export default CallWindowShareScreen;