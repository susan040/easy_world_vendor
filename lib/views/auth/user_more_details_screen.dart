import 'package:dotted_border/dotted_border.dart';
import 'package:easy_world_vendor/controller/auth/register_screen_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/widgets/custom/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserMoreDetailsScreen extends StatelessWidget {
  final c = Get.put(RegisterScreenController());
  UserMoreDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Other Details",
          style: CustomTextStyles.f16W600(
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            isDark ? AppColors.darkModeColor : AppColors.extraWhite,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upload Shop Document file/image",
                  style: CustomTextStyles.f14W500(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 10),
                Obx(() {
                  final file = c.selectedDocFile.value;

                  if (file != null) {
                    final isPdf = file.path.toLowerCase().endsWith('.pdf');

                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color:
                            isDark
                                ? AppColors.darkModeColor
                                : AppColors.extraWhite,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 170,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color:
                                  isDark
                                      ? AppColors.blackColor.withOpacity(0.2)
                                      : AppColors.extraWhite,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child:
                                isPdf
                                    ? const Center(
                                      child: Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.red,
                                        size: 60,
                                      ),
                                    )
                                    : ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        file,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: GestureDetector(
                              onTap: () {
                                c.pdfFileName.value = '';
                                c.selectedDocFile.value = null;
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.grey,
                                ),
                                padding: const EdgeInsets.all(2),
                                child: const Icon(
                                  Icons.close,
                                  color: AppColors.blackColor,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Show dotted upload area
                    return GestureDetector(
                      onTap: () => c.pickFile(),
                      child: DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          color:
                              isDark
                                  ? AppColors.extraWhite.withOpacity(0.7)
                                  : AppColors.secondaryTextColor,
                          strokeWidth: 1,
                          dashPattern: [8, 4],
                          radius: const Radius.circular(5),
                          padding: const EdgeInsets.all(16),
                        ),
                        child: Container(
                          height: 160,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload_file,
                                size: 28,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Upload shop documents \nfile or image",
                                style: CustomTextStyles.f11W400(
                                  color: Colors.grey.shade600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
                const SizedBox(height: 20),
                Text(
                  "Upload Shop Logo",
                  style: CustomTextStyles.f14W500(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 10),
                Obx(() {
                  return c.selectedImage.value == null
                      ? GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color:
                                    isDark
                                        ? AppColors.blackColor
                                        : AppColors.extraWhite,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.camera_alt,
                                      color:
                                          isDark
                                              ? AppColors.extraWhite
                                              : AppColors.blackColor,
                                      size: 24,
                                    ),
                                    title: Text(
                                      "Take Photo",
                                      style: CustomTextStyles.f14W400(
                                        color:
                                            isDark
                                                ? AppColors.extraWhite
                                                : AppColors.blackColor,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                      c.pickImage(ImageSource.camera);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.photo_library,
                                      color:
                                          isDark
                                              ? AppColors.extraWhite
                                              : AppColors.blackColor,
                                      size: 24,
                                    ),
                                    title: Text(
                                      "Choose from Gallery",
                                      style: CustomTextStyles.f14W400(
                                        color:
                                            isDark
                                                ? AppColors.extraWhite
                                                : AppColors.blackColor,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                      c.pickImage(ImageSource.gallery);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: DottedBorder(
                          options: RoundedRectDottedBorderOptions(
                            color:
                                isDark
                                    ? AppColors.extraWhite.withOpacity(0.7)
                                    : AppColors.secondaryTextColor,
                            strokeWidth: 1,
                            dashPattern: [8, 4],
                            radius: const Radius.circular(5),
                            padding: const EdgeInsets.all(16),
                          ),
                          child: Container(
                            height: 160,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: AppColors.primaryColor,
                                  size: 28,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Tap to upload shop \nlogo",
                                  style: CustomTextStyles.f11W400(
                                    color: Colors.grey.shade600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      : Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color:
                              isDark
                                  ? AppColors.darkModeColor
                                  : AppColors.extraWhite,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              height: 170,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: FileImage(c.selectedImage.value!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: GestureDetector(
                                onTap: () {
                                  c.selectedImage.value = null;
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.grey,
                                  ),
                                  padding: const EdgeInsets.all(2),
                                  child: const Icon(
                                    Icons.close,
                                    color: AppColors.blackColor,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                }),
                SizedBox(height: 40),
                CustomElevatedButton(
                  title: "Submit",
                  onTap: () {
                    if (c.selectedDocFile.value != null &&
                        c.selectedImage.value != null) {
                      c.onSubmit();
                    } else {
                      CustomSnackBar.error(
                        title: "Register",
                        message: "Please provide document and image.",
                      );
                    }
                  },
                  backGroundColor: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
