import { Tabs } from 'expo-router';
import React, { useEffect } from 'react';

import { TabBarIcon } from '../../src/components/navigation/TabBarIcon';
import { useColorScheme } from '@/src/hooks/useColorScheme';

import { useDispatch } from 'react-redux';
import { setWebRTCHandler } from '@/src/redux/actions/call-action';

import WebRTCHandler  from '@/src/libs/webrtc/WebRTCHandler';

export default function TabLayout() {
  const colorScheme = useColorScheme();

  const dispatch = useDispatch();
  
  useEffect(() => {
        // setup webrtc handler
    // create the singleton webRTCHandler
    const RTCHandler = WebRTCHandler.getInstance(
      undefined,
      undefined,
    );

    if (RTCHandler === null || RTCHandler === undefined) {
      console.error('FATAL: WebRTC handler not initialized');
      return;
    }

    dispatch(setWebRTCHandler(RTCHandler) as any);
  }, []);

  return (
    <Tabs
      screenOptions={{
        tabBarActiveTintColor: 'light',
        headerShown: false,
        tabBarStyle: {
          height: 70, // Adjust the height as needed
          paddingBottom:10,
        },
        tabBarLabelStyle: {
          fontSize: 16, // Adjust the size as needed
          fontWeight: 'bold', // Make the text bold
          flexWrap: 'wrap', // Allow the text to wrap\
        },
      }}>
      <Tabs.Screen
        name="index"
        options={{
          title: 'Login',
          tabBarIcon: ({ color, focused }) => (
            <TabBarIcon name={focused ? 'log-in' : 'log-in-outline'} color={color} />
          ),
        }}
      />
      <Tabs.Screen
        name="YourChannels" 
        options={{
          title: 'Your Channels',
          tabBarIcon: ({ color, focused }) => (
            <TabBarIcon name={focused ? 'people-sharp' : 'people-outline'} color={color} />
          ),
        }}

      />
      <Tabs.Screen
        name="ActiveChatWindow"
        options={{
          title: 'Active Chat',
          tabBarIcon: ({ color, focused }) => (
            <TabBarIcon name={focused ? 'chatbubbles' : 'chatbubbles-outline'} color={color} />
          ),
        }}
      />
    </Tabs>
  );
}
