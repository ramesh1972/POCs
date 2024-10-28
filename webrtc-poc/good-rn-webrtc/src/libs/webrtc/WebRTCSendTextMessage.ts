import WebRTCCallServiceFacade from './core/WebRTCCallServiceFacade';

import { WebRTCDataChannelLabel } from './models/DataChannelLabel'
import { ChannelMessage, ChannelMessageType } from './models/ChannelMessage';

// internal class to send a text message to a WebRTC connection
// use WebRTCHandler to send a video message that in turn uses this object to send a text message
class WebRTCSendTextMessage {
  webRTCCallServiceFacade: WebRTCCallServiceFacade;

  constructor(webRTCCallServiceFacade: WebRTCCallServiceFacade) {
    this.webRTCCallServiceFacade = webRTCCallServiceFacade;
  }

  public async StartConnection() {
    if (this.webRTCCallServiceFacade === null || this.webRTCCallServiceFacade === undefined) {
      console.error('Call service facade not initialized');
      return false;
    }

    return await this.webRTCCallServiceFacade.StartConnection();
  }

  public StopConnection() {
    if (this.webRTCCallServiceFacade === null) {
      console.log('WARN: Call service not initialized');
      return true;
    }

    console.log('StopConnection: disconnecting');

    return this.webRTCCallServiceFacade?.disconnect();
  }
  
  public async SendMessage(newChatMessage: string) {
    if (newChatMessage === null || newChatMessage === undefined || newChatMessage === '')
      return null;

    newChatMessage = newChatMessage.trim();

    console.log('-------------> Sending message:', newChatMessage);

    let callServiceFacade = this.webRTCCallServiceFacade;
    if (callServiceFacade === null || callServiceFacade === undefined) {
      console.error('Call service facade not found');
      return null;
    }

    callServiceFacade.SendMessage(newChatMessage);
    console.log('---------------> Sent message in Component:', newChatMessage);

    const dataChannelLabel = callServiceFacade.GetChannel();
    const msg: ChannelMessage = { type: ChannelMessageType.Text, dataChannel: dataChannelLabel!, channelmessage: newChatMessage, userName: '', timestamp: new Date().toLocaleTimeString(), direction: 'out' };

    return msg;
  }
}

export default WebRTCSendTextMessage;