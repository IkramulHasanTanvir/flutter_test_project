import 'package:flutter_test_project/features/bottom_nav/controller/bottom_nav_bar.dart';
import 'package:flutter_test_project/features/login/controller/login_controller.dart';
import 'package:flutter_test_project/features/posts/controller/posts_controller.dart';
import 'package:flutter_test_project/features/products/controller/product_controller.dart';
import 'package:flutter_test_project/services/internet/connectivity.dart';
import 'package:get/get.dart';

class DependencyInjection implements Bindings {
  @override
  void dependencies() {
    Get.put(ConnectivityController());
    Get.put(LoginController());
    Get.put(BottomNavBarController());
    Get.put(ProductController());
    Get.put(PostsController());
  }}