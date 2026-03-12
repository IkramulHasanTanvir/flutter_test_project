import 'package:flutter/material.dart';
import 'package:flutter_test_project/app/helpers/prefs_helper.dart';
import 'package:flutter_test_project/app/utils/app_constants.dart';
import 'package:flutter_test_project/features/login/model/user_model_data.dart';
import 'package:flutter_test_project/features/posts/controller/posts_controller.dart';
import 'package:flutter_test_project/features/products/controller/product_controller.dart';
import 'package:flutter_test_project/routes/app_routes.dart';
import 'package:flutter_test_project/services/api_client.dart';
import 'package:flutter_test_project/services/api_urls.dart';
import 'package:get/get.dart';
import 'dart:convert';

class LoginController extends GetxController {

  bool isLoading = false;
  UserModelData? userData;

  @override
  void onInit() {
    super.onInit();
    _loadUserDataFromLocal();
  }

  Future<void> _loadUserDataFromLocal() async {
    final String userJson = await PrefsHelper.instance.getString(AppConstants.instance.userDara);
    if (userJson.isNotEmpty) {
      userData = UserModelData.fromJson(jsonDecode(userJson));
      update();
    }
  }

  /// <======================= login ===========================>
  Future<bool> login({required String userName, required String password}) async {
    isLoading = true;
    update();

    try {
      final requestBody = {
        'username': userName,
        'password': password,
        'expiresInMins': 30,
      };

      final response = await ApiClient.postData(ApiUrls.login, requestBody,headers: {
        'Content-Type': 'application/json'
      });
      final responseBody = response.body;

      if (response.statusCode == 200) {
        /// Token save
        await PrefsHelper.instance.setString(
          AppConstants.instance.accessToken,
          responseBody['accessToken'] ?? '',
        );

        /// User data save
        userData = UserModelData.fromJson(responseBody);
        await PrefsHelper.instance.setString(
          AppConstants.instance.userDara,
          jsonEncode(responseBody),
        );

        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Something went wrong: $e');
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  /// Logout
  Future<void> logout() async {
    await PrefsHelper.instance.remove(AppConstants.instance.accessToken);
    await PrefsHelper.instance.remove(AppConstants.instance.userDara);
    Get.find<ProductController>().productsData.clear();
    Get.find<PostsController>().postsData.clear();
    userData = null;
    Get.offAllNamed(AppRoutes.loginScreen);
    debugPrint('log out success');
    update();
  }
}