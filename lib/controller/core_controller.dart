import 'dart:convert';
import 'dart:developer';
import 'package:easy_world_vendor/models/users.dart';
import 'package:easy_world_vendor/utils/api.dart';
import 'package:easy_world_vendor/utils/storage_keys.dart';
import 'package:easy_world_vendor/views/auth/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class CoreController extends GetxController {
  Rx<UsersDetails?> currentUser = Rxn<UsersDetails>();
  Rx<String> userToken = "".obs;

  @override
  void onInit() async {
    await loadCurrentUser();
    super.onInit();
  }

  Future<void> loadCurrentUser() async {
    currentUser.value = StorageHelper.getUser();
    userToken.value = StorageHelper.getToken() ?? "";
    log("User token--${userToken.value}--");
    log("email: ${currentUser.value?.data?.email ?? 'No email'}");

    if (userToken.value.isNotEmpty) {
      final deviceToken = await FirebaseMessaging.instance.getToken();
      if (deviceToken != null) {
        log("FCM Device Token: $deviceToken");
        await sendDeviceTokenToServer(deviceToken, userToken.value);
      } else {
        log("❌ Failed to get device token");
      }
    }
  }

  bool isUserLoggendIn() {
    return currentUser.value != null;
  }

  Future<void> logOut() async {
    final box = GetStorage();
    try {
      final googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
        log("✅ Google account signed out");
      }
    } catch (e) {
      log("❌ Google sign-out failed: $e");
    }
    await box.write(StorageKeys.USER, null);
    await box.write(StorageKeys.ACCESS_TOKEN, null);
    Get.offAll(() => LoginScreen());
  }

  Future<void> sendDeviceTokenToServer(
    String deviceToken,
    String authToken,
  ) async {
    final url = Uri.parse(Api.fcmTokenUrl);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({'device_token': deviceToken}),
    );

    if (response.statusCode == 200) {
      log('Device token sent successfully');
    } else {
      log(
        'Failed to send device token: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
