import 'package:flutter/material.dart';
import 'package:flutter_test_project/features/bottom_nav/view/bottom_nav_bar_screen.dart';
import 'package:flutter_test_project/features/login/views/log_in_screen.dart';
import 'package:flutter_test_project/features/splash/splash_screen.dart';

abstract class AppRoutes {
  ///  ============= > initialRoute < ==============
  static const String initialRoute = splashScreen;

  ///  ============= > routes name < ==============
  static const String splashScreen = '/';
  static const String loginScreen = '/loginScreen';
  static const String bottomNavBar = '/bottomNavBar';

  ///  ============= > routes < ==============
  static final routes = <String, WidgetBuilder>{
    splashScreen: (context) => SplashScreen(),
    loginScreen: (context) => LoginScreen(),
    bottomNavBar: (context) => BottomNavBar(),
  };
}
