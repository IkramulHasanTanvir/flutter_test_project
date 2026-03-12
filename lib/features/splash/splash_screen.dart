import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_project/app/helpers/prefs_helper.dart';
import 'package:flutter_test_project/app/utils/app_colors.dart';
import 'package:flutter_test_project/app/utils/app_constants.dart';
import 'package:flutter_test_project/assets_path/assets.gen.dart';
import 'package:flutter_test_project/features/bottom_nav/controller/bottom_nav_bar.dart';
import 'package:flutter_test_project/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  void _goNextScreen() {
    Future.delayed(const Duration(seconds: 2), () async {
      String token = await PrefsHelper.instance.getString(AppConstants.instance.accessToken);
      
      if (token.isEmpty) {
        Get.offAllNamed(AppRoutes.loginScreen);
      }
      else {
        Get.offAllNamed(AppRoutes.bottomNavBar);
        Get.find<BottomNavBarController>().onChange(0);
      }
    });
  }

  @override
  void initState() {
    _goNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLightColor,
      body: Center(
        child: Assets.icons.logo.svg(height: 170.h,width: 183.w),
      ),
    );
  }
}
