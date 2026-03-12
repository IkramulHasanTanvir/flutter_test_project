import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_project/app/utils/app_colors.dart';
import 'package:flutter_test_project/features/login/controller/login_controller.dart';
import 'package:flutter_test_project/routes/app_routes.dart';
import 'package:flutter_test_project/widgets/widgets.dart';
import 'package:flutter_test_project/widgets/custom_dialog.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLightColor,
      body: SafeArea(
        child: GetBuilder<LoginController>(
          builder: (controller) {
            final data = controller.userData;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      CustomNetworkImage(
                        boxShape: BoxShape.circle,
                        height: 60.r,
                        width: 60.r,
                        imageUrl: data?.image ?? 'N/A',
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: data?.fullUserName ?? 'User Name',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 2.h),
                            CustomText(
                              text: '@${data?.username ?? 'username'}',
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 0.5, height: 24.h),
                _buildSection(
                  label: 'Personal :',
                  tiles: [
                    _buildTile('Email', data?.email ?? '—'),
                    _buildTile('Gender', data?.gender ?? '—'),
                  ],
                ),

                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: CustomButton(
                    label: 'Log out',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialog(
                          title: "Do you want to log out your profile?",
                          onCancel: () => Get.back(),
                          onConfirm: () =>
                              Get.offAllNamed(AppRoutes.loginScreen),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSection({required String label, required List<Widget> tiles}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            textAlign: TextAlign.start,
            text: label.toUpperCase(),
            fontSize: 10.sp,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
          ...tiles,
        ],
      ),
    );
  }

  Widget _buildTile(String label, String value) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: label),
              CustomText(text: value, fontWeight: FontWeight.w500),
            ],
          ),
        ),
      ],
    );
  }
}
