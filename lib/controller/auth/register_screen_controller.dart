import 'dart:io';
import 'package:easy_world_vendor/repo/register_repo.dart';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
import 'package:easy_world_vendor/views/auth/login_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class RegisterScreenController extends GetxController {
  final signUpFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final storeDescController = TextEditingController();
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
  final Rx<File?> selectedDocFile = Rx<File?>(null);

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf'],
    );
    if (result != null && result.files.single.path != null) {
      selectedDocFile.value = File(result.files.single.path!); // ✅ File object
      pdfFileName.value = result.files.single.name; // just for display
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

  final loading = SimpleFontelicoProgressDialog(
    context: Get.context!,
    barrierDimisable: false,
  );

  void onSubmit() async {
    loading.show(message: 'Loading...');
    await RegisterRepo.register(
      storeName: fullNameController.text,
      storeDesc: storeDescController.text,
      phone: phoneNumberController.text,
      email: emailController.text,
      registrationDoc: selectedDocFile.value,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      avatar: selectedImage.value,
      onSuccess: (message) {
        loading.hide();
        Get.offAll(LoginScreen());
        CustomSnackBar.success(title: "Register", message: message);
      },
      onError: (message) {
        loading.hide();
        CustomSnackBar.error(title: "Register", message: message);
      },
    );
  }
}
