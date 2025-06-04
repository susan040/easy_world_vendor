import 'dart:async';
import 'package:easy_world_vendor/views/auth/login_screen.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    Timer(const Duration(seconds: 6), () async {
      Get.offAll(() => LoginScreen());
    });
    super.onInit();
  }
}
