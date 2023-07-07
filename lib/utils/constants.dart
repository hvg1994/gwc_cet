

import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';


const gPrimaryColor = Color(0xff4E7215);

// const gsecondaryColor = Color(0xffC10B02);
// const gsecondaryColor = Color(0xffD10034);
const gsecondaryColor = Color(0xffEE1004);

const gMainColor = Color(0xffC7A102);
const gGreyColor = Color(0xff707070);

const gTextColor = Color(0xff000000);
const gWhiteColor = Color(0xffFFFFFF);
const gHintTextColor = Color(0xff676363);
const kLineColor = Color(0xffB9B4B4);
const gBgColor = Color(0xffFAFAFA);



const String kFontMedium = 'GothamMedium';
const String kFontBook = 'GothamBook';
const String kFontBold = 'GothamBold';

const kBottomSheetHeadYellow = Color(0xffFFE281);
const kBottomSheetHeadGreen = Color(0xffA7C652);
const kBottomSheetHeadCircleColor = Color(0xffFFF9F8);

double bottomSheetHeadingFontSize = 12.sp;
String bottomSheetHeadingFontFamily = kFontBold;

double bottomSheetSubHeadingXLFontSize = 12.sp;
double bottomSheetSubHeadingXFontSize = 11.sp;
double bottomSheetSubHeadingSFontSize = 10.sp;
String bottomSheetSubHeadingBoldFont = kFontBold;
String bottomSheetSubHeadingMediumFont = kFontMedium;
String bottomSheetSubHeadingBookFont = kFontBook;

const bsHeadPinIcon = "assets/images/bs-head-pin.png";
const bsHeadBellIcon = "assets/images/bs-head-bell.png";
const bsHeadBulbIcon = "assets/images/bs-head-bulb.png";
const bsHeadStarsIcon = "assets/images/bs-head-stars.png";



var headingFontSize = 12.sp;
var midSubHeadingFontSize = 11.sp;
var subHeadingFontSize = 10.sp;

var smallFontSize = 8.sp;
var mediumFontSize1 = 9.sp;
var mediumFontSize2 = 10.sp;

TextStyle hintStyle = TextStyle(
  fontSize: mediumFontSize2,
  color: gHintTextColor,
  fontFamily: kFontBook
);

TextStyle fieldTextStyle({Color? color, double? fontSize, String? fontFamily}){
  return TextStyle(
      fontSize: fontSize ?? mediumFontSize2,
      color: color ?? gTextColor,
      fontFamily: fontFamily ?? kFontMedium
  );
}

TextStyle btnTextStyle({Color? color, double? fontSize}){
  return TextStyle(
      fontSize: fontSize ?? mediumFontSize2,
      color: color ?? gWhiteColor,
      fontFamily: kFontMedium,
  );
}