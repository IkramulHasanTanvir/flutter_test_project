import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_project/app/utils/app_colors.dart';
import 'package:flutter_test_project/features/bottom_nav/controller/bottom_nav_bar.dart';
import 'package:flutter_test_project/features/posts/view/posts_screen.dart';
import 'package:flutter_test_project/features/products/view/product_screen.dart';
import 'package:flutter_test_project/features/settings/view/settings_screen.dart';
import 'package:flutter_test_project/widgets/widgets.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final BottomNavBarController _navBarController =
      Get.find<BottomNavBarController>();

  final List<Widget> _screens = [
    ProductScreen(),
    PostsScreen(),
    SettingsScreen(),
  ];

  final List<IconData> _navItems = [
    Icons.production_quantity_limits_outlined,
    Icons.feed_outlined,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavBarController>(
      builder: (controller) => Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.bgLightColor,
        body: _screens[_navBarController.selectedIndex],
        bottomNavigationBar: CustomContainer(
          paddingTop: 8.h,
          paddingBottom: 2.h,
          elevation: true,
          topLeftRadius: 30.r,
          topRightRadius: 30.r,
          color: AppColors.bgLightColor,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navItems.length, (index) {
                bool isSelected = _navBarController.selectedIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => _navBarController.onChange(index),
                    child: AnimatedContainer(
                      curve: Curves.easeInCirc,
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryColor
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      duration: Duration(milliseconds: 300),
                      child: Icon(
                        _navItems[index],
                        color: isSelected
                            ? AppColors.bgLightColor
                            : AppColors.primaryColor,
                        size: 24.r,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
