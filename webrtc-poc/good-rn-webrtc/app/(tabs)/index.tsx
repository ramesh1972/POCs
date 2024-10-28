import { View, Image, Text, StyleSheet, FlatList, TouchableOpacity, Platform, PermissionsAndroid } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { useDispatch } from 'react-redux';
import notifee from '@notifee/react-native';

import { ThemedText } from '@/src/components/ThemedText';
import { ThemedView } from '@/src/components/ThemedView';
import { useEffect, useState } from 'react';

import { setLoginUserData, setCurrentChannel } from '../../src/redux/actions/user-action';

import { Channel } from '@/src/libs/webrtc/models/Channel';
import getChannels from '../../src/store/channelList';

export default function HomeScreen() {

  const [selectedUser, setSelectedUser] = useState<Channel>();
  const [channnels, setChannels] = useState<Channel[]>([]);
  const [loggedInText, setloggedInText] = useState('Logged in as: ');

  const dispatch = useDispatch();
  const nav = useNavigation();

  function requestPermissions() {
    if (Platform.OS === 'android') {
      PermissionsAndroid.requestMultiple([
        PermissionsAndroid.PERMISSIONS.CAMERA,
        PermissionsAndroid.PERMISSIONS.RECORD_AUDIO,
        PermissionsAndroid.PERMISSIONS.SYSTEM_ALERT_WINDOW
      ]);
    }
  }

  function registerScreenShare() {
    notifee.registerForegroundService(notification => {
      return new Promise(() => {

      });
    });
  }

  // init
  useEffect(() => {
    requestPermissions();
    setChannels(getChannels());
    registerScreenShare();
  }, []);

  useEffect(() => {
    // Code to run when selectedUser changes
    console.log('Selected user changed:', selectedUser);
    // Add any refresh logic here, if necessary
  }, [selectedUser]); // This useEffect runs whenever selectedUser changes

  // ---------------------------------------------------------------------------------------
  // events
  function onChannelChange(channel: Channel) {
    console.log('OnChannelChange channel:', channel);

    setSelectedUser(channel);
    setloggedInText('Logged in as: ' + channel.name);

    dispatch(setLoginUserData(channel) as any);
    dispatch(setCurrentChannel(null) as any);

    const tab1: string = 'YourChannels' as string;
    nav.navigate(tab1 as never);
  }

  function renderChannelItem(itemA: any) {
    const item = itemA.item as Channel;
    console.log('renderChannelItem item:', item);

    return (
      <TouchableOpacity
        style={[
          styles.channelListItem,
          {
            backgroundColor:
              selectedUser && item.name === selectedUser.name
                ? 'lightgray'
                : 'lightgoldenrodyellow',
          },
        ]}
        onPress={() => onChannelChange(item)}>
        <Text style={styles.channelListItemLabel}>{item.name}</Text>
      </TouchableOpacity>
    );
  };

  return (
    <ThemedView style={styles.titleContainer}>
      <ThemedText type="title" style={styles.loginText}>Mimic Login by Clicking on one of listed Users below</ThemedText>
      <View style={styles.channelListContainer}>
        <View style={styles.channelList}>
          <FlatList
            data={channnels}
            keyExtractor={item => item.id}
            renderItem={renderChannelItem}
          />
        </View>
      </View>
      <ThemedText style={styles.loginText}>{loggedInText}</ThemedText>
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  loginText: {
    fontSize: 24,
    verticalAlign: 'middle',
    paddingRight: 20,
    color: 'black',
    padding: 10,
    width: '100%',
    textAlign: 'center',
    backgroundColor: 'aqua',
    borderWidth: .5,
    borderColor: 'rgba(124, 124, 124, .8)',

  },
  titleContainer: {
    flex: 1,
    flexDirection: 'column',
    alignItems: 'center',
    paddingTop: 25,
  },
  channelListContainer: {
    flex: 1,
    flexDirection: 'row',
  },
  channelList: {
    flex: 1,
    flexDirection: 'column',
  },
  channelListLabel: {
    color: '#333',
    fontWeight: 'bold',
    paddingLeft: 10,
    paddingRight: 10,
    paddingTop: 10,
  },
  channelListItem: {
    backgroundColor: 'rgba(0, 0, 255, 0.8)',
    cursor: 'pointer',
    padding: 8,
    height: 80,
    verticalAlign: 'middle',
    justifyContent: 'center',
    borderWidth: 2,
    borderColor: 'rgba(124, 124, 124, .5)',
  },
  channelListItemLabel: {
    color: 'black',
    fontSize: 27,
  },
});
