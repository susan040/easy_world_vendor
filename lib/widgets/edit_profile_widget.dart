import 'package:easy_world_vendor/controller/dashboard/profile_screen_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileBottomSheetWidget extends StatelessWidget {
  const EditProfileBottomSheetWidget({
    super.key,
    required this.isDark,
    required this.c,
  });

  final bool isDark;
  final ProfileScreenController c;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              Icons.photo,
              size: 24,
              color:
                  isDark
                      ? AppColors.extraWhite
                      : AppColors.blackColor.withOpacity(0.7),
            ),
            title: Text(
              'Gallery',
              style: CustomTextStyles.f14W400(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
            ),
            onTap: () {
              Get.back();
              c.pickImage(ImageSource.gallery);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.camera_alt,
              size: 24,
              color:
                  isDark
                      ? AppColors.extraWhite
                      : AppColors.blackColor.withOpacity(0.7),
            ),
            title: Text(
              'Camera',
              style: CustomTextStyles.f14W400(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
            ),
            onTap: () {
              Get.back();
              c.pickImage(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }
}
