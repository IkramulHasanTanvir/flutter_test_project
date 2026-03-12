import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_project/app/utils/app_colors.dart';
import 'package:flutter_test_project/widgets/widgets.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final String body;


  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      bordersColor: AppColors.primaryColor,
      borderWidth: 0.5,
      marginBottom: 10.h,
      paddingAll: 10.r,
      radiusAll: 8.r,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            textAlign: TextAlign.start,
            text: title ?? 'N/A',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 10.h),
          Divider(),
          CustomText(
            textAlign: TextAlign.start,
            text: body ?? 'N/A',
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
