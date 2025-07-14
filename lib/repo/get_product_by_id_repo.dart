import 'dart:convert';
import 'dart:developer';
import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/models/products.dart';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetProductByIdRepo {
  static Future<void> getProductByIdRepo({
    required String productId,
    required Function(Data product) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      final coreController = Get.find<CoreController>();
      final token = coreController.currentUser.value?.token ?? "";

      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = Uri.parse("${Api.getProductsUrl}/$productId");

      http.Response response = await http.get(url, headers: headers);
      dynamic data = json.decode(response.body);
      log("Product by id: $data");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Data product = Data.fromJson(data["data"]);
        onSuccess(product);
      } else {
        onError(data["message"] ?? "Something went wrong");
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }
}
