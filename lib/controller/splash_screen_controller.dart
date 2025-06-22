import 'dart:async';
import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/views/auth/login_screen.dart';
import 'package:easy_world_vendor/views/dash_screen.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  final coreController = Get.put(CoreController());
  @override
  void onInit() {
    Timer(const Duration(seconds: 5), () async {
      if (coreController.isUserLoggendIn()) {
        Get.offAll(() => DashScreen());
      } else {
        Get.offAll(() => LoginScreen());
      }
    });
    super.onInit();
  }
}
