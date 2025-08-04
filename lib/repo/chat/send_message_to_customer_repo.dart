import 'dart:convert';
import 'dart:developer';
import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SendMessageToCustomerRepo {
  static Future<void> sendMessageToCustomer({
    required String messages,
    required String chatId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      final coreController = Get.find<CoreController>();
      final token = coreController.currentUser.value?.token;

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${Api.chatUrl}/$chatId/reply"),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      request.fields['message'] = messages;

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      var data = jsonDecode(responseBody.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // int chatId = data['message']['chat_id'] ?? 0;
        // log("Chat ID: $chatId");

        var messageContent =
            data['message']['message'] ?? "Message sent successfully";
        log("Message sent successfully: $messageContent");

        onSuccess(messageContent);
      } else {
        var errorMessage =
            data['message'] is String
                ? data['message']
                : "Something went wrong";
        log("Failed to send message: $errorMessage");
        onError(errorMessage);
      }
    } catch (e, s) {
      log("Exception caught: $e");
      log("Stacktrace: $s");
      onError("Sorry, something went wrong");
    }
  }
}
