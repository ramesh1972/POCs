import React, { useState } from 'react';
import { View } from 'react-native';
import { useEffect } from 'react';
import { useSelector } from 'react-redux';
import { useDispatch } from 'react-redux';

import {
	CALL_EVENTS, getIncomingCallInfo
} from "../call-strip/call-events";

import CallWindowAudio from './call-window-audio';
import CallWindowVideo from './call-window-video';
import CallWindowScreenShare from './call-window-share-screen';
import { CallStripChat } from '../call-strip';
import CallWindowShareScreen from './call-window-share-screen';

//import { set } from 'lodash';
//import { call } from 'react-native-reanimated';

function CallWindow(props) {
	console.debug('CallWindow props', props);

	// basic props
	const { callInfo, webRTCHandler } = useSelector((state) => state.callState);
	console.debug('CallWindow callInfo', callInfo);
	console.debug('CallWindow webRTCHandler', webRTCHandler);

	// state
	const [isAudioCall, setIsAudioCall] = useState(false);
	const [isVideoCall, setIsVideoCall] = useState(false);
	const [isScreenShare, setIsScreenShare] = useState(false);

	const [inCommingCallInfo, setInCommingCallInfo] = useState(null);
	const [onGoingCallInfo, setOnGoingCallInfo] = useState(null);

	useEffect(() => {
		console.log('CallWindow useEffect init');

		// set callback for receiver to handle incoming call
		if (webRTCHandler !== null && webRTCHandler !== undefined) {
			console.log('CallWindow useEffect setting callback for callReceived');
			webRTCHandler?.SetCallReceivedCallBack(callReceived);
		}

	}, [webRTCHandler, callInfo?.event, callInfo?.callType]);

	// effect actions on change in callInfo
	useEffect(() => {
		console.log('registerProperties callInfo', callInfo);

		if (onGoingCallInfo !== null && onGoingCallInfo !== undefined && onGoingCallInfo.event === CALL_EVENTS.incoming) {
			console.log('registerProperties onGoingCallInfo', onGoingCallInfo);

			console.debug('registerProperties onGoingCallInfo CALL_EVENTS.incoming');

			if (onGoingCallInfo?.callType === 'audio') {
				setIsAudioCall(true);
				setIsVideoCall(false);
			}
			else if (onGoingCallInfo?.callType === 'video') {
				setIsAudioCall(false);
				setIsVideoCall(true);
			}
			else if (onGoingCallInfo?.callType === 'screen') {
				setIsScreenShare(true);
			}
		}
		else if (callInfo === null) {
			console.log('callInfo is null');

			setIsVideoCall(false);
			setIsAudioCall(false);
			setIsScreenShare(false);

			setOnGoingCallInfo(null);
		}
		else if (callInfo.event === CALL_EVENTS.closed) {
			console.log('callInfo is closed');

			setIsAudioCall(false);
			setIsVideoCall(false);
			setIsScreenShare(false);
		}
		else if (callInfo?.event === CALL_EVENTS.outgoing) {
			console.log('callInfo is outgoing');

			if (callInfo?.callType === 'audio') {
				console.log('callInfo is audio call');
				setIsAudioCall(true);
				setIsVideoCall(false);
			}
			else if (callInfo?.callType === 'video') {
				console.log('callInfo is video call');
				setIsAudioCall(false);
				setIsVideoCall(true);
			}
			else if (callInfo?.callType === 'screen') {
				console.log('callInfo is screen share');
				setIsScreenShare(true);
			}

			//setOnGoingCallInfo(callInfo); // initiator of call
		}
	}, [callInfo, onGoingCallInfo]);

	async function callReceived(dataChannel) {
		// do the UI stuff of showing call strip with Accept button in current window or global strip
		console.log(dataChannel?.toChannel?.name, ' --> CallWindow callReceived');

		console.log(dataChannel?.toChannel?.name, ' --> CallWindow callReceived: screen share is set to true');

		// set the call event to incoming
		let callingInfo = getIncomingCallInfo(dataChannel);
		console.log('callReceived callingInfo', callingInfo);

		// trigger useEffect to receive call
		setOnGoingCallInfo(callingInfo); // TODO to see why dipatchCallInfo doesnt' work
	}

	function OnRemoveVideoComponent() {
		console.log('OnRemoveVideoComponent');

		setIsVideoCall(false);
		setOnGoingCallInfo(null);
	}

	function OnRemoveAudioComponent() {
		console.log('OnRemoveAudioComponent');

		setIsAudioCall(false);
		setOnGoingCallInfo(null);
	}

	function OnRemoveScreenShareComponent() {
		console.log('OnRemoveScreenShareComponent');

		setIsScreenShare(false);
		setOnGoingCallInfo(null);
	}

	return (
		<View style={{ width: '100%' }}>
			{(isVideoCall || isAudioCall) && (
				<View style={{ width: '100%' }}>
					<CallStripChat />
					<View style={{ width: '100%', padding: 4, backgroundColor: 'blue' }}>
						{isAudioCall && <CallWindowAudio onGoingCallInfo={onGoingCallInfo} OnRemoveSelf={OnRemoveAudioComponent} />}
						{isVideoCall && <CallWindowVideo onGoingCallInfo={onGoingCallInfo} OnRemoveSelf={OnRemoveVideoComponent} />}
						{isScreenShare && <CallWindowShareScreen onGoingCallInfo={onGoingCallInfo} OnRemoveSelf={OnRemoveScreenShareComponent} />}
					</View>
				</View>
			)
			}
		</View >
	);
}

export default CallWindow;