import 'dart:convert';
import 'dart:developer';
import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/models/all_chats.dart';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetChatByIdRepo {
  static Future<void> getChatByIdRepo({
    required int chatId,
    required Function(AllChats chatDetails) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      final coreController = Get.put(CoreController());
      final token = coreController.currentUser.value!.token.toString();
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = Uri.parse("${Api.chatUrl}/$chatId");
      http.Response response = await http.get(url, headers: headers);
      dynamic data;
      try {
        data = json.decode(response.body);
      } catch (e) {
        onError("Invalid response format");
        return;
      }
      // log("GetSingleChatByIdRepo full data: $data");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (data is Map) {
          final Map<String, dynamic> chatMap = Map<String, dynamic>.from(data);
          AllChats chat = AllChats.fromJson(chatMap);
          log(chat.toString());
          onSuccess(chat);
        } else {
          onError("Unexpected response format");
        }
      } else {
        onError(data["message"] ?? "Failed to fetch chat");
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }
}
