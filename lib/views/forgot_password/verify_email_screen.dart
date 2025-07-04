import 'package:easy_world_vendor/controller/auth/forgot_password_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/widgets/custom/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyEmailScreen extends StatelessWidget {
  final c = Get.put(ForgotPasswordController());
  VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Verify Email",
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
              "Check your email",
              style: CustomTextStyles.f14W500(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "We sent a reset link to alpha...@gmail.com\nenter 5 digit code that mentioned in the email",
              style: CustomTextStyles.f12W400(
                color:
                    isDark
                        ? AppColors.extraWhite.withOpacity(0.7)
                        : AppColors.secondaryTextColor,
              ),
            ),
            SizedBox(height: 30),
            PinCodeTextField(
              appContext: context,
              length: 6,
              textStyle: CustomTextStyles.f12W400(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
              controller: c.otpController,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                activeBorderWidth: 1,
                inactiveBorderWidth: 1,
                selectedBorderWidth: 1,
                fieldHeight: 38,
                fieldWidth: 38,
                activeFillColor: AppColors.extraWhite,
                selectedColor: AppColors.primaryColor,
                inactiveColor: AppColors.grey,
              ),
              animationDuration: Duration(milliseconds: 300),
              enableActiveFill: false,
              onCompleted: (value) {
                print("OTP: $value");
              },
              onChanged: (value) {},
            ),
            SizedBox(height: 20),
            CustomElevatedButton(
              title: "Verify Code",
              onTap: () {
                c.forgotPasswordVerifyOtp();
              },
              backGroundColor: AppColors.primaryColor,
            ),
            SizedBox(height: 30),
            Obx(
              () => InkWell(
                onTap:
                    c.canResendForgotOtp.value
                        ? c.resendOtpForForgotPassword
                        : null,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text:
                          c.canResendForgotOtp.value
                              ? "Didn't get the code? "
                              : "Resend available in ${c.forgotOtpTimer.value}s ",
                      style: CustomTextStyles.f12W400(
                        color:
                            isDark
                                ? AppColors.extraWhite
                                : AppColors.secondaryTextColor,
                      ),
                      children:
                          c.canResendForgotOtp.value
                              ? [
                                TextSpan(
                                  text: 'Resend',
                                  style: CustomTextStyles.f12W500(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ]
                              : [],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
