import 'dart:developer';
import 'package:easy_world_vendor/models/users.dart';
import 'package:easy_world_vendor/utils/storage_keys.dart';
import 'package:easy_world_vendor/views/auth/login_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
}
