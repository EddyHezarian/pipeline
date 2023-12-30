import 'package:flutter/material.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';

class TextStyles {
  static const TextStyle appbarHeading = TextStyle(
    color: ColorPallet.maintext,
    fontFamily: "dana",
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  static const TextStyle textFieldTitle = TextStyle(
      color: ColorPallet.maintext,
      fontFamily: "dana",
      fontWeight: FontWeight.w500,
      fontSize: 12);
  static const TextStyle mainButtons = TextStyle(
      color: ColorPallet.lightText,
      fontFamily: "dana",
      fontWeight: FontWeight.w700,
      fontSize: 20);
  static const TextStyle splashConnectionState = TextStyle(
      color: ColorPallet.maintext,
      fontFamily: "dana",
      fontWeight: FontWeight.w500,
      fontSize: 14);  
      static const TextStyle drawerItems = TextStyle(
      color: ColorPallet.maintext,
      fontFamily: "dana",
      fontWeight: FontWeight.w500,
      fontSize: 18);
  static const TextStyle bottomNavItems =
      TextStyle(fontFamily: "dana", fontSize: 13, fontWeight: FontWeight.w500);
}
