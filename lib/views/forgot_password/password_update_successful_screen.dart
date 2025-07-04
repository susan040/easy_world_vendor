import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/views/auth/login_screen.dart';
import 'package:easy_world_vendor/widgets/custom/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PasswordUpdateSuccessfulScreen extends StatelessWidget {
  const PasswordUpdateSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/password_success.svg",
              height: 100,
              width: 100,
            ),
            SizedBox(height: 16),
            Text(
              "Successful",
              style: CustomTextStyles.f14W500(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Congratulations! Your password has been\nchanged. Click continue to login",
              style: CustomTextStyles.f12W400(
                height: 1.65,
                color:
                    isDark
                        ? AppColors.extraWhite.withOpacity(0.7)
                        : AppColors.secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 50),
              child: CustomElevatedButton(
                title: "Login",
                onTap: () {
                  Get.offAll(() => LoginScreen());
                },
                backGroundColor: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
