import 'package:easy_world_vendor/controller/theme_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Settings",
          style: CustomTextStyles.f16W600(
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor:
            isDark ? AppColors.darkModeColor : AppColors.extraWhite,
        elevation: 0,
      ),
      body: Column(
        children: [
          Text("Profile"),
          Row(
            children: [
              Text("Mode"),
              FlutterSwitch(
                width: 65,
                height: 26,
                value: isDark,
                borderRadius: 30,
                activeColor: AppColors.secondaryColor,
                inactiveColor: AppColors.extraWhite,
                switchBorder: Border.all(
                  width: 1,
                  color:
                      isDark ? AppColors.blackColor : AppColors.secondaryColor,
                ),
                activeText: "ON",
                inactiveText: "OFF",
                activeTextColor: AppColors.extraWhite,
                inactiveTextColor: AppColors.secondaryColor,
                activeTextFontWeight: FontWeight.normal,
                inactiveTextFontWeight: FontWeight.normal,
                valueFontSize: 13,
                toggleColor:
                    isDark ? AppColors.extraWhite : AppColors.secondaryColor,
                showOnOff: true,
                onToggle: themeController.toggleTheme,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
