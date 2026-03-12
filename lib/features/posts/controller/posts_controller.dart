import 'package:flutter/material.dart';
import 'package:flutter_test_project/features/login/controller/login_controller.dart';
import 'package:flutter_test_project/features/posts/model/post_model_data.dart';
import 'package:flutter_test_project/features/products/model/product_model_data.dart';
import 'package:flutter_test_project/services/api_client.dart';
import 'package:flutter_test_project/services/api_urls.dart';
import 'package:get/get.dart';

class PostsController extends GetxController {
  @override
  void onInit() {
    if(Get.find<LoginController>().userData?.accessToken != null){
      postsGet();
    }
    super.onInit();
  }

  bool isLoadingPost = false;
  bool isLoadingPostMore = false;
  int limit = 10;
  int skip = 0;
  int totalPost = 0;
  List<PostModelData> postsData = [];

  bool get hasMore => postsData.length < totalPost;

  Future<void> postsGet({bool isInitialLoad = true}) async {
    try {
      if (isInitialLoad) {
        postsData.clear();
        skip = 0;
        isLoadingPost = true;
        isLoadingPostMore = false;
        update();
      }

      final response = await ApiClient.getData(
        ApiUrls.posts(skip: skip, limit: limit),
      );

      if (response.statusCode == 200) {
        final List data = response.body['posts'] ?? [];
        postsData.addAll(data.map((json) => PostModelData.fromJson(json)));
        totalPost = response.body['total'] ?? totalPost;
      } else {
        debugPrint('postsGet error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('postsGet error: $e');
    } finally {
      isLoadingPost = false;
      isLoadingPostMore = false;
      update();
    }
  }

  Future<void> postsMore() async {
    if (!hasMore || isLoadingPostMore || isLoadingPost) return;
    try {
      skip += limit;
      isLoadingPostMore = true;
      update();

      await postsGet(isInitialLoad: false);
    } catch (e) {
      debugPrint('postsMore error: $e');
    }
  }
}
