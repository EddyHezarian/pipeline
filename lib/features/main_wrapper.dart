import 'package:flutter/material.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/features/order_managment/ready_order/ready_order_screen.dart';

class MainWrapper extends StatelessWidget {

  MainWrapper({super.key,});
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPallet.background,
        //!actions--> floating ation button for creat order and bottom nav for routing the page
        //?--bottomNavigationBar: 
        body: PageView(
          physics:
              const NeverScrollableScrollPhysics(), //! for prevent conflict in scrolling
          allowImplicitScrolling: true,
          controller: _pageController,
          children:  const [
           ReadyOrderScreen()
           //? ready_orders
           //? delevered orders 
           //? chart
          ],
        ),
      ),
    );
  }
}