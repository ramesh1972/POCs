export const getFontFamily = (fontType) => {
    switch (fontType) {
      case FontTypes.bold:
        return "NotoSans-Bold";
  
      case FontTypes.medium:
        return "NotoSans-Medium";
  
      case FontTypes.regular:
        return "NotoSans-Regular";
  
      default:
        return "NotoSans-Regular";
    }
  };
  