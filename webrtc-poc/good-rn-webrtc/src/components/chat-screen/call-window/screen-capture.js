import { NativeModules } from 'react-native';

const { ScreenCapture } = NativeModules;

export const startScreenCapture = () => {
  return ScreenCapture.startScreenCapture();
};
