import { View, Text, StyleSheet, Platform, Pressable } from "react-native";
import React, { useEffect, useState } from "react";
import { useTheme } from "@react-navigation/native";
import { useDispatch, useSelector } from "react-redux";
import { mediaDevices, RTCView } from "react-native-webrtc";

import colabLog from "@/src/libs/webrtc/utils/colabLog";

import AppImage from "../../app-image";

import { setCallInfo, setNewRemoteStreamConnected } from "@/src/redux/actions/call-action";
import WebRTCHandler from '@/src/libs/webrtc/WebRTCHandler';
import { WebRTCDataChannelLabel, WebRTCDataChannelType, WebRTCDataChannelStreamType } from '@/src/libs/webrtc/models/DataChannelLabel';
import { CALL_EVENTS, getClosedCallInfo, getActiveCallInfo } from "../call-strip/call-events";
import {
  hp,
  wp,
  Colors,
  Icons
} from "@/src/constants";

function CallWindowAudio(props) {
  console.log('CallWindowAudio props', props);

  const dispatch = useDispatch();

  // store
  const { callInfo, webRTCHandler } = new useSelector((state) => state.callState);

  // state
  const [isAudioStreamingOn, setIsAudioStreamingOn] = useState(false);
  const [localStream, setLocalStream] = useState(null);
  const [remoteStream, setRemoteStream] = useState(null);
  const [audioStreamingDCLabel, setAudioStreamingDCLabel] = useState(null);
  const [members, setMembers] = useState([]);
  const [newMemberAdded, setNewMemberAdded] = useState(null);

  // ui related
  const { colors } = useTheme();

  // effect init
  useEffect(() => {
    console.log('CallWindowAudio useEffect init');

    if (callInfo?.event === CALL_EVENTS.disconnecting) {
      console.log('CallWindowAudio useEffect event disconnecting');
      StopStreaming(false);
    }
    else if (props.onGoingCallInfo !== null && props.onGoingCallInfo !== undefined) {
      console.log(props.onGoingCallInfo.fromChannel?.name, ' --> CallWindowAudio useEffect onGoingCallInfo', props.onGoingCallInfo);
      console.log(props.onGoingCallInfo.fromChannel?.name, ' --> CallWindowAudio useEffect onGoingCallInfo event', props.onGoingCallInfo.event);

      if (props.onGoingCallInfo.event === CALL_EVENTS.outgoing) {
        console.log('CallWindowAudio useEffect event outgoing');
        handleAudioStreamingByIntiator(props.onGoingCallInfo).then((isSuccess) => {
          console.log('CallWindowAudio useEffect handleAudioStreamingByIntiator completed');
        }).catch((error) => {
          console.error('CallWindowAudio useEffect handleAudioStreamingByIntiator failed', error);
        });
      }
      else if (props.onGoingCallInfo.event === CALL_EVENTS.incoming) {
        console.log('CallWindowAudio useEffect event incoming');
        handleAudioStreamingByReceiver(props.onGoingCallInfo).then((isSuccess) => {
          console.log('CallWindowAudio useEffect handleAudioStreamingByReceiver completed');
        }).catch((error) => {
          console.error('CallWindowAudio useEffect handleAudioStreamingByReceiver failed', error);
        });
      }
    }
  }, [props.onGoingCallInfo, props.onGoingCallInfo?.event, callInfo?.event]);

  useEffect(() => {
    if (remoteStream !== null) {
      const channels = [...members];
      channels.push({ name: props.onGoingCallInfo?.toChannel.name, stream: remoteStream });
      setMembers(channels);
      setNewMemberAdded({ name: props.onGoingCallInfo?.toChannel.name, stream: remoteStream });
      console.log('CallWindowAudio: useEffect: members', channels);
    }
  }, [remoteStream]);

  // IMPORTANT: handle audio streaming setup and call
  // when the current user clicks on the audio call button
  async function handleAudioStreamingByIntiator(callingInfo) {
    console.log(callingInfo?.fromChannel?.name, ' --> CallWindowAudio: Starting audio streaming');

    if (audioStreamingDCLabel !== null && audioStreamingDCLabel !== undefined) {
      console.log('CallWindowAudio: Audio streaming already on');
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

    // create the audio channel label
    console.log(callingInfo?.fromChannel?.name, ' --> CallWindowAudio: You are the initiator of the call');

    // create this user's side of the peer connection
    // NOTE: the data used here is from callInfo which is set on call button click in chat header component
    await webRTCHandler.ConnectDataChannel(WebRTCDataChannelType.P2P, 1,
      callingInfo?.fromChannel, callingInfo?.toChannel, WebRTCDataChannelStreamType.AUDIO).then(async (audioStreamingDataChannelLabel) => {
        if (audioStreamingDataChannelLabel === null || audioStreamingDataChannelLabel === undefined) {
          console.error('CallWindowAudio: audioStreamingDataChannelLabel is null');
          return false;
        }
        else {
          colabLog(audioStreamingDataChannelLabel, 'CallWindowAudio: audioStreamingDataChannelLabel', audioStreamingDataChannelLabel.dataChannelName);
          colabLog(audioStreamingDataChannelLabel, 'CallWindowAudio: from User', audioStreamingDataChannelLabel.fromChannel?.id);

          // set it prt of the state used for stopping the audio streaming
          setAudioStreamingDCLabel(audioStreamingDataChannelLabel);

          // setup and handle audio streaming callbacks when the other peer accepts the audio call
          // set remoteStream on receive remote stream callback
          webRTCHandler.SetMediaStreamReceiveCallback(audioStreamingDataChannelLabel, receiveRemoteStream);

          // start the audio streaming setup and call
          // get access to camera and microphone
          var strm = await mediaDevices.getUserMedia({
            video: false,
            audio: true,
          });

          const channels = [];
          channels.push({ name: callingInfo?.fromChannel?.name, stream: strm });
          setMembers(channels);

          muteAudio(strm, true);

          console.debug('CallWindowAudio: handleAudioStreaming: local stream', strm);
          setLocalStream(strm);
          setRemoteStream(null);

          // init the event handlers for peer connection callbacks
          await webRTCHandler.Init(true, audioStreamingDataChannelLabel, strm);

          // set the initiate audio streaming callback which is called when the other peer accepts the audio call
          webRTCHandler.SetStartCallCallBack(audioStreamingDataChannelLabel, initiateAudioStreamingHandler);

          // this callback will be called when peer sends call stopped message
          webRTCHandler.SetStopCallCallBack(audioStreamingDataChannelLabel, StopStreaming);

          // send to the other peer that the call is initiated on my end
          webRTCHandler.SendInitiateCallMessage(audioStreamingDataChannelLabel);

          colabLog(audioStreamingDataChannelLabel, 'CallWindowAudio: completed handleAudioStreamingByIntiator');

          return true;
        }
      }).catch((error) => {
        console.error('CallWindowAudio: ConnectDataChannel failed', error);
        console.error('CallWindowAudio: Audio streaming setup failed at the initiator end');
        return false;
      });
  }

  async function handleAudioStreamingByReceiver(callingInfo) {
    console.log(callingInfo?.toChannel?.name, ' --> CallWindowAudio: You are the receiver of the call');

    if (audioStreamingDCLabel !== null && audioStreamingDCLabel !== undefined) {
      console.log('CallWindowAudio: Audio streaming already on');
      return false;
    }

    if (callingInfo === null || callingInfo === undefined) {
      console.error('callinginfo is null in receiver end');
      return false
    }

    await webRTCHandler.ConnectDataChannel(WebRTCDataChannelType.P2P, 1,
      callingInfo?.fromChannel, callingInfo?.toChannel, WebRTCDataChannelStreamType.AUDIO).then(async (audioStreamingDataChannelLabel) => {
        if (audioStreamingDataChannelLabel === null || audioStreamingDataChannelLabel === undefined) {
          console.error('CallWindowAudio: audioStreamingDataChannelLabel is null');
          return false;
        }
        else {
          colabLog(audioStreamingDataChannelLabel, 'CallWindowAudio: audioStreamingDataChannelLabel', audioStreamingDataChannelLabel.dataChannelName);

          // set it prt of the state used for stopping the audio streaming
          setAudioStreamingDCLabel(audioStreamingDataChannelLabel);

          // start the audio streaming setup and call
          // get access to camera and microphone
          var strm = await mediaDevices.getUserMedia({
            audio: true,
            video: false,
          });

          console.debug('CallWindowAudio: handleAudioStreaming: local stream', strm);
          setLocalStream(strm);
          setRemoteStream(null);

          // setup and handle audio streaming callbacks when the other peer accepts the audio call
          // set remoteStream on receive remote stream callback
          webRTCHandler.SetMediaStreamReceiveCallback(audioStreamingDataChannelLabel, receiveRemoteStream);

          // init the connetion
          await webRTCHandler.Init(false, audioStreamingDataChannelLabel, strm);

          // this callback will be called when peer sends call started message
          webRTCHandler.SetStartCallCallBack(audioStreamingDataChannelLabel, initiateAudioStreaming);

          // this callback will be called when peer sends call stopped message
          webRTCHandler.SetStopCallCallBack(audioStreamingDataChannelLabel, StopStreaming);

          // let the peer know that the call is initiated on my end
          webRTCHandler.SendCallInitiatedlMessage(audioStreamingDataChannelLabel);

          colabLog(audioStreamingDataChannelLabel, 'CallWindowAudio: completed handleAudioStreamingByReceiver');
          return true;
        }
      }).catch((error) => {
        console.error('CallWindowAudio: ConnectDataChannel failed', error);
        console.error('CallWindowAudio: Audio streaming setup failed at the initiator end');
        return false;
      });
  }

  async function initiateAudioStreamingHandler(audioStreamingDataChannelLabel) {
    console.log(audioStreamingDataChannelLabel.toChannel?.name, ' --> CallWindowAudio: In initiateAudioStreamingHandler');

    await initiateAudioStreaming(audioStreamingDataChannelLabel);
    console.log(audioStreamingDataChannelLabel.toChannel?.name, ' --> CallWindowAudio: initiateAudioStreamingHandler: initiated audio streaming');

    webRTCHandler.SendCallStartedMessage(audioStreamingDataChannelLabel);
  }

  // initiate audio streaming
  async function initiateAudioStreaming(audioStreamingDataChannelLabel) {
    console.log(audioStreamingDataChannelLabel.toChannel?.name, ' -- >CallWindowAudio: In initiateAudioStreaming');

    colabLog(audioStreamingDataChannelLabel, 'CallWindowAudio: initiateAudioStreaming: isaudiostreamingon', isAudioStreamingOn);

    if (isAudioStreamingOn) {
      console.log('CallWindowAudio: Audio streaming already on');
      return false;
    }

    if (audioStreamingDataChannelLabel === null || audioStreamingDataChannelLabel === undefined) {
      console.error('CallWindowAudio: audioStreamingDataChannelLabel is null');
      return false;
    }

    console.debug(audioStreamingDataChannelLabel.toChannel?.name, ' --> CallWindowAudio: initiateAudioStreaming: audioStreamingDataChannelLabel', audioStreamingDataChannelLabel?.dataChannelName);

    // !!! initiate audio streaming
    const isSuccess = await webRTCHandler?.StartAudioStreaming(audioStreamingDataChannelLabel);
    console.log(audioStreamingDataChannelLabel.toChannel?.name, ' --> CallWindowAudio: initiateAudioStreaming: StartAudioStreaming', isSuccess);

    //    if (isSuccess == true) {
    setIsAudioStreamingOn(true);

    dispatch(setCallInfo(getActiveCallInfo(props.onGoingCallInfo)));

    console.log(audioStreamingDataChannelLabel.toChannel?.name, 'Audio streaming setup completed!!!!');

    return true;
    // TODO: to check the reture value
  /*   } else {
      console.error(audioStreamingDataChannelLabel.fromChannel?.name, ' --> Audio streaming setup failed');
      setIsAudioStreamingOn(false);
      return false;
    }
 */  }

  // callback from webrtc handler when remote stream is created/received from the peer
  function receiveRemoteStream(remoteStream) {
    console.log('CallWindowAudio: receiveRemoteStream: OnRemoteStream', remoteStream);

    setRemoteStream(remoteStream);
    console.log('CallWindowAudio: receiveRemoteStream: remoteStream is set');
  }

  // called when cancel or leave button is clicked on the call strip
  function StopStreaming(force) {
    console.log('CallWindowAudio: Stopping audio streaming');

    colabLog(audioStreamingDCLabel, 'CallWindowAudio: StopStreaming: isaudiostreamingon', isAudioStreamingOn);

    if (!force && !isAudioStreamingOn) {
      console.log('CallWindowAudio: Audio streaming already off');
    }
    else if (webRTCHandler === null) {
      console.error('WebRTC handler not found');
    }
    else {
      console.log('CallWindowAudio: Stopping audio streaming');

      if (webRTCHandler.IsConnected()) {
        // before you destroy yourself, send a message to your peer 
        if (audioStreamingDCLabel !== null && audioStreamingDCLabel !== undefined) {
          // sending stop to the other peer
          colabLog(audioStreamingDCLabel, 'CallWindowAudio: signaling to the peer to stop audio streaming');
          webRTCHandler.SendCallStoppedMessage(audioStreamingDCLabel);
        }

        // start shutdown process
        const isStopped = webRTCHandler?.StopAudioStreaming();
        console.log('CallWindowAudio: StopAudioStreaming', isStopped);

        if (isStopped) {
          setIsAudioStreamingOn(false);
          console.log('CallWindowAudio: StopStreaming isAudioStreamingOn2', isAudioStreamingOn);

          DestroyStreams();

          setMembers([]);

          const closedCallInfo = getClosedCallInfo(props.onGoingCallInfo);
          dispatch(setCallInfo(closedCallInfo));

          console.log('Audio streaming stopped');
        }
        else {
          console.error('Audio streaming stop failed');
        }
      }
      else
        colabLog(audioStreamingDCLabel, 'CallWindowAudio: StopStreaming: already disconnected');

      // remove yourself from the DOM
      props.OnRemoveSelf();
    }
  }

  function DestroyStreams() {
    console.log('CallWindowAudio: Destroying streams');

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

/*     if (members.length > 0) {
      members.forEach((member) => {
        if (member.stream !== null) {
          member.stream.getTracks().forEach((track) => {
            track.stop();
          });
        }
      });
    }
 */
    setLocalStream(null);
    setRemoteStream(null);
  }

  function muteAudio(stream, mute) {
    const audioTracks = stream.getAudioTracks(); // Get all audio tracks
    if (audioTracks.length === 0) {
      console.log("No audio track available to mute.");
      return;
    }

    // Mute or unmute all audio tracks
    audioTracks.forEach(track => {
      track.enabled = !mute;
    });
  }

  function getFirstName(fullName) {
    return fullName.split(" ")[0];
  }

  // View related methods
  const renderItem = ({ item, index }) => {
    return (
      <View
        key={String(index)}
        style={{
          alignItems: "center",
          justifyContent: "center",
          padding: wp("15%"),  
        }}
      >
        <View style={{ flexDirection: 'column', height:140 }}>
          {item.stream &&
            <RTCView style=
              {{
                display: 'none',
                height: 0,
                width: 0,
              }}
              streamURL={item.stream.toURL()
              } />
          }
          <AppImage
            size={wp("25%")}
            source={
              Icons.userthumbnail
            }
            isRounded={true}
            style={{ marginBottom: hp("1%") }}
          />
          <Text numberOfLines={1} size={hp("1.7%")} style={{ fontSize: 18, color: 'black', fontWeight:'bold', textAlign: 'center' }}>
            {index === 0 ? "You" : getFirstName(item?.name)}
          </Text>
        </View>
      </View>
    );
  };

  // rendeer UI based on members list and their streams set at different stages of connection
  return (
    <View style={{
      flexDirection: "row",
      justifyContent: 'space-evenly',
      alignItems: 'center',
      justifyItems: 'center',
      backgroundColor: 'white',
      height: hp("30%"),
    }}>
      {members[0] && renderItem({ item: members[0], index: 0 })}
      {newMemberAdded && renderItem({ item: newMemberAdded, index: 1 })}
    </View>
  );
}

export default CallWindowAudio;