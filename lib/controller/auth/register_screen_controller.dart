import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreenController extends GetxController {
  final signUpFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();
  RxBool passwordObscure = true.obs;
  RxBool confirmObscure = true.obs;

  RxBool isChecked = false.obs;
  final confirmPasswordController = TextEditingController();
  void passwordOnEyeCLick() {
    passwordObscure.value = !passwordObscure.value;
  }

  void confirmPasswordOnEyeCLick() {
    confirmObscure.value = !confirmObscure.value;
  }

  var pdfFileName = ''.obs;
  Rx<File?> selectedPdfFile = Rx<File?>(null);
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
    );

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      pdfFileName.value = result.files.single.name;
      selectedPdfFile.value = file;
    } else {
      pdfFileName.value = '';
      selectedPdfFile.value = null;
    }
  }
}
