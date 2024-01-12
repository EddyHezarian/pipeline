import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pipeline/configs/theme/text_styles.dart';

AppBar secondaryAppBar({required String title, required BuildContext context}) {
  return AppBar(
    automaticallyImplyLeading: false,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(CupertinoIcons.back)),
    title: Text(title),
    titleTextStyle: TextStyles.appbarHeading,
  );
}
