import 'dart:convert';
import 'dart:developer';
import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/models/review_replies.dart';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetReviewRepliesRepo {
  static Future<void> getReviewRepliesRepo({
    required Function(List<ReviewReplies> replies) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      final coreController = Get.put(CoreController());
      final token = coreController.currentUser.value!.token.toString();
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var url = Uri.parse("${Api.replyReviewUrl}/replies");
      http.Response response = await http.get(url, headers: headers);
      dynamic data = json.decode(response.body);
      log("review reply: $data");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<ReviewReplies> replies = reviewRepliesFromJson(data["data"]);
        onSuccess(replies);
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
