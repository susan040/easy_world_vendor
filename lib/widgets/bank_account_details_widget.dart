import 'package:easy_world_vendor/controller/dashboard/add_bank_account_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/views/profile/edit_bank_details_screen.dart';
import 'package:easy_world_vendor/widgets/request_payout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankAccountDetailsWidget extends StatelessWidget {
  BankAccountDetailsWidget({super.key, required this.isDark});

  final bool isDark;
  final c = Get.put(AddBankAccountController());
  // String maskAccountNumber(String accountNumber) {
  //   if (accountNumber.length <= 6) return accountNumber;
  //   final visibleDigits = accountNumber.substring(accountNumber.length - 6);
  //   return '**********$visibleDigits';
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            isDark
                ? AppColors.blackColor.withOpacity(0.3)
                : AppColors.extraWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.transparent : AppColors.lGrey,
            blurRadius: 2,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_balance,
                  size: 22,
                  color: isDark ? AppColors.accepted : AppColors.brown,
                ),
                SizedBox(width: 8),
                Text(
                  "Bank Account Details",
                  style: CustomTextStyles.f14W600(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            Obx(() {
              final bankDetails = c.allBankDetailsLists.value;

              if (bankDetails == null) {
                return SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      "No bank details",
                      style: CustomTextStyles.f12W400(
                        color: AppColors.textGreyColor,
                      ),
                    ),
                  ),
                );
              }

              final isDark = Theme.of(context).brightness == Brightness.dark;

              return Column(
                children: [
                  InfoRow(
                    label: "Bank",
                    value: bankDetails.bankName ?? "",
                    isDark: isDark,
                  ),
                  InfoRow(
                    label: "Account No",
                    value: bankDetails.accountNumber ?? "",
                    isDark: isDark,
                  ),
                  InfoRow(
                    label: "Name",
                    value: bankDetails.accountHolderName ?? "",
                    isDark: isDark,
                  ),
                  InfoRow(
                    label: "Branch",
                    value: bankDetails.branchName ?? "",
                    isDark: isDark,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {
                        Get.to(
                          () => EditBankDetailsScreen(bankDetails: bankDetails),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 18,
                        color: AppColors.primaryColor,
                      ),
                      label: Text(
                        "Edit Bank Details",
                        style: CustomTextStyles.f12W500(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
