import 'package:easy_world_vendor/controller/auth/forgot_password_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/widgets/custom/custom_textfield.dart';
import 'package:easy_world_vendor/widgets/custom/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEmailScreen extends StatelessWidget {
  final c = Get.put(ForgotPasswordController());
  AddEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Add Email",
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
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forgot password",
              style: CustomTextStyles.f14W500(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "Please enter your email to reset the password",
              style: CustomTextStyles.f12W400(
                color:
                    isDark
                        ? AppColors.extraWhite.withOpacity(0.7)
                        : AppColors.secondaryTextColor,
              ),
            ),
            SizedBox(height: 25),
            Text(
              "Your Email",
              style: CustomTextStyles.f12W500(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
            ),
            SizedBox(height: 8),
            CustomTextField(
              hint: "Enter your email",
              controller: c.emailController,
              textCapitalization: TextCapitalization.none,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(height: 24),
            CustomElevatedButton(
              title: "Reset Password",
              onTap: () {
                c.requestForgotPassword();
              },
              backGroundColor: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
