import 'package:easy_world_vendor/controller/dashboard/add_bank_account_controller.dart';
import 'package:easy_world_vendor/models/bank_details.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/validator.dart';
import 'package:easy_world_vendor/widgets/custom/custom_textfield.dart';
import 'package:easy_world_vendor/widgets/custom/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBankDetailsScreen extends StatelessWidget {
  final c = Get.put(AddBankAccountController());

  EditBankDetailsScreen({super.key, required this.bankDetails});
  final BankDetails bankDetails;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accountHolderNameController = TextEditingController(
      text: bankDetails.accountHolderName,
    );
    final accountNoController = TextEditingController(
      text: bankDetails.accountNumber,
    );
    final branchNameController = TextEditingController(
      text: bankDetails.branchName,
    );
    if (c.selectedBankName.value.isEmpty && bankDetails.bankName != null) {
      c.updateSelectedBankName(bankDetails.bankName!);
    }
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Edit Bank Details",
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
            child: Form(
              key: c.editBankAccountFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account Holder Name",
                    style: CustomTextStyles.f14W500(
                      color:
                          isDark ? AppColors.extraWhite : AppColors.blackColor,
                    ),
                  ),
                  SizedBox(height: 6),
                  CustomTextField(
                    controller: accountHolderNameController,
                    hint: "Please enter account holder name",
                    validator: Validators.checkFieldEmpty,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Bank Name",
                    style: CustomTextStyles.f14W500(
                      color:
                          isDark ? AppColors.extraWhite : AppColors.blackColor,
                    ),
                  ),
                  SizedBox(height: 6),
                  Obx(
                    () => Container(
                      constraints: BoxConstraints(minHeight: 50),
                      child: DropdownButtonFormField<String>(
                        menuMaxHeight: 350,
                        isExpanded: true,
                        dropdownColor:
                            isDark
                                ? AppColors.blackColor
                                : AppColors.extraWhite,
                        focusColor:
                            isDark
                                ? AppColors.blackColor
                                : AppColors.extraWhite,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        value:
                            c.selectedBankName.value.isEmpty
                                ? null
                                : c.selectedBankName.value,
                        hint: Text(
                          "Please select bank name",
                          style: CustomTextStyles.f12W400(
                            color: AppColors.secondaryTextColor,
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
                            c.nepalInternationalBankList
                                .map(
                                  (option) => DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(
                                      option,
                                      style: CustomTextStyles.f12W400(
                                        color:
                                            isDark
                                                ? AppColors.extraWhite
                                                : AppColors.blackColor,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          c.updateSelectedBankName(value!);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Account Number",
                    style: CustomTextStyles.f14W500(
                      color:
                          isDark ? AppColors.extraWhite : AppColors.blackColor,
                    ),
                  ),
                  SizedBox(height: 6),
                  CustomTextField(
                    controller: accountNoController,
                    hint: "Please enter account number",
                    validator: Validators.checkFieldEmpty,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Branch Name",
                    style: CustomTextStyles.f14W500(
                      color:
                          isDark ? AppColors.extraWhite : AppColors.blackColor,
                    ),
                  ),
                  SizedBox(height: 6),
                  CustomTextField(
                    hint: "Branch Name",
                    controller: branchNameController,
                    validator: Validators.checkFieldEmpty,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),

                  const SizedBox(height: 24),
                  CustomElevatedButton(
                    title: "Update Details",
                    onTap: () {
                      c.editBankDetails(
                        accountHolderNameController.text,
                        accountNoController.text,
                        branchNameController.text,
                        bankDetails.id.toString(),
                      );
                    },
                    backGroundColor: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
