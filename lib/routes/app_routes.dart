
import 'package:flutter/material.dart';

abstract class AppRoutes {

  ///  ============= > initialRoute < ==============
  static const String initialRoute = splashScreen;



  ///  ============= > routes name < ==============
  static const String splashScreen = '/';
  static const String loginScreen = '/loginScreen';
  static const String registerScreen = '/registerScreen';





  ///  ============= > routes < ==============
  static final routes = <String, WidgetBuilder>{
    //splashScreen : (context) => SplashScreen(),


  };
}
