import {
  widthPercentageToDP,
  heightPercentageToDP,
} from "react-native-responsive-screen";

import { Colors } from "./colors1";
import { Icons } from "./icons";
import { FontTypes } from "./fonts";
import { Images } from "./images";

const wp =
  widthPercentageToDP("100%") < heightPercentageToDP("100%")
    ? widthPercentageToDP
    : heightPercentageToDP;
const hp =
  widthPercentageToDP("100%") > heightPercentageToDP("100%")
    ? widthPercentageToDP
    : heightPercentageToDP;

const URL_REGEX =
  /((https?:\/\/)|(www\.))[^\/\s?#]+(?:\/[^\/\s?#]+)*(?:\?[^?\s#]*)?(?:#[^\s]*)?/gi;
// /(((https?:\/\/)|(www\.))[^\s]+)/gi;
// /(?:https?:\/\/)?(?:www\.)?[^\s\/]+\.[^\s\/?#]+\b(?:\/[^#]*)?(?:#.*)?/gi;

const MAIL_FORMAT = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
//const PASSWORD_FORMAT = /^([a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]?)*$/;
const PASSWORD_FORMAT =
  ///^(?=.*[a-z])(?=.*[A-Z])(?=.*?[0-9])(?=.*[!@#$%^&*()_+\-=[\]{};':"\\|,.<>/?]).*$/;
  /^(?=.*[a-z])(?=.*[A-Z])(?=.*?[0-9])(?=.*[!@#$%^&*()_+\-=[\]{};':"\\|,.<>/?])[^\s]*$/;
//const validPassword = new RegExp('^(?=.*?[A-Za-z])(?=.*?[0-9]).{8,}$');
const validPassword = new RegExp(
  "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
);
const validNamingConvention = new RegExp("^[a-zA-Z ]*$");
const validLatLon = new RegExp("^-?([1-8]?[1-9]|[1-9]0)\\.{1}\\d{1,6}");
const tokenExpirationThreshold = 3600000; // (60 * 60 sec * 1000milisec)
const OTPTimeout = 120;
const allowedImageExtensions =
  /(\.jpg|\.jpeg|\.png|\.gif|\.webp|\.jfif|\.dng|\.heic|\.tiff|\.tif|\.bmp)$/i;

//1 min = 60000 (1 * 60sec * 1000milisec)
//2 min = 120000 (2 * 60sec * 1000milisec)
//5 min = 300000 (5 * 60sec * 1000milisec)
//30 min = 1800000 (60 * 60 sec * 1000milisec)
//1hr = 3600000 (60 * 60 sec * 1000milisec)

const PLACEHOLDER_ARRAY = [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}];

const SUPPORTED_FILE_EXTENSIONS = [
  ".doc",
  ".docx",
  ".csv",
  ".xls",
  ".xlsx",
  ".pdf",
  ".txt",
  ".ppt",
  ".pptx",
  ".rar",
  ".zip",
];

export {
  wp,
  hp,
  Colors,
  Icons,
  FontTypes,
  Images
};
