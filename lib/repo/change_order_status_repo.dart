import 'dart:convert';
import 'dart:developer';
import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChangeOrderStatusRepo {
  static Future<void> changeOrderStatusRepo({
    required String orderId,
    required String status,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      final coreController = Get.put(CoreController());
      final token = coreController.currentUser.value!.token.toString();
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var body = jsonEncode({"status": status});

      http.Response response = await http.put(
        Uri.parse("${Api.ordersUrl}/$orderId"),
        headers: headers,
        body: body,
      );

      dynamic data = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        onSuccess(data["message"]);
      } else {
        onError(data["message"]);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry, something went wrong");
    }
  }
}
