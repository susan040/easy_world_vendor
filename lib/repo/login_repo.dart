import 'dart:convert';
import 'dart:developer';
import 'package:easy_world_vendor/models/users.dart';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:http/http.dart' as http;

class LoginRepo {
  static Future<void> loginRepo({
    required String email,
    required String password,
    required Function(UsersDetails user, String token) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {"Accept": "application/json"};
      var body = {"email": email, "password": password};
      http.Response response = await http.post(
        Uri.parse(Api.loginUrl),
        headers: headers,
        body: body,
      );
      dynamic data = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        String accessToken = data["token"].toString();
        UsersDetails user = UsersDetails.fromJson(data);
        log(UsersDetails.fromJson(data["data"]).toString());
        onSuccess(user, accessToken);
      } else {
        onError(data["message"]);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry, something went wrong");
    }
  }
}
