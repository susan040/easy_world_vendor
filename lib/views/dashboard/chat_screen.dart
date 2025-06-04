import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Chat",
          style: CustomTextStyles.f16W600(
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            isDark ? AppColors.darkModeColor : AppColors.extraWhite,
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
      ),
    );
  }
}
