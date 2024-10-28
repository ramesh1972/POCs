import React, { useState } from "react";
import {
  ActivityIndicator,
  Pressable,
  TouchableOpacity,
  View,
  Image
} from "react-native";
import PropTypes from "prop-types";
import { Colors, Icons, Images, hp } from "../constants";
import FastImage from "react-native-fast-image";
import AppText from "./app-text";

export default function AppImage({
  source,
  size,
  isRounded,
  isClickable = true,
  onPress,
  style,
  borderRadius,
  height = size,
  width = size,
  resizeMode = "contain",
  isNoPreviewTitle = false,
  noPreviewIconSize = hp("3%"),
  noPreviewTitleSize = hp("1.74%"),
  isLoadingVisible = true,
  tintColor,
  onLongPress = () => {},
  containerStyle,
  ...props
}) {
  const [isImageLoading, setIsImageLoading] = useState(false);
  const [isImageLoadingError, setIsImageLoadingError] = useState(false);

  const onLoadStart = () => {
    if (source?.uri && isLoadingVisible) {
      setIsImageLoading(true);
    }
  };

  const onLoadEnd = () => {
    setIsImageLoading(false);
  };

  const onImageLoadingError = () => {
    setIsImageLoading(false);
    if (source?.uri) {
      setIsImageLoadingError(true);
    }
  };

  const onLoad = () => {
    setIsImageLoading(false);
    setIsImageLoadingError(false);
  };

  return (
    <Pressable
      disabled={isClickable ? false : true}
      onPress={onPress}
      onLongPress={onLongPress}
      style={containerStyle}
    >
      <FastImage
        {...props}
        onLoadStart={onLoadStart}
        onLoadEnd={onLoadEnd}
        onError={onImageLoadingError}
        onLoad={onLoad}
        style={[
          style,
          {
            width: width,
            height: height,
            borderRadius: borderRadius
              ? borderRadius
              : isRounded
              ? size / 2
              : 0,
          },
        ]}
        tintColor={style?.tintColor || tintColor}
        resizeMode={resizeMode}
        source={
          source?.uri
            ? { uri: source?.uri, priority: FastImage.priority.high }
            : source
        }
      >
        {isLoadingVisible ? (
          <View
            style={{
              flexGrow: 1,
              alignItems: "center",
              justifyContent: "center",
            }}
          >
            {isImageLoading ? (
              <ActivityIndicator size={"small"} color={Colors.green} />
            ) : (
              <>
                {isImageLoadingError ? (
                  <View
                    style={{ alignItems: "center", justifyContent: "center" }}
                  >
                    <AppImage
                      size={noPreviewIconSize}
                      source={Icons.no_preview}
                      resizeMode={"contain"}
                    />
                    {isNoPreviewTitle ? (
                      <AppText
                        size={noPreviewTitleSize}
                        color={Colors.grey}
                        style={{ paddingTop: hp("1%") }}
                      >
                        {"No preview available"}
                      </AppText>
                    ) : null}
                  </View>
                ) : null}
              </>
            )}
          </View>
        ) : (
          <>{props.children}</>
        )}
      </FastImage>
    </Pressable>
  );
}

AppImage.propTypes = {
  style: PropTypes.any,
  source: PropTypes.any,
  size: PropTypes.any,
  borderRadius: PropTypes.any,
  isRounded: PropTypes.bool,
  isClickable: PropTypes.bool,
  onPress: PropTypes.func,
};
