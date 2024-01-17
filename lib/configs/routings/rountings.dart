import 'package:flutter/material.dart';
import 'package:pipeline/features/add_order/presentation/screen/add_order_screen.dart';
import 'package:pipeline/features/authentication/presentation/login_screen.dart';
import 'package:pipeline/features/brand_management/presentation/screens/brand_setting_screen.dart';
import 'package:pipeline/features/introduction/presentation/splash_screen.dart';
import 'package:pipeline/features/main_wrapper.dart';
import 'package:pipeline/features/search_feature/presentation/screens/search_screen.dart';



Map<String, Widget Function(BuildContext)> routs = {
  '/': (context) => const SplashScreen(),
  '/login': (context) => const LogInScreen(),
  '/mainWrapper': (context) => MainWrapper(),
  '/brands': (context) => const BrandSettingScreen(),
  '/addOrder': (context) => const AddOrderScreen(),
  '/search': (context) => const SearchScreen(),
};

class Routs {
  static const String splash = '/';
  static const String login = '/login';
  static const String mainWrapper = '/mainWrapper';
  static const String brandSetting = '/brands';
  static const String addOrder = '/addOrder';
  static const String searchPage = '/search';
}
