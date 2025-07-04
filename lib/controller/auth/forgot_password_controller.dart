import 'dart:async';
import 'package:easy_world_vendor/repo/forgot_password_repo.dart';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
import 'package:easy_world_vendor/views/forgot_password/new_password_screen.dart';
import 'package:easy_world_vendor/views/forgot_password/password_update_successful_screen.dart';
import 'package:easy_world_vendor/views/forgot_password/verify_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ForgotPasswordController extends GetxController {
  // final signUpFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();
  RxBool passwordObscure = true.obs;
  RxBool confirmObscure = true.obs;
  final loading = SimpleFontelicoProgressDialog(
    context: Get.context!,
    barrierDimisable: false,
  );
  final confirmPasswordController = TextEditingController();
  void passwordOnEyeCLick() {
    passwordObscure.value = !passwordObscure.value;
  }

  void confirmPasswordOnEyeCLick() {
    confirmObscure.value = !confirmObscure.value;
  }

  void requestForgotPassword() async {
    loading.show(message: "Please wait..");

    await RequestForgotPasswordRepo.requestForgotPasswordRepo(
      email: emailController.text,
      onSuccess: (message) async {
        loading.hide();
        Get.to(() => VerifyEmailScreen());
        CustomSnackBar.success(title: "Password", message: message);
      },
      onError: (message) {
        loading.hide();
        CustomSnackBar.error(title: "Password", message: message);
      },
    );
  }

  var isForgotOtpLoading = false.obs;
  var canResendForgotOtp = true.obs;
  var forgotOtpTimer = 30.obs;
  Timer? forgotOtpCountdownTimer;

  void resendOtpForForgotPassword() async {
    if (!canResendForgotOtp.value) return;

    isForgotOtpLoading.value = true;
    canResendForgotOtp.value = false;
    forgotOtpTimer.value = 30;
    startForgotOtpTimer();

    await RequestForgotPasswordRepo.requestForgotPasswordRepo(
      email: emailController.text,
      onSuccess: (message) async {
        isForgotOtpLoading.value = false;
        CustomSnackBar.success(title: "Email", message: message);
      },
      onError: (message) {
        isForgotOtpLoading.value = false;
        CustomSnackBar.error(title: "Email", message: message);
      },
    );
  }

  void startForgotOtpTimer() {
    forgotOtpCountdownTimer?.cancel();
    forgotOtpCountdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (forgotOtpTimer.value == 0) {
        timer.cancel();
        canResendForgotOtp.value = true;
      } else {
        forgotOtpTimer.value--;
      }
    });
  }

  void forgotPasswordVerifyOtp() async {
    loading.show(message: "Please wait..");

    await ForgetPasswordVerifyOtpRepo.forgetPasswordVerifyOtpRepo(
      email: emailController.text,
      otp: otpController.text,
      onSuccess: (message) async {
        loading.hide();
        Get.to(() => NewPasswordScreen());
        CustomSnackBar.success(title: "Password", message: message);
      },
      onError: (message) {
        loading.hide();
        CustomSnackBar.error(title: "Password", message: message);
      },
    );
  }

  void resetPassword() async {
    loading.show(message: "Please wait..");

    await ResetPasswordRepo.resetPasswordRepo(
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      onSuccess: (message) async {
        loading.hide();
        Get.offAll(() => PasswordUpdateSuccessfulScreen());
        CustomSnackBar.success(title: "Password", message: message);
        emailController.clear();
        otpController.clear();
      },
      onError: (message) {
        loading.hide();
        CustomSnackBar.error(title: "Password", message: message);
      },
    );
  }
}
