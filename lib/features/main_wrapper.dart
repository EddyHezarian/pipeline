import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/text_styles.dart';
import 'package:pipeline/features/chart/presentation/chart_screen.dart';
import 'package:pipeline/features/order_managment/delivered_order/presentation/delivered_order_screen.dart';
import 'package:pipeline/features/order_managment/open_order/presentation/open_order_screen.dart';
import 'package:pipeline/features/order_managment/ready_order/ready_order_screen.dart';
/*  

   main wrapper contains Main Screens 
    pristentTabView is the widget that is bottomNavigationBar and in 
    screens property specify the main Screens wich are specefied in the _buildScreens() method
    other properties are decoration and configuration of bottomNavigationBar 
*/
class MainWrapper extends StatelessWidget {
   MainWrapper({
    super.key,
  });
  final PersistentTabController controller =PersistentTabController(initialIndex: 0);
 
 @override
  Widget build(BuildContext context) {

    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: ColorPallet.actionContainer, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(4.0),
        colorBehindNavBar: Colors.green,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 100),
        curve: Curves.easeOut,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 100),
      ),
      navBarStyle:
          NavBarStyle.style14, // Choose the nav bar style with this property.
    );
  }
}

List<Widget> _buildScreens() {
  return [const OpenOrderScreen(),const ReadyOrderScreen(),const DeliveredOrderScreen(), const ChartScreeen(),];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [

    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.rectangle_fill_on_rectangle_fill),
      title: (" سفارش‌ها"),
      textStyle: TextStyles.bottomNavItems,
      activeColorPrimary: ColorPallet.primary,
      inactiveColorPrimary: const Color.fromARGB(255, 93, 93, 93),
    ),    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.checkmark_rectangle_fill),
      title: (" آماده‌ها"),
      textStyle: TextStyles.bottomNavItems,
      activeColorPrimary: ColorPallet.primary,
      inactiveColorPrimary: const Color.fromARGB(255, 93, 93, 93),
    ),    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.cube_fill),
      title: (" تحویل‌َها"),
      textStyle: TextStyles.bottomNavItems,
      activeColorPrimary: ColorPallet.primary,
      inactiveColorPrimary:  const Color.fromARGB(255, 93, 93, 93),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.chart_bar_fill),
      title: (" آمار‌ها"),
      textStyle: TextStyles.bottomNavItems,
      activeColorPrimary: ColorPallet.primary,
      inactiveColorPrimary: const Color.fromARGB(255, 93, 93, 93),
    ),
  ];
}
