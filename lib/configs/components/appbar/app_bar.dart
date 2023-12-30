import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/text_styles.dart';

AppBar customeAppBar(){
 return AppBar(
        toolbarHeight: 100,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.add),tooltip: "سفارش جدید",),
          IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.search),tooltip: "جستجوی نام",),
        ],
        iconTheme: const IconThemeData(color: ColorPallet.bigicon,),
        titleTextStyle: TextStyles.appbarHeading,
        elevation: 0 ,
        backgroundColor: ColorPallet.background,
        title: const Text("سفارشات جاری"),
        );
  }
