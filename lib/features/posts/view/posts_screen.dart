import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_project/app/utils/app_colors.dart';
import 'package:flutter_test_project/assets_path/assets.gen.dart';
import 'package:flutter_test_project/features/posts/controller/posts_controller.dart';
import 'package:flutter_test_project/features/posts/view/widget/post_model_data.dart';
import 'package:flutter_test_project/widgets/widgets.dart';
import 'package:get/get.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final PostsController _postsController = Get.find<PostsController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addScrollListener();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_postsController.postsData.isEmpty) {
        _postsController.postsGet();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLightColor,
      appBar: CustomAppBar(title: 'Posts'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: RefreshIndicator(
              elevation: 0,
              color: AppColors.primaryColor,
              onRefresh: () async {
                await _postsController.postsGet();
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: GetBuilder<PostsController>(
                  builder: (controller) {
                    if (controller.isLoadingPost) {
                      return SizedBox(
                        height: 400.h,
                        child: Center(child: CupertinoActivityIndicator()),
                      );
                    }

                    if (controller.postsData.isEmpty) {
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
                              onPressed: () => controller.postsGet(),
                            ),
                          ],
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          itemCount: controller.postsData.length,
                          itemBuilder: (context, index) {
                            final posts = controller.postsData[index];
                            return PostCardWidget(title: posts.title ?? 'N/A', body: posts.body ?? 'N/A',);
                          },
                        ),
                        if (controller.isLoadingPostMore)
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

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        _postsController.postsMore();
      }
    });
  }
}
