import 'dart:convert';
import 'dart:developer';
import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/models/reviews.dart';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetReviewsRepo {
  static Future<void> getReviewsRepo({
    required Function(List<Reviews> reviews) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      final coreController = Get.put(CoreController());
      final token = coreController.currentUser.value!.token.toString();
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var url = Uri.parse(Api.reviewsUrl);
      http.Response response = await http.get(url, headers: headers);
      dynamic data = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<Reviews> reviews = reviewsFromJson(data["data"]);
        onSuccess(reviews);
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
