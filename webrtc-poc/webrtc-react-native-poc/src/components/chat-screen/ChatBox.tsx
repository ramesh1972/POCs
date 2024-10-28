import React, { Component } from 'react';
import { View, TextInput, Button, StyleSheet } from 'react-native';
import { connect } from 'react-redux';

import Ionicons from '@expo/vector-icons/Ionicons';
import FontAwesome from '@expo/vector-icons/FontAwesome'; // Changed from Ionicons to FontAwesome

import colabLog from '@/src/libs/webrtc/utils/colabLog';

import { ChannelMessage } from '@/src/libs/webrtc/models/ChannelMessage';
import WebRTCHandler from '@/src/libs/webrtc/WebRTCHandler';
import { mediaDevices } from 'react-native-webrtc';
import { WebRTCDataChannelType, WebRTCDataChannelStreamType, WebRTCDataChannelLabel } from '@/src/libs/webrtc/models/DataChannelLabel';
import { setCurrentChannel } from '@/src/redux/actions/user-action';

interface Props {
  onSentMessage: (dataChannelName: string, msg: ChannelMessage) => void;

  // from store
  webRTCHandler: any;
  callInfo: any;
  currentChannel: any;
  userLoginData: any;
}

interface ChatBoxState {
  connectionDC: WebRTCDataChannelLabel | null;
  newChatMessage: string;
  recordingURL: string;
  toggleActions: boolean;
}

class ChatBox extends Component<Props, ChatBoxState> {
  constructor(props: Props) {
    super(props);
    this.state = {
      newChatMessage: '',
      recordingURL: '',
      toggleActions: false,
      connectionDC: null
    };

    this.sendMessage = this.sendMessage.bind(this);
    this.handleMessageChange = this.handleMessageChange.bind(this);
  }

  // audio & video messaging
  isVideoMessage: boolean = false;
  isAudioMessage: boolean = false;
  isTextMessage: boolean = true;
  isVideoRecordingOn: boolean = false;
  isAudioRecordingOn: boolean = false;

  isVideoInputVisible: boolean = false;
  isAudioInputVisible: boolean = false;

  // main connexion
  isConnectionOn: boolean = false;

  // image capture
  isImageCaptureVisible: boolean = false;

  componentDidMount(): void {
    console.log('ChatBox mounted');

    //this.handleConnectionByIntiator();
  }

  // IMPORTANT: handle setup and call
  async handleConnectionByIntiator() {
    console.log(this.props.userLoginData?.name, ' --> ChatBox: Starting ');

    if (this.props.webRTCHandler === null) {
      console.error('WebRTC handler not found');
      return false;
    }

    if (this.props.currentChannel === null || this.props.currentChannel === undefined) {
      console.error('current channel is null at initiator end');
      return false;
    }

    // create the connection channel label
    console.log(this.props.userLoginData?.name, ' --> ChatBox: You are the initiator of the call');

    // create this user's side of the peer connection
    // NOTE: the data used here is from callInfo which is set on call button click in chat header component
    await this.props.webRTCHandler?.ConnectDataChannel(WebRTCDataChannelType.P2P, 1,
      this.props.userLoginData, this.props.currentChannel, WebRTCDataChannelStreamType.NONE).then(async (connectionDataChannelLabel: WebRTCDataChannelLabel) => {
        if (connectionDataChannelLabel === null || connectionDataChannelLabel === undefined) {
          console.error('ChatBox: connectionDataChannelLabel is null');
          return false;
        }
        else {
          colabLog(connectionDataChannelLabel, 'ChatBox: connectionDataChannelLabel', connectionDataChannelLabel.dataChannelName);
          colabLog(connectionDataChannelLabel, 'ChatBox: from User', connectionDataChannelLabel.fromChannel?.id);

          // set it prt of the state used for stopping the 
          this.setState({ connectionDC: connectionDataChannelLabel });

          if (this.props.webRTCHandler.IsConnected(connectionDataChannelLabel)) {
            console.log('ChatBox: Connection already exists');
            return true;
          }

          // init the event handlers for peer connection callbacks
          await this.props.webRTCHandler?.Init(true, connectionDataChannelLabel);

          // set the initiate  callback which is called when the other peer accepts the connection call
          this.props.webRTCHandler?.SetStartConnectionCallBack(connectionDataChannelLabel, this.initiateConnectionHandler.bind(this));

          // this callback will be called when peer sends call stopped message
          this.props.webRTCHandler?.SetStopConnectionCallBack(connectionDataChannelLabel, this.CloseConnection.bind(this));

          // send to the other peer that the call is initiated on my end
          this.props.webRTCHandler?.SendInitiateConnectionMessage(connectionDataChannelLabel);

          colabLog(connectionDataChannelLabel, 'ChatBox: completed handleConnectionByIntiator');

          return true;
        }
      }).catch((error: any) => {
        console.error('ChatBox: ConnectDataChannel failed', error);
        console.error('ChatBox: Video streaming setup failed at the initiator end');
        return false;
      });
  }


  async initiateConnectionHandler(connectionDataChannelLabel: WebRTCDataChannelLabel) {
    colabLog(connectionDataChannelLabel, ' --> ChatBox: In initiateConnectionHandler');

    await this.initiateConnection(connectionDataChannelLabel).then((isSuccess) => {
      if (isSuccess) { }
      console.log(connectionDataChannelLabel.toChannel?.name, ' --> ChatBox: initiateConnectionHandler: initiated ');

      this.props.webRTCHandler?.SendConnectionStartedMessage(connectionDataChannelLabel);
    }).catch((error: any) => {
      console.error('ChatBox: initiateConnectionHandler failed', error);
    });
  }

  // initiate 
  async initiateConnection(connectionDataChannelLabel: WebRTCDataChannelLabel) {
    colabLog(connectionDataChannelLabel, ' -- >ChatBox: In initiateConnection');

    colabLog(connectionDataChannelLabel, 'ChatBox: initiateConnection: connection', this.isConnectionOn);

    if (this.isConnectionOn) {
      console.log('ChatBox: Video streaming already on');
      return false;
    }

    if (connectionDataChannelLabel === null || connectionDataChannelLabel === undefined) {
      console.error('ChatBox: connectionDataChannelLabel is null');
      return false;
    }

    console.debug(connectionDataChannelLabel.toChannel?.name, ' --> ChatBox: initiateConnection: connectionDataChannelLabel', connectionDataChannelLabel?.dataChannelName);

    // !!! initiate 
    const isSuccess = await this.props.webRTCHandler?.StartConnection(connectionDataChannelLabel);
    console.log(connectionDataChannelLabel.toChannel?.name, ' --> ChatBox: initiateConnection: StartConnection', isSuccess);

    this.isConnectionOn = true;

    console.log(connectionDataChannelLabel.toChannel?.name, 'Video streaming setup completed!!!!');

    return true;
  }

  CloseConnection(dataChannelLabel: WebRTCDataChannelLabel, force: boolean) {
    console.log('ChatBox: closing connection');
    this.props.webRTCHandler?.StopConnection();

    if (this.isConnectionOn) {
      this.props.webRTCHandler?.SendConnectionStoppedMessage(dataChannelLabel);
      this.isConnectionOn = false;
    }
  }

  toggleActionPanel() {
    this.setState({ toggleActions: !this.state.toggleActions });
  }

  // -------------------------------------------------------------------------------------
  // audio & video messaging
  public async handleVideoMessaging() {
    this.isVideoMessage = true;
    this.isAudioMessage = false;

    this.isAudioInputVisible = false;
    this.isVideoInputVisible = true;

    /*     const videoElement = this.el.nativeElement.querySelector('.send-video-input') as HTMLVideoElement;
    
        if (this.isVideoRecordingOn) {
          console.log('Stopping video messaging');
          await this.props.webRTCHandler?.StopVideo().then((url) => {
            this.setState({ recordingURL: url });
          });
        }
     */
    console.log('Starting video messaging');

    this.isVideoMessage = true;
    this.isAudioMessage = false;
    this.isVideoRecordingOn = true;
    this.isAudioRecordingOn = false;

    //this.props.webRTCHandler.StartVideoMessaging(videoElement);
  }

  public async handleAudioMessaging() {
    this.isVideoMessage = false;
    this.isAudioMessage = true;

    this.isAudioInputVisible = true;
    this.isVideoInputVisible = false;

    /* let audioElement = this.el.nativeElement.querySelector('.send-audio-input') as HTMLAudioElement;

    if (this.isAudioRecordingOn) {
      console.log('Stopping audio messaging');
      let url = await this.props.webRTCHandler.StopAudio().then((url) => {
        this.recordingURL = url;
      });

      if (audioElement) { this.renderer.removeChild(this.el.nativeElement, audioElement); } */
    //}

    console.log('Starting audio messaging');

    this.isVideoMessage = false;
    this.isAudioMessage = true;
    this.isVideoRecordingOn = false;
    this.isAudioRecordingOn = true;
    this.setState({ recordingURL: '' });
    //this.props.webRTCHandler.StartAudioMessaging(audioElement);
  }

  async sendMessage() {
    console.log('++++++++++++++++++++++++++++++++++sending messge');
    let sentMsg: ChannelMessage | null | undefined;

    if (this.isTextMessage === false && this.isVideoMessage === false && this.isAudioMessage === false) {
      console.error('No message type selected');
      return;
    }

    console.log('sendMessage 1');
    this.isVideoInputVisible = false;
    this.isAudioInputVisible = false;

    // if video
    if (this.isVideoMessage) {
      console.log('----------------> Sending video message');
      sentMsg = await this.props.webRTCHandler!.SendVideoMessage(this.state.connectionDC!);
      console.log('----------------> Sent video message', sentMsg?.channelmessage);
    }
    else if (this.isAudioMessage) { // if audio
      console.log('----------------> Sending audio message');
      sentMsg = await this.props.webRTCHandler!.SendAudioMessage(this.state.connectionDC!); // Await the promise
      console.log('----------------> Sent audio message', sentMsg?.channelmessage);
    }

    console.log('sendMessage 2');

    // if there was a text message add it to the global message collection
    console.log('sendMessage 3: ', this.state.newChatMessage);

    const newTextMessage = this.state.newChatMessage.trim();
    console.log('-------------> Sending message:', newTextMessage);

    if (newTextMessage !== null && newTextMessage !== undefined && newTextMessage !== '') {
      sentMsg = await this.props.webRTCHandler!.SendTextMessage(this.state.connectionDC!, newTextMessage);

      this.isAudioMessage = false;
      this.isVideoMessage = false;
      this.setState({ newChatMessage: '' });
    }

    if (sentMsg === null || sentMsg === undefined) {
      console.error('Failed to send message');
      return;
    }

    console.log('sendMessage 4 channel', this.state.connectionDC?.dataChannelName!);
    this.props.onSentMessage(this.state.connectionDC?.dataChannelName!, sentMsg);
    console.log('sendMessage 5');
  }

  handleMessageChange = (text: string) => {
    this.setState({ newChatMessage: text });
    console.log('-------------> Message changed:', text);
  };
 
  render() {
    const { newChatMessage } = this.state;

    return (
      <View style={styles.chatBoxContainer}>
        <View style={styles.chatBox}>
          {!this.state.toggleActions && (
            <FontAwesome name="plus" size={24} color="black" onPress={() => this.toggleActionPanel()} />
          )}

          {this.state.toggleActions && (
            <View style={{ flex: 1, flexDirection: 'row', height: '100%', alignItems: 'center' }}>
              <FontAwesome name="minus" size={24} color="black" onPress={() => this.toggleActionPanel()} />

              <View style={styles.chatBoxActions}>
                <Ionicons name="attach" size={24} color="blue" />
                <Ionicons name="mic" size={24} color="blue" style={{ marginRight: 3 }} />
                <Ionicons name="videocam" size={24} color="blue" style={{ marginRight: 9 }} />
                <FontAwesome name="camera" size={20} color="blue" style={{ marginRight: 5 }} onPress={() => console.log('Screen share icon tapped')} />
              </View>
            </View>
          )}

          <TextInput
            style={styles.messageInput}
            value={newChatMessage}
            placeholder="Type your message..."
            onChangeText={this.handleMessageChange}
          />
          <View style={styles.chatButtons}>
            <Button title="Send" onPress={this.sendMessage} />
          </View>
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  chatBoxContainer: {
    padding: 10,
    backgroundColor: 'lightgray',
  },
  chatBox: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  chatBoxActions: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'space-evenly',
    alignItems: 'center',
    height: '100%',
    verticalAlign: 'middle',
    alignContent: 'center',
    marginLeft: 10,
    padding: 0,
    borderWidth: 1,
    borderRadius: 6,
    borderColor: '#ccc',
    backgroundColor: 'white',
  },

  messageInput: {
    flex: 1,
    borderWidth: 1,
    borderColor: '#ccc',
    borderRadius: 6,
    padding: 10,
    marginRight: 10,
    marginLeft: 10,
    backgroundColor: 'white',
  },
  chatButtons: {
    justifyContent: 'center',
  },
  sendButton: {
    justifyContent: 'center',
  },
});

// Map Redux state to component props
const mapStateToProps = (state: any) => ({
  callInfo: state.callState.callInfo,
});

export default connect(mapStateToProps)(ChatBox);
