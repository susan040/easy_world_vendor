import 'dart:convert';
import 'dart:developer';
import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ReadNotificationRepo {
  static Future<void> readNotificationRepo({
    required String notificationId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      final coreController = Get.put(CoreController());
      final token = coreController.currentUser.value!.token.toString();
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var url = Uri.parse("${Api.notificationUrl}/${notificationId}/read");
      http.Response response = await http.patch(url, headers: headers);
      dynamic data = json.decode(response.body);
      log("data$data");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        onSuccess(data['message']);
      } else {
        onError(data["message"]);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }
}

class MarkAllAsReadNotification {
  static Future<void> markAllAsReadNotification({
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      final coreController = Get.put(CoreController());
      final token = coreController.currentUser.value!.token.toString();
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var url = Uri.parse("${Api.notificationUrl}/read-all");
      http.Response response = await http.patch(url, headers: headers);
      dynamic data = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        onSuccess(data['message']);
      } else {
        onError(data["message"]);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }
}
