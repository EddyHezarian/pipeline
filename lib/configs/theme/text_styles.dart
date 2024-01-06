import 'package:flutter/material.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';

class TextStyles {
  static const TextStyle appbarHeading = TextStyle(
    color: ColorPallet.maintext,
    fontFamily: "dana",
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );     
  static const TextStyle selectedProductType = TextStyle(
    color: ColorPallet.primary,
    fontFamily: "dana",
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );     
  static const TextStyle productType = TextStyle(
    color: ColorPallet.maintext,
    fontFamily: "dana",
    fontWeight: FontWeight.w700,
    fontSize: 13,
  );   
  static const TextStyle redWarning = TextStyle(
    color: ColorPallet.error,
    fontFamily: "dana",
    fontWeight: FontWeight.w700,
    fontSize:  16,
  ); 
  static const TextStyle heading = TextStyle(
    color: ColorPallet.subtext,
    fontFamily: "dana",
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  static const TextStyle textFieldTitle = TextStyle(
      color: ColorPallet.maintext,
      fontFamily: "dana",
      fontWeight: FontWeight.w500,
      fontSize: 12);
       static const TextStyle productBrandCard = TextStyle(
      color: ColorPallet.maintext,
      fontFamily: "dana",
      fontWeight: FontWeight.w700,
      fontSize: 16);
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
      static const TextStyle lightAppBar =
      TextStyle(fontFamily: "dana", fontSize: 20, fontWeight: FontWeight.w700,color: ColorPallet.lightText);      
      static const TextStyle actionTextButton =
      TextStyle(fontFamily: "dana", fontSize: 16, fontWeight: FontWeight.w700,color: ColorPallet.primary);
      static const TextStyle forgetit =
      TextStyle(fontFamily: "dana", fontSize: 16, fontWeight: FontWeight.w700,color: ColorPallet.subtext);
}
