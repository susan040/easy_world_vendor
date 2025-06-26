import 'dart:convert';
import 'dart:io';
import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/repo/edit_profile_repo.dart';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
import 'package:easy_world_vendor/utils/storage_keys.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ProfileScreenController extends GetxController {
  final editProfileFormKey = GlobalKey<FormState>();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();
  RxString profileImageUrl = ''.obs;
  final storeNameController = TextEditingController();
  final storeDescriptionController = TextEditingController();
  final phoneNumberController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    userDetails();
  }

  void userDetails() {
    var user = Get.find<CoreController>().currentUser.value!.data;
    if (user != null) {
      storeNameController.text = user.storeName ?? "";
      phoneNumberController.text = user.phone ?? "";
      storeDescriptionController.text = user.storeDescription ?? "";
      profileImageUrl.value = user.profileImage ?? "";
      selectedFilePath.value = user.documentRegistration ?? "";
      if ((user.documentRegistration ?? '').isNotEmpty) {
        selectedFilePath.value = user.documentRegistration!;
      }
    }
  }

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

  final loading = SimpleFontelicoProgressDialog(
    context: Get.context!,
    barrierDimisable: false,
  );
  void editProfile() async {
    if (editProfileFormKey.currentState!.validate()) {
      loading.show(message: "Please wait..");
      await EditProfileRepo.editProfile(
        storeName: storeNameController.text,
        storeDesc: storeDescriptionController.text,
        phoneNumber: phoneNumberController.text,
        image: selectedImage.value,
        registrationDoc:
            selectedFilePath.value.isNotEmpty &&
                    !selectedFilePath.value.startsWith("http")
                ? File(selectedFilePath.value)
                : null,
        onSuccess: (user, token, message) async {
          loading.hide();

          final box = GetStorage();
          final coreController = Get.put(CoreController());
          final storedToken = coreController.currentUser.value?.token;
          if (user.token == null || user.token!.isEmpty) {
            user.token = storedToken;
          }

          await box.write(StorageKeys.USER, json.encode(user.toJson()));
          await box.write(StorageKeys.ACCESS_TOKEN, user.token);
          coreController.currentUser.value = user;
          userDetails();
          Get.put(CoreController()).loadCurrentUser();
          Get.back();
          CustomSnackBar.success(title: "Profile", message: message);
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Profile", message: message);
        },
      );
    }
  }
}
