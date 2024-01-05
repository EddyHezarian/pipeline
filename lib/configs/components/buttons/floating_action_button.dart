import 'package:flutter/material.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/text_styles.dart';

FloatingActionButton customeActionButton(
    {required String title, required Function action}) {
  return FloatingActionButton.extended(
      backgroundColor: ColorPallet.primary,
      onPressed: () {
        action();
      },
      label: Text(
        title,
        style: TextStyles.mainButtons,
      ));
}
