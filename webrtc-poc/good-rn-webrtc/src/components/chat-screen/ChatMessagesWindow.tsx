import React, { Component } from 'react';
import { View, Text, StyleSheet, ScrollView } from 'react-native';

import { ChannelMessage } from '@/src/libs/webrtc/models/ChannelMessage';

import CallWindow from './call-window/call-window';
import WebRTCHandler from '@/src/libs/webrtc/WebRTCHandler';

import { useState } from 'react';

interface ChatWindowProps {
  dataChannelName: string;
  chatMessages: ChannelMessage[];
  webRTCHandler: WebRTCHandler;
  newMessagesCount: number;
}

interface ChatWindowState {
  chatMessagesState: ChannelMessage[] | null;
}

class ChatMessagesWindow extends Component<ChatWindowProps, ChatWindowState> {
  constructor(props: ChatWindowProps) {
    super(props);

    console.log('ChatMessagesWindow props:', props);

    const msgs = props.webRTCHandler.GetChannelMessages(props.dataChannelName);
    this.state = {
      chatMessagesState: msgs,
    };

    //this.forceUpdate();
  } 

  
  render() {
    const { chatMessages } = this.props;
    if (!chatMessages) {
      return <Text>No messages</Text>;
    }

    return (
      <ScrollView contentContainerStyle={styles.chatWindow}>
        <CallWindow />

        {this.props.chatMessages!.map((message, index) => (
          <View key={index} style={styles.messageContainer}>
            {message.type === 'text' && (
              <View style={{ alignItems: message.direction === 'in' ? 'flex-start' : 'flex-end' }}>
                {message.direction === 'in' ? (
                  <View style={styles.messageReceived}>
                    <Text>{message.channelmessage}</Text>
                    <Text style={[styles.messageTime, { textAlign: 'left' }]}>{message.timestamp}</Text>
                  </View>
                ) : (
                  <View style={styles.messageSent}>
                    <Text style={styles.messageSentText}>{message.channelmessage}</Text>
                    <Text style={[styles.messageTime, { textAlign: 'right' }]}>{message.timestamp}</Text>
                  </View>
                )}
              </View>
            )}
          </View>
        ))}
      </ScrollView>
    );
  }
}

const styles = StyleSheet.create({
  chatWindow: {
    flex: 1,
    flexDirection: 'column',
    padding: 10,
  },
  messageContainer: {
    flex: 1,
    flexDirection: 'column',
    marginVertical: 5,
  },
  messageReceived: {
    backgroundColor: '#e1ffc7',
    padding: 10,
    borderRadius: 5,
  },
  messageSent: {
    backgroundColor: '#d1e7ff',
    padding: 10,
    borderRadius: 5,
  },
  messageSentText: {
    color: '#000',
  },
  messageTime: {
    fontSize: 10,
    marginTop: 5,
  },
});

export default ChatMessagesWindow;
