import { View, Text, StyleSheet, Platform, Pressable } from "react-native";
import React, { useEffect, useState } from "react";
import { useTheme } from "@react-navigation/native";
import { useDispatch, useSelector } from "react-redux";
import { mediaDevices, RTCView } from "react-native-webrtc";

import colabLog from "@/src/libs/webrtc/utils/colabLog";

import { setCallInfo, setNewRemoteStreamConnected } from "@/src/redux/actions/call-action";
import WebRTCHandler from '@/src/libs/webrtc/WebRTCHandler';
import { WebRTCDataChannelLabel, WebRTCDataChannelType, WebRTCDataChannelStreamType } from '@/src/libs/webrtc/models/DataChannelLabel';
import { CALL_EVENTS, getClosedCallInfo, getActiveCallInfo } from "../call-strip/call-events";

function CallWindowVideo(props) {
  console.log('CallWindowVideo props', props);

  const dispatch = useDispatch();

  const videoWidth = 340;
  const aspectRatio = 16 / 9;
  const videoHeight = videoWidth / aspectRatio;

  // store
  const { callInfo, webRTCHandler } = new useSelector((state) => state.callState);

  // state
  const [isVideoStreamingOn, setIsVideoStreamingOn] = useState(false);
  const [localStream, setLocalStream] = useState(null);
  const [remoteStream, setRemoteStream] = useState(null);
  const [videoStreamingDCLabel, setVideoStreamingDCLabel] = useState(null);
  const [members, setMembers] = useState([]);

  // ui related
  const { colors } = useTheme();

  // effect init
  useEffect(() => {
    console.log('CallWindowVideo useEffect init');

    if (callInfo?.event === CALL_EVENTS.disconnecting) {
      console.log('CallWindowVideo useEffect event disconnecting');
      StopStreaming(false);
    }
    else if (callInfo?.event === CALL_EVENTS.closed) {
      console.log('CallWindowVideo: callInfo is closed');
      CloseItAll();
    }
    else if (props.onGoingCallInfo !== null && props.onGoingCallInfo !== undefined) {
      console.log(props.onGoingCallInfo.fromChannel?.name, ' --> CallWindowVideo useEffect onGoingCallInfo', props.onGoingCallInfo);
      console.log(props.onGoingCallInfo.fromChannel?.name, ' --> CallWindowVideo useEffect onGoingCallInfo event', props.onGoingCallInfo.event);

      if (props.onGoingCallInfo.event === CALL_EVENTS.outgoing) {
        console.log('CallWindowVideo useEffect event outgoing');
        handleVideoStreamingByIntiator(props.onGoingCallInfo).then((isSuccess) => {
          console.log('CallWindowVideo useEffect handleVideoStreamingByIntiator completed');
        }).catch((error) => {
          console.error('CallWindowVideo useEffect handleVideoStreamingByIntiator failed', error);
        });
      }
      else if (props.onGoingCallInfo.event === CALL_EVENTS.incoming) {
        console.log('CallWindowVideo useEffect event incoming');
        handleVideoStreamingByReceiver(props.onGoingCallInfo).then((isSuccess) => {
          console.log('CallWindowVideo useEffect handleVideoStreamingByReceiver completed');
        }).catch((error) => {
          console.error('CallWindowVideo useEffect handleVideoStreamingByReceiver failed', error);
        });
      }
    }
  }, [props.onGoingCallInfo, props.onGoingCallInfo?.event, callInfo?.event]);

  // IMPORTANT: handle video streaming setup and call
  // when the current user clicks on the video call button
  async function handleVideoStreamingByIntiator(callingInfo) {
    console.log(callingInfo?.fromChannel?.name, ' --> CallWindowVideo: Starting video streaming');

    if (videoStreamingDCLabel !== null && videoStreamingDCLabel !== undefined) {
      console.log('CallWindowVideo: Video streaming already on');
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

    // create the video channel label
    console.log(callingInfo?.fromChannel?.name, ' --> CallWindowVideo: You are the initiator of the call');

    // create this user's side of the peer connection
    // NOTE: the data used here is from callInfo which is set on call button click in chat header component
    await webRTCHandler.ConnectDataChannel(WebRTCDataChannelType.P2P, 1,
      callingInfo?.fromChannel, callingInfo?.toChannel, WebRTCDataChannelStreamType.VIDEO).then(async (videoStreamingDataChannelLabel) => {
        if (videoStreamingDataChannelLabel === null || videoStreamingDataChannelLabel === undefined) {
          console.error('CallWindowVideo: videoStreamingDataChannelLabel is null');
          return false;
        }
        else {
          colabLog(videoStreamingDataChannelLabel, 'CallWindowVideo: videoStreamingDataChannelLabel', videoStreamingDataChannelLabel.dataChannelName);
          colabLog(videoStreamingDataChannelLabel, 'CallWindowVideo: from User', videoStreamingDataChannelLabel.fromChannel?.id);

          // set it prt of the state used for stopping the video streaming
          setVideoStreamingDCLabel(videoStreamingDataChannelLabel);

          // setup and handle video streaming callbacks when the other peer accepts the video call
          // set remoteStream on receive remote stream callback
          webRTCHandler.SetMediaStreamReceiveCallback(videoStreamingDataChannelLabel, receiveRemoteStream);

          // start the video streaming setup and call
          // get access to camera and microphone
          var strm = await mediaDevices.getUserMedia({
            audio: true,
            video: { width: videoWidth, height: videoHeight }
          });

          console.debug('CallWindowVideo: handleVideoStreaming: local stream', strm);
          setLocalStream(strm);
          setRemoteStream(null);

          // init the event handlers for peer connection callbacks
          await webRTCHandler.Init(true, videoStreamingDataChannelLabel, strm);

          // set the initiate video streaming callback which is called when the other peer accepts the video call
          webRTCHandler.SetStartCallCallBack(videoStreamingDataChannelLabel, initiateVideoStreamingHandler);

          // this callback will be called when peer sends call stopped message
          webRTCHandler.SetStopCallCallBack(videoStreamingDataChannelLabel, StopStreaming);

          // send to the other peer that the call is initiated on my end
          webRTCHandler.SendInitiateCallMessage(videoStreamingDataChannelLabel);

          colabLog(videoStreamingDataChannelLabel, 'CallWindowVideo: completed handleVideoStreamingByIntiator');

          return true;
        }
      }).catch((error) => {
        console.error('CallWindowVideo: ConnectDataChannel failed', error);
        console.error('CallWindowVideo: Video streaming setup failed at the initiator end');
        return false;
      });
  }

  async function handleVideoStreamingByReceiver(callingInfo) {
    console.log(callingInfo?.toChannel?.name, ' --> CallWindowVideo: You are the receiver of the call');

    if (videoStreamingDCLabel !== null && videoStreamingDCLabel !== undefined) {
      console.log('CallWindowVideo: Video streaming already on');
      return false;
    }

    if (callingInfo === null || callingInfo === undefined) {
      console.error('callinginfo is null in receiver end');
      return false
    }

    await webRTCHandler.ConnectDataChannel(WebRTCDataChannelType.P2P, 1,
      callingInfo?.fromChannel, callingInfo?.toChannel, WebRTCDataChannelStreamType.VIDEO).then(async (videoStreamingDataChannelLabel) => {
        if (videoStreamingDataChannelLabel === null || videoStreamingDataChannelLabel === undefined) {
          console.error('CallWindowVideo: videoStreamingDataChannelLabel is null');
          return false;
        }
        else {
          colabLog(videoStreamingDataChannelLabel, 'CallWindowVideo: videoStreamingDataChannelLabel', videoStreamingDataChannelLabel.dataChannelName);

          // set it prt of the state used for stopping the video streaming
          setVideoStreamingDCLabel(videoStreamingDataChannelLabel);

          // start the video streaming setup and call
          // get access to camera and microphone
          var strm = await mediaDevices.getUserMedia({
            audio: true,
            video: { width: videoWidth, height: videoHeight }
          });

          console.debug('CallWindowVideo: handleVideoStreaming: local stream', strm);
          setLocalStream(strm);
          setRemoteStream(null);

          // setup and handle video streaming callbacks when the other peer accepts the video call
          // set remoteStream on receive remote stream callback
          webRTCHandler.SetMediaStreamReceiveCallback(videoStreamingDataChannelLabel, receiveRemoteStream);

          // init the connetion
          await webRTCHandler.Init(false, videoStreamingDataChannelLabel, strm);

          // this callback will be called when peer sends call started message
          webRTCHandler.SetStartCallCallBack(videoStreamingDataChannelLabel, initiateVideoStreaming);

          // this callback will be called when peer sends call stopped message
          webRTCHandler.SetStopCallCallBack(videoStreamingDataChannelLabel, StopStreaming);

          // let the peer know that the call is initiated on my end
          webRTCHandler.SendCallInitiatedlMessage(videoStreamingDataChannelLabel);

          colabLog(videoStreamingDataChannelLabel, 'CallWindowVideo: completed handleVideoStreamingByReceiver');
          return true;
        }
      }).catch((error) => {
        console.error('CallWindowVideo: ConnectDataChannel failed', error);
        console.error('CallWindowVideo: Video streaming setup failed at the initiator end');
        return false;
      });
  }

  async function initiateVideoStreamingHandler(videoStreamingDataChannelLabel) {
    console.log(videoStreamingDataChannelLabel.toChannel?.name, ' --> CallWindowVideo: In initiateVideoStreamingHandler');

    await initiateVideoStreaming(videoStreamingDataChannelLabel);
    console.log(videoStreamingDataChannelLabel.toChannel?.name, ' --> CallWindowVideo: initiateVideoStreamingHandler: initiated video streaming');

    webRTCHandler.SendCallStartedMessage(videoStreamingDataChannelLabel);
  }

  // initiate video streaming
  async function initiateVideoStreaming(videoStreamingDataChannelLabel) {
    console.log(videoStreamingDataChannelLabel.toChannel?.name, ' -- >CallWindowVideo: In initiateVideoStreaming');

    colabLog(videoStreamingDataChannelLabel, 'CallWindowVideo: initiateVideoStreaming: isvideostreamingon', isVideoStreamingOn);

    if (isVideoStreamingOn) {
      console.log('CallWindowVideo: Video streaming already on');
      return false;
    }

    if (videoStreamingDataChannelLabel === null || videoStreamingDataChannelLabel === undefined) {
      console.error('CallWindowVideo: videoStreamingDataChannelLabel is null');
      return false;
    }

    console.debug(videoStreamingDataChannelLabel.toChannel?.name, ' --> CallWindowVideo: initiateVideoStreaming: videoStreamingDataChannelLabel', videoStreamingDataChannelLabel?.dataChannelName);

    // !!! initiate video streaming
    const isSuccess = await webRTCHandler?.StartVideoStreaming(videoStreamingDataChannelLabel);
    console.log(videoStreamingDataChannelLabel.toChannel?.name, ' --> CallWindowVideo: initiateVideoStreaming: StartVideoStreaming', isSuccess);

    //    if (isSuccess == true) {
    setIsVideoStreamingOn(true);

    dispatch(setCallInfo(getActiveCallInfo(props.onGoingCallInfo)));

    console.log(videoStreamingDataChannelLabel.toChannel?.name, 'Video streaming setup completed!!!!');

    return true;
    // TODO: to check the reture value
  /*   } else {
      console.error(videoStreamingDataChannelLabel.fromChannel?.name, ' --> Video streaming setup failed');
      setIsVideoStreamingOn(false);
      return false;
    }
 */  }

  // callback from webrtc handler when remote stream is created/received from the peer
  function receiveRemoteStream(remoteStream) {
    console.log('CallWindowVideo: receiveRemoteStream: OnRemoteStream', remoteStream);

    //const newMember = {};
    //newMember.stream = remoteStream;

    setRemoteStream(remoteStream);
    console.log('CallWindowVideo: receiveRemoteStream: remoteStream is set');
  }

  // called when cancel or leave button is clicked on the call strip
  function StopStreaming(force) {
    console.log('CallWindowVideo: Stopping video streaming');

    colabLog(videoStreamingDCLabel, 'CallWindowVideo: StopStreaming: isvideostreamingon', isVideoStreamingOn);

    if (!force && !isVideoStreamingOn) {
      console.log('CallWindowVideo: Video streaming already off');
    }
    else if (webRTCHandler === null) {
      console.error('WebRTC handler not found');
    }
    else {
      console.log('CallWindowVideo: Stopping video streaming');

      if (webRTCHandler.IsConnected()) {
        // before you destroy yourself, send a message to your peer 
        if (videoStreamingDCLabel !== null && videoStreamingDCLabel !== undefined) {
          // sending stop to the other peer
          colabLog(videoStreamingDCLabel, 'CallWindowVideo: signaling to the peer to stop video streaming');
          webRTCHandler.SendCallStoppedMessage(videoStreamingDCLabel);
        }

        // start shutdown process
        const isStopped = webRTCHandler?.StopVideoStreaming();
        console.log('CallWindowVideo: StopVideoStreaming', isStopped);

        if (isStopped) {
          DestroyStreams();

          const closedCallInfo = getClosedCallInfo(props.onGoingCallInfo);
          dispatch(setCallInfo(closedCallInfo));
        }
        else {
          console.error('Video streaming stop failed');
        }
      }
      else
        colabLog(videoStreamingDCLabel, 'CallWindowVideo: StopStreaming: already disconnected');

    }
  }

  function CloseItAll() {
    console.log('CallWindowVideo: CloseItAll', isVideoStreamingOn);

    // make the callInfo null
    dispatch(setCallInfo(null));

    // remove yourself from the DOM
    props.OnRemoveSelf();

    setIsVideoStreamingOn(false);

    setLocalStream(null);
    setRemoteStream(null);

    setMembers([]);

    console.log('Video streaming finally stopped');
  }

  function DestroyStreams() {
    console.log('CallWindowVideo: Destroying streams');

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
            streamURL={remoteStream.toURL()} />
          <Text style={{ flexDirection: 'row', flexWrap: 'wrap', fontSize: 18, fontWeight: 'bold', color: 'black', textAlign: 'center' }}>{getFirstName(props.onGoingCallInfo?.toChannel?.name)}</Text>
        </View>}
    </View>
  );
}

export default CallWindowVideo;