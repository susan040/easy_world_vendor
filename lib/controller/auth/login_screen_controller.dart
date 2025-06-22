import 'dart:convert';
import 'dart:developer';

import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/repo/login_repo.dart';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
import 'package:easy_world_vendor/utils/storage_keys.dart';
import 'package:easy_world_vendor/views/dash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class LoginScreenController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool passwordObscure = true.obs;
  RxBool isChecked = false.obs;

  void onEyeCLick() {
    passwordObscure.value = !passwordObscure.value;
  }

  final loading = SimpleFontelicoProgressDialog(
    context: Get.context!,
    barrierDimisable: false,
  );
  void onSubmit() async {
    if (loginFormKey.currentState!.validate()) {
      loading.show(message: 'Loading...');

      await LoginRepo.loginRepo(
        email: emailController.text,
        password: passwordController.text,
        onSuccess: (user, token) async {
          loading.hide();
          final box = GetStorage();
          await box.write(StorageKeys.USER, json.encode(user.toJson()));
          await box.write(StorageKeys.ACCESS_TOKEN, token);
          log("Login Success ${user.token} ${user.data?.email}");
          Get.put(CoreController()).loadCurrentUser();
          Get.offAll(() => DashScreen());
          CustomSnackBar.success(title: "Login", message: "Login Successful");
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Login", message: message);
        },
      );
    }
  }
}
