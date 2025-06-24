import 'dart:convert';
import 'dart:developer';
import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/models/products.dart';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetProductsRepo {
  static Future<void> getProductsRepo({
    required Function(Products products) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      final coreController = Get.find<CoreController>();
      final token = coreController.currentUser.value?.token ?? "";

      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final url = Uri.parse(Api.getProductsUrl);
      final response = await http.get(url, headers: headers);

      final data = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final productModel = Products.fromJson(data);
        onSuccess(productModel);
      } else {
        onError(data["message"] ?? "Failed to fetch products.");
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Something went wrong");
    }
  }
}
