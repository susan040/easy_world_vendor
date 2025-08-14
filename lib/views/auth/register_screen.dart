import 'package:easy_world_vendor/controller/auth/google_auth_controller.dart';
import 'package:easy_world_vendor/controller/auth/register_screen_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:easy_world_vendor/utils/validator.dart';
import 'package:easy_world_vendor/views/auth/login_screen.dart';
import 'package:easy_world_vendor/views/auth/user_more_details_screen.dart';
import 'package:easy_world_vendor/widgets/custom/custom_password_fields.dart';
import 'package:easy_world_vendor/widgets/custom/custom_textfield.dart';
import 'package:easy_world_vendor/widgets/custom/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final c = Get.put(RegisterScreenController());
  final controller = Get.put(GoogleAuthController());
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Sign Up",
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
      body: SingleChildScrollView(
        child: Form(
          key: c.signUpFormKey,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 10,
              bottom: 24,
            ),
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
                SizedBox(height: 6),
                CustomTextField(
                  controller: c.fullNameController,
                  hint: "Enter your Full Name",
                  validator: Validators.checkFieldEmpty,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: c.emailController,
                  validator: Validators.checkEmailField,
                  hint: "Enter your email",
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.none,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                Obx(
                  () => Container(
                    constraints: BoxConstraints(minHeight: 50),
                    child: DropdownButtonFormField<String>(
                      menuMaxHeight: 350,
                      dropdownColor:
                          isDark ? AppColors.blackColor : AppColors.extraWhite,
                      focusColor:
                          isDark ? AppColors.blackColor : AppColors.extraWhite,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      value:
                          c.selectCountryCode.value.isEmpty
                              ? null
                              : c.selectCountryCode.value,
                      hint: Text(
                        "Select country code",
                        style: CustomTextStyles.f12W400(
                          color:
                              isDark
                                  ? AppColors.extraWhite
                                  : AppColors.secondaryTextColor,
                        ),
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(
                          bottom: 10,
                          left: 14,
                          right: 14,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.borderColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                      ),
                      items:
                          c.countryCodeList
                              .map(
                                (option) => DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(
                                    option,
                                    style: CustomTextStyles.f12W400(),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        c.updateSelectedCountryCode(value!);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: c.phoneNumberController,
                  hint: "Enter your Phone number",
                  validator: Validators.checkPhoneField,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 16),
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
                SizedBox(height: 16),
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
                SizedBox(height: 16),
                TextFormField(
                  style: CustomTextStyles.f12W400(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),

                  maxLines: 4,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: "Store Description..",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.borderColor,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.errorColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.errorColor,
                      ),
                    ),
                    hintStyle: CustomTextStyles.f12W400(
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                  controller: c.storeDescController,
                ),

                SizedBox(height: 20),
                CustomElevatedButton(
                  title: "Next",
                  onTap: () {
                    if (c.signUpFormKey.currentState!.validate()) {
                      Get.to(() => UserMoreDetailsScreen());
                    }
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
                              "Sign Up with google",
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
                SizedBox(height: 45),
                InkWell(
                  onTap: () {
                    Get.offAll(() => LoginScreen());
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
                          text: 'Login',
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
