import 'dart:io';

import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileScreenController extends GetxController {
  final editProfileFormKey = GlobalKey<FormState>();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  RxString selectGender = ''.obs;
  final selectBirthdayController = TextEditingController();
  var desireDate = DateTime.now().obs;

  final List<String> genderList = ['Female', 'Male'];

  void updateSelectedGender(String value) {
    selectGender.value = value;
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

  chooseDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.primaryColor,
            hintColor: AppColors.primaryColor,
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child ?? Container(),
        );
      },
    );

    if (pickedDate != null) {
      desireDate.value = pickedDate;
      selectBirthdayController.text = desireDate.value.toString().split(" ")[0];
    }
  }

  // var pdfFileName = ''.obs;
  // Rx<File?> selectedPdfFile = Rx<File?>(null);
  // Future<void> pickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
  //   );

  //   if (result != null && result.files.single.path != null) {
  //     File file = File(result.files.single.path!);
  //     pdfFileName.value = result.files.single.name;
  //     selectedPdfFile.value = file;
  //   } else {
  //     pdfFileName.value = '';
  //     selectedPdfFile.value = null;
  //   }
  // }
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
}
