import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_project/app/utils/app_colors.dart';
import 'package:flutter_test_project/assets_path/assets.gen.dart';
import 'package:flutter_test_project/features/login/controller/login_controller.dart';
import 'package:flutter_test_project/features/products/controller/product_controller.dart';
import 'package:flutter_test_project/features/products/view/widgets/product_card_widget.dart';
import 'package:flutter_test_project/widgets/title_widget.dart';
import 'package:flutter_test_project/widgets/widgets.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductController _productController = Get.find<ProductController>();
  final TextEditingController searchCtrl = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addScrollListener();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_productController.productsData.isEmpty) {
        _productController.productsGet();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLightColor,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: RefreshIndicator(
              elevation: 0,
              color: AppColors.primaryColor,
              onRefresh: () async {
                await _productController.productsGet();
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: GetBuilder<ProductController>(
                  builder: (controller) {
                    if (controller.isLoadingProduct) {
                      return SizedBox(
                        height: 400.h,
                        child: Center(child: CupertinoActivityIndicator()),
                      );
                    }

                    if (controller.productsData.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Assets.lotties.emptyData.lottie(),
                            SizedBox(height: 10.h),
                            CustomText(text: 'No Data Found', fontSize: 16.sp),
                            SizedBox(height: 16.h),
                            CustomButton(
                              fontSize: 14.sp,
                              height: 34.h,
                              width: 100.w,
                              label: 'Refresh',
                              onPressed: () => controller.productsGet(),
                            ),
                          ],
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        TitleWidget(title: 'All Products'),

                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 175.w / 200.h,
                                crossAxisSpacing: 7.w,
                                mainAxisSpacing: 10.h,
                              ),
                          itemCount: controller.productsData.length,
                          itemBuilder: (context, index) {
                            final product = controller.productsData[index];
                            return ProductCardWidget(
                              title: product.title ?? 'N/A',
                              price: product.price ?? 0.0,
                              image: product.thumbnail ?? 'N/A',
                            );
                          },
                        ),
                        if (controller.isLoadingProductMore)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: Center(child: CupertinoActivityIndicator()),
                          ),

                        SizedBox(height: 100.h),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= AppBar =================
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      titleWidget: GetBuilder<LoginController>(
        builder: (controller) {
          final userData = controller.userData;
          return Row(
            children: [
              SizedBox(width: 16.w),
              CustomNetworkImage(
                imageUrl: userData?.image ?? 'N/A',
                height: 50.h,
                width: 50.w,
                boxShape: BoxShape.circle,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Hello,',
                      fontSize: 22.r,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text: controller.isLoading
                          ? "_____"
                          : userData?.fullUserName ?? 'N/A',
                      fontSize: 18.r,
                      fontWeight: FontWeight.w600,
                      maxLine: 1,
                      textOverflow: TextOverflow.ellipsis,
                      color: AppColors.color4D4D4D,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        _productController.productsMore();
      }
    });
  }
}
