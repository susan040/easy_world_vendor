import 'dart:convert';
import 'dart:developer';
import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SendMessageToCustomerRepo {
  /// Sends a message to a customer chat.
  /// Returns the full message object in `onSuccess` for controller to parse chat_id and message_id
  static Future<void> sendMessageToCustomer({
    required String messages,
    required dynamic chatId, // Accept int or String
    required Function(Map<String, dynamic> message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      final coreController = Get.find<CoreController>();
      final token = coreController.currentUser.value?.token;

      if (token == null) {
        onError("User token is null");
        return;
      }

      log("Sending message: $messages to chatId: $chatId");

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${Api.chatUrl}/${chatId.toString()}/reply"),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.fields['message'] = messages;

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      log("Response status: ${response.statusCode}");
      log("Response body: ${responseBody.body}");

      if (responseBody.body.isEmpty) {
        onError("Empty response from server");
        return;
      }

      var data = jsonDecode(responseBody.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Ensure message object is a map
        Map<String, dynamic> messageObj;
        if (data['message'] is Map<String, dynamic>) {
          messageObj = data['message'];
        } else {
          messageObj = {'message': data['message'].toString()};
        }

        log("Message sent successfully: ${messageObj['message']}");
        onSuccess(messageObj);
      } else {
        String errorMessage = "Something went wrong";
        if (data['message'] is String) {
          errorMessage = data['message'];
        } else if (data['message'] is Map &&
            data['message']['message'] != null) {
          errorMessage = data['message']['message'];
        }
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
