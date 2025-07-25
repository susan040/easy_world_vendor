import 'dart:convert';
import 'dart:developer';
import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditBankDetailsRepo {
  static Future<void> editBankDetailsRepo({
    required String accountHolderName,
    required String accountNumber,
    required String bankName,
    required String branchName,
    required String bankDetailId,
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
      var body = {
        "account_holder_name": accountHolderName,
        "account_number": accountNumber,
        "bank_name": bankName,
        "branch_name": branchName,
      };
      log("Body $body");
      http.Response response = await http.post(
        Uri.parse("${Api.bankDetailsUrl}/$bankDetailId"),
        headers: headers,
        body: body,
      );
      dynamic data = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        onSuccess(data['message']);
      } else {
        onError(data["message"]);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
    }
  }
}
