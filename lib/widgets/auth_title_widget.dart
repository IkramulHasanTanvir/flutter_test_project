import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_project/assets_path/assets.gen.dart';
import '../app/utils/app_colors.dart';
import '../widgets/widgets.dart';


class AuthTitleWidget extends StatelessWidget {
  const AuthTitleWidget(
      {super.key,
      required this.title,
      this.subtitle,
      this.titleColor,
      this.subTitleColor,
      this.titleFontSize,
      this.subTitleFontSize});

  final String title;
  final String? subtitle;
  final Color? titleColor;
  final Color? subTitleColor;
  final double? titleFontSize;
  final double? subTitleFontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Assets.icons.logo.svg(height: 100.h,width: 100.w),
        CustomText(
          top: 12.h,
          text: title,
          fontSize:titleFontSize?? 24.sp,
          color: titleColor ?? AppColors.bgDarkColor,
        ),
          SizedBox(height: 6.h),
          CustomText(
            textAlign: TextAlign.start,
            text: subtitle ?? '',
            fontSize:subTitleFontSize?? 15.sp,
            color: subTitleColor ?? AppColors.appGreyColor,
          ),
      ],
    );
  }
}
