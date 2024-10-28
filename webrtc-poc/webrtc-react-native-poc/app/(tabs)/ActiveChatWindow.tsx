import { StyleSheet, View, Image, Platform } from 'react-native';
import { ScrollView, GestureHandlerRootView } from 'react-native-gesture-handler';
import { ThemedText } from '@/src/components/ThemedText';
import { ThemedView } from '@/src/components/ThemedView';
import { useState } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { useRef } from 'react';

import { useEffect } from 'react';

import Ionicons from '@expo/vector-icons/Ionicons';
import FontAwesome from '@expo/vector-icons/FontAwesome'; // Changed from Ionicons to FontAwesome

import { ChannelMessage } from '../../src/libs/webrtc/models/ChannelMessage';

import { WebRTCChannelType } from '../../src/libs/webrtc/models/Channel';
import WebRTCHandler from '../../src/libs/webrtc/WebRTCHandler';
import ChatBox from '../../src/components/chat-screen/ChatBox';
import ChatMessagesWindow from '../../src/components/chat-screen/ChatMessagesWindow';

import { setCallInfo, setWebRTCHandler } from '../../src/redux/actions/call-action';
import { getOutGoingCallInfo } from '../../src/components/chat-screen/call-strip/call-events';

export default function ActiveChatWindow() {
  const [currentDataChannelName, setCurrentDataChannelName] = useState('');
  const [currentDataChannel, setCurrentDataChannel] = useState(null);
  const [currentChannelChatMessages, setCurrentChannelChatMessages] = useState<ChannelMessage[]>([]);
  const [newMessagesCount, setNewMessagesCount] = useState(0);

  const { webRTCHandler } = useSelector((state: any) => state.callState);
  const { userLoginData, currentChannelData } = useSelector((state: any) => state.userState);
  const [chatTitle, setchatTitle] = useState('');

  const dispatch = useDispatch();

  useEffect(() => {
    console.log('ActiveChatWindow userLoginData:', userLoginData);
    console.log('ActiveChatWindow webRTCHandler:', webRTCHandler);

    webRTCHandler!.SetReceiveChannelMessageCallback(onReceiveMessage);
    webRTCHandler!.SetReceiveSystemCommandCallback(onReceiveCommand);

    // on init load the mesaages
    if (currentDataChannelName !== null && currentDataChannelName !== undefined) {
      setCurrentChannelChatMessages(webRTCHandler!.GetChannelMessages(currentDataChannelName));
    }
  }, []);

  useEffect(() => {
    // Code to run when currentChannelData changes
    console.log('ActiveChatWindow currentChannelData:', currentChannelData);

    const title = userLoginData?.name + ' is chatting with ' + currentChannelData?.name;
    console.log('ActiveChatWindow title:', title);

    setchatTitle(title);

    if (currentDataChannelName !== null && currentDataChannelName !== undefined) {
      setCurrentChannelChatMessages(webRTCHandler!.GetChannelMessages(currentDataChannelName) || []);
    }
  }, [userLoginData, currentChannelData]);

  useEffect(() => {

    if (currentDataChannelName !== null && currentDataChannelName !== undefined) {
      setCurrentChannelChatMessages(webRTCHandler!.GetChannelMessages(currentDataChannelName) || []);
    }
  }, [currentDataChannelName]);

  useEffect(() => {
    console.log('ActiveChatWindow newMessagesCount:', newMessagesCount);
    setNewMessagesCount(currentChannelChatMessages.length);
  }, [currentChannelChatMessages]);
  // ---------------------------------------------------------------------------------------
  // messaging routines
  // to be called (via props usually) when a message is sent
  function onSentMessage(channelName: string, msg: ChannelMessage) {
    console.log('OnSentMessage:', channelName);
    console.log('OnSentMessage5:', currentDataChannelName);

    let chnlName = currentDataChannelName;
    if (chnlName === null || chnlName === undefined) {
      chnlName = channelName;
    }

    
    //if (currentDataChannelName === channelName) {
      console.log('OnSentMessage: setting currentChannelChatMessages');
      setCurrentChannelChatMessages(webRTCHandler!.GetChannelMessages(channelName));
    //}
  };

  // receive any type of message
  function onReceiveMessage(
    channelMessage: ChannelMessage
  ): void {
    if (channelMessage === null || channelMessage === undefined) {
      console.error('Channel message is null');
      return;
    }

    if (channelMessage.dataChannel === null || channelMessage.dataChannel === undefined) {
      console.error('data Channel label is empty');
      return;
    }

    const messages = webRTCHandler!.GetChannelMessages(channelMessage.dataChannel.dataChannelName!);
    setCurrentChannelChatMessages(messages!);
  }

  function onReceiveCommand(
    commandMessage: ChannelMessage
  ): void {
    if (commandMessage === null || commandMessage === undefined) {
      console.error('Channel message is null');
      return;
    }

    if (commandMessage.dataChannel === null || commandMessage.dataChannel === undefined) {
      console.error('data Channel label is empty');
      return;
    }

    // do some processing based on command
  }

  function startVoiceCall() {
    console.log('Start voice call');

    console.log("-------------------------------------------------------------------------------------------------------");
    console.log("onVoiceCallIconPress");

    const isOneOnOne = true; //isOneToOneChat();
    const webRTCChannelType = isOneOnOne ? WebRTCChannelType.USER : WebRTCChannelType.GROUP;

    const callInfo = getOutGoingCallInfo(null, userLoginData, currentChannelData, webRTCChannelType, "audio");
    console.log("onVoiceCallIconPress callInfo", callInfo);

    dispatch(setCallInfo(callInfo) as any);
  }

  function startVideoCall() {
    console.log('Start video call');

    console.log("-------------------------------------------------------------------------------------------------------");
    console.log("onVideoCallIconPress");

    const isOneOnOne = true; //isOneToOneChat();
    const webRTCChannelType = isOneOnOne ? WebRTCChannelType.USER : WebRTCChannelType.GROUP;

    const callInfo = getOutGoingCallInfo(null, userLoginData, currentChannelData, webRTCChannelType, "video");
    console.log("onVideoCallIconPress callInfo", callInfo);

    dispatch(setCallInfo(callInfo) as any);
  }

  function startScreenShare() {
    console.log('Start screen share');

    console.log("-------------------------------------------------------------------------------------------------------");
    console.log("onScreenShareIconPress");

    const isOneOnOne = true; //isOneToOneChat();
    const webRTCChannelType = isOneOnOne ? WebRTCChannelType.USER : WebRTCChannelType.GROUP;

    const callInfo = getOutGoingCallInfo(null, userLoginData, currentChannelData, webRTCChannelType, "screen");
    console.log("onSCreenShareIconPress callInfo", callInfo);

    dispatch(setCallInfo(callInfo) as any);
  }

  return (
    <View style={styles.chatBodyContainer}>
      <ThemedView style={styles.titleContainer}>
        <ThemedText type="title" style={styles.loginText}>{chatTitle}</ThemedText>
        <View style={styles.callWindowActions}>
          <Ionicons name="call" size={24} color="black" onPress={startVoiceCall} />
          <Ionicons name="videocam" size={24} color="black" style={{ marginRight: 5 }} onPress={startVideoCall} />
          <FontAwesome name="desktop" size={20} color="black" onPress={startScreenShare} />
        </View>
      </ThemedView>

      <View style={styles.chatWindow}>
        <ChatMessagesWindow
          chatMessages={currentChannelChatMessages}
          dataChannelName={currentDataChannelName}
          webRTCHandler={webRTCHandler}
          newMessagesCount={newMessagesCount}
        />
      </View>

      <View style={styles.chatBox}>
        {webRTCHandler && 
        <ChatBox onSentMessage={onSentMessage} webRTCHandler={webRTCHandler} 
        userLoginData={userLoginData} currentChannel={currentChannelData}/>
      }
      </View>
    </View>
  );
}

const styles = StyleSheet.create({

  loginText: {
    fontSize: 22,
    verticalAlign: 'middle',
    color: 'black',
    paddingLeft: 10,
    paddingBottom: 0,
    paddingRight: 10,
    width: '70%',
    textAlign: 'left',
    backgroundColor: 'aqua',
  },
  chatBodyContainer: {
    flex: 1,
    flexDirection: 'column',
    width: '100%',
    backgroundColor: 'aqua',
    paddingTop: 25,
  },
  titleContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    width: '100%',
    backgroundColor: 'aqua',
  },
  callWindowActions: {
    width: '30%',
    paddingLeft: 10,
    paddingBottom: 0,
    paddingRight: 10,
    flexDirection: 'row',

    justifyContent: 'space-evenly',
    alignItems: 'center',

    backgroundColor: 'white',
    verticalAlign: 'middle',
    borderWidth: 2,
    borderRadius: 40,
    borderTopRightRadius: 0,
    borderBottomRightRadius: 0,
    borderBottomLeftRadius: 0,
    borderColor: 'white',
    height: 100,
  },
  chatWindow: {
    flex: 8,
    height: '100%',
    backgroundColor: 'white',
  },
  chatBox: {
    width: '100%',
    height: 60,
  },
});
