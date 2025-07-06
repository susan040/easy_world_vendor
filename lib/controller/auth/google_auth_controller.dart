import 'dart:convert';
import 'dart:developer';

import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/repo/sign_with_google_repo.dart';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
import 'package:easy_world_vendor/utils/storage_keys.dart';
import 'package:easy_world_vendor/views/dash_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class GoogleAuthController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Rx<GoogleSignInAccount?> googleUser = Rx<GoogleSignInAccount?>(null);

  final isDarkMode = Get.isDarkMode;
  late final SimpleFontelicoProgressDialog loading;

  @override
  void onInit() {
    super.onInit();
    loading = SimpleFontelicoProgressDialog(
      context: Get.context!,
      barrierDimisable: false,
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      loading.show(message: 'Signing in with Google...');

      final account = await _googleSignIn.signIn();
      if (account == null) {
        loading.hide();
        Get.snackbar("Cancelled", "Google sign-in was cancelled");
        return;
      }

      googleUser.value = account;
      final auth = await account.authentication;
      final idToken = auth.idToken;
      final accessToken = auth.accessToken;

      if (idToken == null || accessToken == null) {
        loading.hide();
        Get.snackbar("Error", "Failed to retrieve Google credentials");
        return;
      }

      log("✅ Google Sign-In Details:");
      log("Name: ${account.displayName}");
      log("Email: ${account.email}");
      log("Photo: ${account.photoUrl}");
      log("ID Token: $idToken");
      log("Access Token: $accessToken");

      await SignWithGoogleRepo.signWithGoogleRepo(
        idToken: accessToken,
        onSuccess: (user, userToken, message) async {
          loading.hide();

          final box = GetStorage();
          await box.write(StorageKeys.USER, json.encode(user.toJson()));
          await box.write(StorageKeys.ACCESS_TOKEN, userToken);

          log("🟢 Login Success: ${user.token} - ${user.data?.email}");

          if (user.data?.approved == false) {
            CustomSnackBar.info(
              title: "Google Account",
              message: "Please wait for admin approval.",
            );
            return;
          } else {
            Get.put(CoreController()).loadCurrentUser();
            Get.offAll(() => DashScreen());
            CustomSnackBar.success(title: "Welcome", message: message);
          }
        },
        onError: (msg) {
          loading.hide();
          CustomSnackBar.error(title: "Login Failed", message: msg);
        },
      );
    } catch (e, s) {
      loading.hide();
      log("❌ Exception: $e");
      log("🧵 Stacktrace: $s");
      CustomSnackBar.error(
        title: "Error",
        message: "Google Sign-In failed. Please try again.",
      );
    }
  }
}
