import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_project/app/utils/app_colors.dart';
import 'package:flutter_test_project/widgets/custom_text.dart';

class ToggleTileButton extends StatelessWidget {
  const ToggleTileButton({
    super.key,
    required this.value,
    required this.label,
    this.onChanged,
  });

  final bool value;
  final String label;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                value ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                size: 18.r,
                color: AppColors.primaryColor,
              ),
              SizedBox(width: 8.w),
              CustomText(text: label),
            ],
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
