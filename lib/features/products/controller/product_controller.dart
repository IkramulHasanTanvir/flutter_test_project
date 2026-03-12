import 'package:flutter/material.dart';
import 'package:flutter_test_project/features/login/controller/login_controller.dart';
import 'package:flutter_test_project/features/products/model/product_model_data.dart';
import 'package:flutter_test_project/services/api_client.dart';
import 'package:flutter_test_project/services/api_urls.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  @override
  void onInit() {
    if(Get.find<LoginController>().userData?.accessToken != null) {
      productsGet();
    }
    super.onInit();
  }

  bool isLoadingProduct = false;
  bool isLoadingProductMore = false;
  int limit = 10;
  int skip = 0;
  int totalProduct = 0;
  List<ProductsModelData> productsData = [];

  bool get hasMore => productsData.length < totalProduct;

  Future<void> productsGet({bool isInitialLoad = true}) async {
    try {
      if (isInitialLoad) {
        productsData.clear();
        skip = 0;
        isLoadingProduct = true;
        isLoadingProductMore = false;
        update();
      }

      final response = await ApiClient.getData(
        ApiUrls.products(skip: skip, limit: limit),
      );

      if (response.statusCode == 200) {
        final List data = response.body['products'] ?? [];
        productsData.addAll(data.map((json) => ProductsModelData.fromJson(json)),
        );
        totalProduct = response.body['total'] ?? totalProduct;
      } else {
        debugPrint('productsGet error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('productsGet error: $e');
    } finally {
      isLoadingProduct = false;
      isLoadingProductMore = false;
      update();
    }
  }

  Future<void> productsMore() async {
    if (!hasMore || isLoadingProductMore || isLoadingProduct) return;
    try {
      skip += limit;
      isLoadingProductMore = true;
      update();

      await productsGet(isInitialLoad: false);
    } catch (e) {
      debugPrint('productsMore error: $e');
    }
  }
}
