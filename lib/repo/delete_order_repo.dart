import 'dart:convert';
import 'dart:developer';
import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:easy_world_vendor/utils/http_request.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeleteOrderRepo {
  static Future<void> deleteOrderRepo({
    required int orderId,
    required Function(String Message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var coreController = Get.find<CoreController>();
      var token = coreController.currentUser.value!.token.toString();
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      http.Response response = await HttpRequestEasyWorld.delete(
        Uri.parse("${Api.ordersUrl}/$orderId"),
        headers: headers,
      );
      dynamic data = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        onSuccess(data["message"]);
      } else {
        onError(data["message"]);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry something went wrong");
    }
  }
}
