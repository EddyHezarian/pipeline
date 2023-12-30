import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/text_styles.dart';

class CustomeDrawer extends StatelessWidget {
  const CustomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorPallet.background,
      child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: [
       const DrawerHeader(
        decoration: BoxDecoration(
          color: ColorPallet.background
        ),
        child:Center(child: Image(image: AssetImage("assets/img/logo2.png")))
      ),
      ListTile(
        leading: const Icon(
          CupertinoIcons.settings,
        ),
        title: const Text('برند ها'),
        titleTextStyle: TextStyles.drawerItems,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: const Icon(
          CupertinoIcons.shopping_cart,
        ),
        title: const Text('محصولات'),
        titleTextStyle: TextStyles.drawerItems,
        onTap: () {
          Navigator.pop(context);
        },
      ),     
       ListTile(
        leading: const Icon(
          CupertinoIcons.chat_bubble_text,
        ),
        title: const Text('تماس با پشتیبانی'),
        titleTextStyle: TextStyles.drawerItems,
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ],
      ),
    );
  }
}