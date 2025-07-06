import 'dart:convert';
import 'dart:developer';
import 'package:easy_world_vendor/models/users.dart';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:http/http.dart' as http;

class SignWithGoogleRepo {
  static Future<void> signWithGoogleRepo({
    required String idToken,
    required Function(UsersDetails user, String token, String message)
    onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {"Accept": "application/json"};
      var body = {"id_token": idToken};
      http.Response response = await http.post(
        Uri.parse(Api.googleSignInUrl),
        headers: headers,
        body: body,
      );
      dynamic data = jsonDecode(response.body);
      log("User Google Account: $data");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        String userToken = data["token"].toString();
        UsersDetails user = UsersDetails.fromJson(data);
        log(UsersDetails.fromJson(data["data"]).toString());
        onSuccess(user, userToken, data['message']);
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
