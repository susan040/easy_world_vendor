import 'dart:io';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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

  final pdfFileName = ''.obs;
  final selectedFilePath = ''.obs;

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf'],
    );
    if (result != null && result.files.single.path != null) {
      selectedFilePath.value = result.files.single.path!;
      pdfFileName.value = result.files.single.name;
    }
  }

  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();
  Future<void> pickImage(ImageSource source) async {
    final status =
        source == ImageSource.camera
            ? await Permission.camera.request()
            : await Permission.photos.request();

    if (status.isGranted) {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } else {
      CustomSnackBar.error(
        title: "Permission Denied",
        message: "Please enable permission from settings.",
      );
    }
  }
}
