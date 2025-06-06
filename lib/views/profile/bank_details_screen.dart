import 'package:easy_world_vendor/controller/dashboard/add_bank_account_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/validator.dart';
import 'package:easy_world_vendor/widgets/custom/custom_textfield.dart';
import 'package:easy_world_vendor/widgets/custom/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBankDetailsScreen extends StatelessWidget {
  final c = Get.put(AddBankAccountController());

  AddBankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Add Bank Details",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
          child: Form(
            key: c.bankAccountformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account Holder Name",
                  style: CustomTextStyles.f14W500(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 6),
                CustomTextField(
                  hint: "Please enter account holder name",
                  validator: Validators.checkFieldEmpty,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 16),
                Text(
                  "Bank Name",
                  style: CustomTextStyles.f14W500(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 6),
                CustomTextField(
                  hint: "Please enter bank name",
                  validator: Validators.checkFieldEmpty,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 16),
                Text(
                  "Account Number",
                  style: CustomTextStyles.f14W500(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 6),
                CustomTextField(
                  hint: "Please enter account number",
                  validator: Validators.checkFieldEmpty,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 16),
                Text(
                  "IFSC or SWIFT code",
                  style: CustomTextStyles.f14W500(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 6),
                CustomTextField(
                  hint: "Please enter IFSC or SWIFT code",
                  validator: Validators.checkFieldEmpty,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 16),
                Text(
                  "Branch Name",
                  style: CustomTextStyles.f14W500(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 6),
                CustomTextField(
                  hint: "Branch Name (optional)",
                  validator: Validators.checkFieldEmpty,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),

                const SizedBox(height: 24),
                CustomElevatedButton(
                  title: "Save Details",
                  onTap: () {
                    if (c.bankAccountformKey.currentState!.validate()) {}
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
