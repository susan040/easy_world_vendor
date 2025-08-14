import 'package:easy_world_vendor/controller/auth/google_auth_controller.dart';
import 'package:easy_world_vendor/controller/auth/login_screen_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:easy_world_vendor/utils/validator.dart';
import 'package:easy_world_vendor/views/auth/register_screen.dart';
import 'package:easy_world_vendor/views/forgot_password/add_email_screen.dart';
import 'package:easy_world_vendor/widgets/custom/custom_password_fields.dart';
import 'package:easy_world_vendor/widgets/custom/custom_textfield.dart';
import 'package:easy_world_vendor/widgets/custom/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final c = Get.put(LoginScreenController());
  final controller = Get.put(GoogleAuthController());
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Login",
          style: CustomTextStyles.f16W600(
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            isDark ? AppColors.darkModeColor : AppColors.extraWhite,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: c.loginFormKey,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (isDark)
                  SvgPicture.asset(
                    ImagePath.secondaryLogo,
                    height: 192,
                    width: 192,
                  )
                else
                  SvgPicture.asset(ImagePath.logo, height: 192, width: 192),
                SizedBox(height: 16),
                CustomTextField(
                  hint: "Enter your email",
                  controller: c.emailController,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.none,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                Obx(
                  () => CustomPasswordField(
                    validator: Validators.checkPasswordField,
                    hint: "Enter password",
                    eye: c.passwordObscure.value,
                    onEyeClick: c.onEyeCLick,
                    controller: c.passwordController,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => AddEmailScreen());
                      },
                      child: Text(
                        "Forgot password?",
                        style: CustomTextStyles.f12W400(
                          color:
                              isDark
                                  ? AppColors.extraWhite
                                  : AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomElevatedButton(
                  title: "Login",
                  onTap: () {
                    c.onSubmit();
                  },
                  backGroundColor: AppColors.primaryColor,
                ),
                SizedBox(height: 14),
                Text(
                  "or",
                  style: CustomTextStyles.f12W500(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 14),
                InkWell(
                  onTap: () {
                    controller.signInWithGoogle();
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 12),
                    height: 46,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:
                          isDark
                              ? AppColors.blackColor.withOpacity(0.1)
                              : AppColors.extraWhite,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 0.5,
                        color: isDark ? AppColors.grey : AppColors.blackColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          ImagePath.google,
                          height: 20,
                          width: 20,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Login with google",
                              style: CustomTextStyles.f12W400(
                                color:
                                    isDark
                                        ? AppColors.extraWhite
                                        : AppColors.blackColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 100),
                InkWell(
                  onTap: () {
                    Get.to(() => RegisterScreen());
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: CustomTextStyles.f12W400(
                        color:
                            isDark
                                ? AppColors.extraWhite
                                : AppColors.blackColor,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: CustomTextStyles.f12W500(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
