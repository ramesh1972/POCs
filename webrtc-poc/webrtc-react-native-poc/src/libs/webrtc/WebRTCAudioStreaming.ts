import WebRTCCallServiceFacade from './core/WebRTCCallServiceFacade';
import { WebRTCDataChannelLabel } from './models/DataChannelLabel';

// internal class to start/stop an audio stream to a WebRTC connection
// use WebRTCHandler to start/stop an audio stream that in turn uses this object to start/stop an audio stream
export default class WebRTCAudioStreaming {

  webRTCCallServiceFacade: WebRTCCallServiceFacade | null | undefined = null;
  isAudioStreamingOn: boolean = false;
  recordingURL: string = '';

  constructor(webRTCCallServiceFacade: WebRTCCallServiceFacade) {
    this.webRTCCallServiceFacade = webRTCCallServiceFacade;
  }

    async StartAudioStreaming() {
    if (this.webRTCCallServiceFacade === null || this.webRTCCallServiceFacade === undefined) {
      console.error('Call service not initialized');
      return false;
    }

    return await this.webRTCCallServiceFacade.StartAudioStreaming();
  }

  public StopStreaming() {
    if (this.webRTCCallServiceFacade === null) {
      console.log('WARN: Call service not initialized');
      return true;
    }

    console.log('StopStreaming: disconnecting');

    return this.webRTCCallServiceFacade?.disconnect();
  }
}
