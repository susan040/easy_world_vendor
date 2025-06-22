import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class RegisterRepo {
  static Future<void> register({
    required String storeName,
    required String storeDesc,
    required String phone,
    required String email,
    required File? registrationDoc,
    required String password,
    required String confirmPassword,
    File? avatar,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {"Accept": "application/json"};

      var request = http.MultipartRequest('POST', Uri.parse(Api.registerUrl));
      request.headers.addAll(headers);

      request.fields['store_name'] = storeName;
      request.fields['store_description'] = storeDesc;
      request.fields['phone'] = phone;
      request.fields['email'] = email;
      request.fields['country_code'] = "+977";
      request.fields['password'] = password;
      request.fields['password_confirmation'] = confirmPassword;

      if (avatar!.existsSync()) {
        request.files.add(
          await http.MultipartFile.fromPath('profile_image', avatar.path),
        );
      }
      if (registrationDoc != null) {
        String fileExtension = extension(registrationDoc.path).toLowerCase();
        String mimeType = "application/octet-stream";

        if (fileExtension == ".png" ||
            fileExtension == ".jpg" ||
            fileExtension == ".jpeg") {
          mimeType = "image/${fileExtension.replaceAll('.', '')}";
        } else if (fileExtension == ".pdf") {
          mimeType = "document/pdf";
        }

        request.files.add(
          http.MultipartFile.fromBytes(
            "registration_document",
            await registrationDoc.readAsBytes(),
            contentType: MediaType.parse(mimeType),
            filename: basename(registrationDoc.path),
          ),
        );
      }
      http.Response response = await http.Response.fromStream(
        await request.send(),
      );

      dynamic data = jsonDecode(response.body);
      log("user Details${data}");
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
