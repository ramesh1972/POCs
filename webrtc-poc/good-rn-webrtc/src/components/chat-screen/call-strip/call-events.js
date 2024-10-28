import { WebRTCChannelType } from "@/src/libs/webrtc/models/Channel";
import { WebRTCDataChannelType } from "@/src/libs/webrtc/models/DataChannelLabel";
import { WebRTCDataChannelStreamType } from "@/src/libs/webrtc/models/DataChannelLabel";

export const CALL_EVENTS = {
    outgoing: "outgoing",
    incoming: "incoming",
    activeconnected: "activeconnected",
    activenotconnected: "activenotconnected",
    reconnecting: "reconnecting",
    disconnecting: "disconnecting",
    closed: "closed",
};

export function getOutGoingCallInfo(currentChannel, userLoginData, currentColleague, dataChannelType, callType) {
    let callInfo = {
        event: CALL_EVENTS.outgoing,
        callType: callType,
        tenantId: 1, // TODO change this to org id
        channelUrl: '',
        dataChannelType: dataChannelType,
        fromChannel: {
            id: userLoginData?.id, type: WebRTCChannelType.USER,
            name: userLoginData?.name, userpicture: ''
        }, // TODO change this for GROUP to support group call as well
        toChannel: {
            id: currentColleague?.id, type: WebRTCChannelType.USER,
            name: currentColleague?.name, userpicture: ''
        },
        members: currentChannel?.members !== undefined ? currentChannel?.members : null,
    };

    return callInfo;
}

export function getIncomingCallInfo(dataChannel) {
    if (dataChannel === null || dataChannel === undefined) {
        console.error('getIncomingCallInfo dataChannel is null');
        return null;
    }

    // set the call event to incoming
    let incomingCallingInfo = {};
    incomingCallingInfo.event = CALL_EVENTS.incoming;
    incomingCallingInfo.tenantId = 1; // TODO change this to org id
    incomingCallingInfo.dataChannelType = dataChannel?.dataChannelType; //USER or GROUP or BROADCAST etc    
    incomingCallingInfo.callType = dataChannel?.streamType; // AUDIO or VIDEO

    // swap the from and to channels
    incomingCallingInfo.fromChannel = dataChannel?.toChannel;
    incomingCallingInfo.toChannel = dataChannel?.fromChannel;

    incomingCallingInfo.members = dataChannel?.members !== undefined ? dataChannel?.members : null;

    return incomingCallingInfo;
}

export function getActiveCallInfo(callInfo) {
    if (callInfo === null || callInfo === undefined) {
        console.error('getActiveCallInfo callInfo is null');
        return null;
    }

    let closedCallingInfo = {};
    closedCallingInfo.event = CALL_EVENTS.activeconnected;
    closedCallingInfo.tenantId = 1; // TODO change this to org id
    closedCallingInfo.dataChannelType = callInfo?.dataChannelType; //USER or GROUP or BROADCAST etc
    closedCallingInfo.callType = callInfo?.callType; // AUDIO or VIDEO

    closedCallingInfo.fromChannel = callInfo?.fromChannel;
    closedCallingInfo.toChannel = callInfo?.toChannel;

    closedCallingInfo.members = callInfo?.members !== undefined ? callInfo?.members : null;

    return closedCallingInfo;
}

export function getDisconnectingCallInfo(callInfo) {
    if (callInfo === null || callInfo === undefined) {
        console.warn('getDisconnectingCallInfo callInfo is null');
        return null;
    }

    console.log('getDisconnectingCallInfo callInfo', callInfo.event);
    if (callInfo.event === CALL_EVENTS.disconnecting || callInfo.event === CALL_EVENTS.closed) {
        console.warn('getDisconnectingCallInfo callInfo is already closed');
        return callInfo;
    }

    if (callInfo.event === CALL_EVENTS.activeconnected || callInfo.event === CALL_EVENTS.activenotconnected || callInfo.event === CALL_EVENTS.reconnecting) {
        callInfo.event = CALL_EVENTS.disconnecting;
        return callInfo;
    }

    return null;
}

export function getClosedCallInfo(callInfo) {
    if (callInfo === null || callInfo === undefined) {
        console.error('getClosedCallInfo callInfo is null');
        return null;
    }

    let closedCallingInfo = {};
    closedCallingInfo.event = CALL_EVENTS.closed;
    closedCallingInfo.tenantId = 1; // TODO change this to org id
    closedCallingInfo.dataChannelType = callInfo?.dataChannelType; //USER or GROUP or BROADCAST etc
    closedCallingInfo.callType = callInfo?.streamType; // AUDIO or VIDEO

    closedCallingInfo.fromChannel = callInfo?.fromChannel;
    closedCallingInfo.toChannel = callInfo?.toChannel;

    closedCallingInfo.members = callInfo?.members !== undefined ? callInfo?.members : null;

    return closedCallingInfo;
}