import 'package:flutter/material.dart';
import 'package:pipeline/features/authentication/presentation/login_screen.dart';
import 'package:pipeline/features/introduction/presentation/splash_screen.dart';
import 'package:pipeline/features/main_wrapper.dart';

Map<String, Widget Function(BuildContext)> routs = {
  '/': (context) => const SplashScreen(),
  '/login': (context) => const LogInScreen(),
  '/mainWrapper': (context) =>  MainWrapper(),
};

class Routs {
  static const String splash = '/';
  static const String login = '/login';
  static const String mainWrapper = '/mainWrapper';
}
