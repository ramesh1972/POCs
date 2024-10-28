import React from "react";
import { Text, Platform } from "react-native";
import PropTypes from "prop-types";
import { FontTypes, hp } from "../constants";
import { getFontFamily } from "../utils/utils";
import { useTheme } from "@react-navigation/native";

export default function AppText(props) {
  const { colors } = useTheme();

  const {
    fontType = FontTypes.regular,
    size = hp("1.74%"),
    color = colors.white,
    style = null,
    numberOfLines = null,
  } = props;
  return (
    <Text
      numberOfLines={numberOfLines}
      {...props}
      style={[
        props.style,
        style,
        {
          fontSize: size,
          color: color,
          fontFamily: getFontFamily(fontType),
          marginTop: Platform.OS === "ios" ? 0 : -(size / (size / 2)),
        },
      ]}
    />
  );
}

AppText.propTypes = {
  size: PropTypes.number,
  numberOfLines: PropTypes.number,
  color: PropTypes.string,
  fontType: PropTypes.oneOf([
    FontTypes.bold,
    FontTypes.medium,
    FontTypes.regular,
  ]),
};
