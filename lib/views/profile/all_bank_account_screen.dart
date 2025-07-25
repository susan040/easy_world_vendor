import 'package:easy_world_vendor/controller/dashboard/add_bank_account_controller.dart';
import 'package:easy_world_vendor/models/bank_details.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/views/profile/edit_bank_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AllBankAccountScreen extends StatelessWidget {
  AllBankAccountScreen({super.key});
  final c = Get.put(AddBankAccountController());
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "All Bank Accounts",
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
      body: Obx(
        () =>
            c.isLoading.value
                ? SingleChildScrollView(
                  child: Shimmer.fromColors(
                    baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
                    highlightColor:
                        isDark ? Colors.grey[700]! : Colors.grey[100]!,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(5, (index) {
                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                            bottom: 12,
                            left: 14,
                            right: 14,
                          ),
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }),
                    ),
                  ),
                )
                : c.allBankDetailsLists.isEmpty
                ? SizedBox(
                  height: Get.height / 1.3,
                  child: Center(
                    child: Text(
                      "No bank details",
                      style: CustomTextStyles.f14W400(
                        color: AppColors.textGreyColor,
                      ),
                    ),
                  ),
                )
                : ListView.builder(
                  itemCount: c.allBankDetailsLists.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final BankDetails bankDetails =
                        c.allBankDetailsLists[index];

                    return BankDetailsCard(bank: bankDetails, isDark: isDark);
                  },
                ),
      ),
    );
  }
}

class BankDetailsCard extends StatelessWidget {
  final BankDetails bank;
  final bool isDark;
  const BankDetailsCard({super.key, required this.bank, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 14, right: 14, top: 4, bottom: 10),
      padding: const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                maxRadius: 14,
                backgroundColor: Colors.indigoAccent,
                child: Icon(
                  Icons.account_circle,
                  size: 22,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  bank.accountHolderName ?? 'Unknown',
                  style: CustomTextStyles.f16W600(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => EditBankDetailsScreen(bankDetails: bank));
                },
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(Icons.edit, color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          _labelValue("Bank", bank.bankName),
          _labelValue("Account No", bank.accountNumber),
          _labelValue("Branch", bank.branchName),
        ],
      ),
    );
  }

  Widget _labelValue(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              "$label: ",
              style: CustomTextStyles.f12W600(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? '-',
              style: CustomTextStyles.f12W400(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
