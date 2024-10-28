const { ScreenCaptureModule } = ReactNative.NativeModules;

export const startScreenCapture = () => {
  return ScreenCaptureModule.startScreenCapture();
};
