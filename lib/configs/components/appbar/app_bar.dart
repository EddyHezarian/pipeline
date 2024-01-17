import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pipeline/configs/routings/rountings.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/text_styles.dart';

AppBar customeMainAppBar(
    {required BuildContext context, required String title ,bool isTabView=false ,List<Widget>?tabItemList }) {
  return AppBar(
    toolbarHeight: 100,
    actions: [
      IconButton(
        onPressed: () {
          Navigator.of(context,rootNavigator: true).pushNamed( Routs.addOrder,);
        },
        icon: const Icon(CupertinoIcons.add),
        tooltip: "سفارش جدید",
      ),
      IconButton(
        onPressed: () {
           Navigator.of(context,rootNavigator: true).pushNamed( Routs.searchPage,);

        },
        icon: const Icon(CupertinoIcons.search),
        tooltip: "جستجوی نام",
        
      ),
    ],
    iconTheme: const IconThemeData(
      color: ColorPallet.bigicon,
    ),
    titleTextStyle: TextStyles.appbarHeading,
    elevation: 0,
    backgroundColor: ColorPallet.background,
    title: Text(title),
    bottom:  isTabView ? TabBar(labelStyle: TextStyles.bottomNavItems, tabs: tabItemList!):null,
  );

}


