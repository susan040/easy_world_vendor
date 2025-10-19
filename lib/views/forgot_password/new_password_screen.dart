import 'package:easy_world_vendor/utils/validator.dart';
import 'package:easy_world_vendor/widgets/custom/custom_password_fields.dart';
import 'package:get/get.dart';
import 'package:easy_world_vendor/controller/auth/forgot_password_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/widgets/custom/elevated_button.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatelessWidget {
  final c = Get.put(ForgotPasswordController());
  NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "New password",
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
              "Set a new password",
              style: CustomTextStyles.f14W500(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "Create a new password. Ensure it differs from\nprevious ones for security",
              style: CustomTextStyles.f13W400(
                color:
                    isDark
                        ? AppColors.extraWhite.withOpacity(0.7)
                        : AppColors.secondaryTextColor,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Password",
              style: CustomTextStyles.f13W500(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
            ),
            SizedBox(height: 8),
            Obx(
              () => CustomPasswordField(
                validator: Validators.checkPasswordField,
                hint: "Enter password",
                eye: c.passwordObscure.value,
                onEyeClick: c.passwordOnEyeCLick,
                controller: c.passwordController,
                textInputAction: TextInputAction.done,
              ),
            ),
            SizedBox(height: 14),
            Text(
              "Confirm Password",
              style: CustomTextStyles.f13W500(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
            ),
            SizedBox(height: 8),
            Obx(
              () => CustomPasswordField(
                validator:
                    (value) => Validators.checkConfirmPassword(
                      c.passwordController.text,
                      value,
                    ),
                hint: "Enter confirm password",
                eye: c.confirmObscure.value,
                onEyeClick: c.confirmPasswordOnEyeCLick,
                controller: c.confirmPasswordController,
                textInputAction: TextInputAction.done,
              ),
            ),
            SizedBox(height: 25),
            CustomElevatedButton(
              title: "Update Password",
              onTap: () {
                c.resetPassword();
              },
              backGroundColor: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
