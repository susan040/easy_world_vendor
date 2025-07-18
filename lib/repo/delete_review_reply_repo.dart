import 'dart:convert';
import 'dart:developer';
import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:easy_world_vendor/utils/http_request.dart';
import 'package:get/get.dart';

class DeleteReviewReplyRepo {
  static Future<void> deleteReviewReplyRepo({
    required int replyId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var coreController = Get.find<CoreController>();
      var token = coreController.currentUser.value!.token.toString();

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final url = Uri.parse("${Api.deleteReplyUrl}/$replyId");
      final response = await HttpRequestEasyWorld.delete(url, headers: headers);

      log('Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      final data = json.decode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        onSuccess(data["message"] ?? "Deleted successfully");
      } else {
        onError(data["message"] ?? "Something went wrong");
      }
    } catch (e, s) {
      log("Exception: $e");
      log("StackTrace: $s");
      onError("Sorry something went wrong");
    }
  }
}
