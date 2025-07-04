import 'dart:convert';
import 'dart:developer';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:http/http.dart' as http;

class RequestForgotPasswordRepo {
  static Future<void> requestForgotPasswordRepo({
    required String email,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {"Accept": "application/json"};
      var body = {"email": email};
      log("Body $body");
      http.Response response = await http.post(
        Uri.parse(Api.forgotPasswordRequestUrl),
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

class ForgetPasswordVerifyOtpRepo {
  static Future<void> forgetPasswordVerifyOtpRepo({
    required String email,
    required String otp,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {"Accept": "application/json"};
      var body = {"email": email, "otp": otp};
      log("Body $body");
      http.Response response = await http.post(
        Uri.parse(Api.forgotPassOtpVerifyUrl),
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

class ResetPasswordRepo {
  static Future<void> resetPasswordRepo({
    required String email,
    required String password,
    required String confirmPassword,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {"Accept": "application/json"};
      var body = {
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
      };
      log("Body $body");
      http.Response response = await http.post(
        Uri.parse(Api.resetPasswordUrl),
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
