import { View, Image, Text, StyleSheet, FlatList, TouchableOpacity, Platform, PermissionsAndroid } from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { useNavigation } from '@react-navigation/native';
import { useSelector, useDispatch } from 'react-redux';

import { ThemedText } from '@/src/components/ThemedText';
import { ThemedView } from '@/src/components/ThemedView';
import { useEffect, useState } from 'react';

import { setCurrentChannel } from '@/src/redux/actions/user-action';

import { Channel } from '@/src/libs/webrtc/models/Channel';
import getChannels from '@/src/store/channelList';

export default function YourChannels() {

  const [selectedUser, setSelectedUser] = useState<Channel>();
  const [channnels, setChannels] = useState<Channel[]>([]);
  const [loggedInText, setloggedInText] = useState('Logged in as: ');

  const { userLoginData } = useSelector((state: any) => state.userState);

  console.log('YourChannels userLoginData:', userLoginData);

  const nav = useNavigation();
  const dispatch = useDispatch();

  // init
  useEffect(() => {
    const chnls = getChannels().filter((channel: Channel) => channel.id !== userLoginData?.id);
    setChannels(chnls);
    setSelectedUser({} as Channel);""
    setloggedInText('Hi ' + userLoginData?.name + "! Select the User with you would want to Chat with");

  }, [userLoginData]);

  // ---------------------------------------------------------------------------------------
  // events
  function onUserChange(channel: Channel) {
    console.log('OnUserChange channel:', channel);

    setSelectedUser(channel);
    dispatch(setCurrentChannel(channel) as any);

    const tab1: string = 'ActiveChatWindow' as string;
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
        onPress={() => onUserChange(item)}>
        <View style={{ flex: 1, flexDirection: 'row', alignItems: 'center' }}>
          <Text style={styles.channelListItemLabel}>{item.name}</Text>
          <Icon name="keyboard-arrow-right" size={50} color="gray" />
        </View>
      </TouchableOpacity>
    );
  };

  return (
    <ThemedView style={styles.titleContainer}>
      <ThemedText type="title" style={styles.loginText}>{loggedInText}</ThemedText>
      <View style={styles.channelListContainer}>
        <View style={styles.channelList}>
          <FlatList
            data={channnels}
            keyExtractor={item => item.id}
            renderItem={renderChannelItem}
          />
        </View>
      </View>
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
    paddingTop: 25
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
    width: '90%',
  },
});
