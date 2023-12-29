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
    fontSize: 12
  ); 
  static const TextStyle mainButtons = TextStyle(
    color: ColorPallet.lightText,
    fontFamily: "dana",
    fontWeight: FontWeight.w700,
    fontSize: 20
  );
}
