import WebRTCCallServiceFacade from './core/WebRTCCallServiceFacade';
import { WebRTCDataChannelLabel } from './models/DataChannelLabel';

// internal class to start/stop an screen sharing on a WebRTC connection
export default class WebRTCScreenSharing {

  webRTCCallServiceFacade: WebRTCCallServiceFacade | null | undefined = null;
  isScreenSharingOn: boolean = false;
  recordingURL: string = '';

  constructor(webRTCCallServiceFacade: WebRTCCallServiceFacade) {
    this.webRTCCallServiceFacade = webRTCCallServiceFacade;
  }

  public async StartScreenSharing() {
    if (this.webRTCCallServiceFacade === null || this.webRTCCallServiceFacade === undefined) {
      console.error('Call service not initialized');
      return false;
    }

    return await this.webRTCCallServiceFacade.StartScreenSharing();
  }

  public StopScreenSharing() {
    if (this.webRTCCallServiceFacade === null) {
      console.log('WARN: Call service not initialized');
      return true;
    }

    console.log('Stop Screen sharing: disconnecting');

    return this.webRTCCallServiceFacade?.disconnect();
  }
}
