import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_project/app/utils/app_colors.dart';
import 'package:flutter_test_project/widgets/widgets.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    this.index,
    required this.image,
    required this.title,
    required this.price,
  });

  final int? index;
  final String image;
  final String title;
  final double price;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child:           CustomContainer(
        paddingVertical: 6.h,
        paddingHorizontal: 6.w,
        horizontalMargin: 4.w,
        radiusAll: 8.r,
        color: Colors.white,
        height: 207.h,
        width: double.infinity,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(-2, 1),
            blurRadius: 16,
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product image
            CustomNetworkImage(
              border: Border(
                bottom: BorderSide(color: AppColors.primaryColor),
              ),
              height: 109.h,
              width: double.infinity,
              borderRadius: 8.r,
              fit: BoxFit.cover,
              imageUrl: image,
            ),

            SizedBox(height: 10.h),

            /// Product title + rating

            CustomText(
              textOverflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              text: title,
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),


            /// Price

                CustomText(
                  top: 3.h,
                  color: AppColors.primaryColor,
                  textOverflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  left: 4.w,
                  text: '\$ ${price.toStringAsFixed(2)}',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),

            const Spacer(),

                Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                    fontWeight: FontWeight.w400,
                    onPressed: () {
                      // Get.toNamed(AppRoutes.productDetailsScreen);
                    },
                    label: 'View Details',
                    fontSize: 12.sp,
                    height: 20.h,
                   // width: 80.w,
                    radius: 8.r,
                  ),
                ),

          ],
        ),
      ),

    );
  }
}
