import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

 class DeviceUtils {
  DeviceUtils._();

  static DeviceUtils get instance => DeviceUtils._();


  void lockDevicePortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
