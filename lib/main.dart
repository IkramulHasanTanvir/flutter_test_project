import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_project/routes/app_routes.dart';
import 'package:flutter_test_project/services/internet/no_internet_wrapper.dart';
import 'package:get/get.dart';
import 'app/dependancy_injaction.dart';
import 'app/helpers/device_utils.dart';
import 'app/theme/app_theme.dart';

void main() async {
  DeviceUtils.instance.lockDevicePortrait();
  runApp(const FlutterTestProject());
}

class FlutterTestProject extends StatelessWidget {
  const FlutterTestProject({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: ScreenUtil.defaultSize,
      builder: (_, _) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.initialRoute,
        theme: AppThemeData.lightThemeData,
        darkTheme: AppThemeData.darkThemeData,
        themeMode: ThemeMode.light,
        initialBinding: DependencyInjection(),
        routes: AppRoutes.routes,
        builder: (context, child) =>
            Scaffold(body: NoInternetWrapper(child: child!)),
      ),
    );
  }
}
