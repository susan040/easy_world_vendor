import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/models/users.dart';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:easy_world_vendor/utils/http_request.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class EditProfileRepo {
  static Future<void> editProfile({
    required String storeName,
    required String storeDesc,
    required String phoneNumber,
    File? image,
    File? registrationDoc,
    required Function(UsersDetails user, String token, String message)
    onSuccess,
    required Function(String message) onError,
  }) async {
    var coreController = Get.find<CoreController>();
    var token = coreController.currentUser.value!.token.toString();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.parse(Api.editProfileUrl);
    http.MultipartRequest request = http.MultipartRequest("POST", url);
    request.headers.addAll((headers));
    request.fields['store_name'] = storeName;
    request.fields['store_description'] = storeDesc;
    request.fields['phone'] = phoneNumber;
    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "profile_image",
          image.path,
          contentType: MediaType("image", "*"),
        ),
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
    http.StreamedResponse response = await HttpRequestEasyWorld.multiPart(
      request,
    );
    var responseData = await response.stream.bytesToString();
    var data = jsonDecode(responseData);
    log("User data:$data");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      String accessToken = data["token"].toString();
      UsersDetails user = UsersDetails.fromJson(data);
      log(UsersDetails.fromJson(data["data"]).toString());
      onSuccess(user, accessToken, data['message']);
    } else {
      onError(data['message']);
    }
  }
}

class EditCountryPreferenceRepo {
  static Future<void> editCountryPreferenceRepo({
    required String countryPreference,
    required Function(UsersDetails user, String token, String message)
    onSuccess,
    required Function(String message) onError,
  }) async {
    var coreController = Get.find<CoreController>();
    var token = coreController.currentUser.value!.token.toString();
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = {"currency_preference": countryPreference};
    log("Body $body");
    http.Response response = await http.post(
      Uri.parse(Api.editProfileUrl),
      headers: headers,
      body: body,
    );
    dynamic data = jsonDecode(response.body);
    log("data $data");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      String accessToken = data["token"].toString();
      UsersDetails user = UsersDetails.fromJson(data);
      log(UsersDetails.fromJson(data["data"]).toString());
      onSuccess(user, accessToken, data['message']);
    } else {
      onError(data['message']);
    }
  }
}
