import 'package:easy_world_vendor/controller/dashboard/add_bank_account_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/payout_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/widgets/bank_account_details_widget.dart';
import 'package:easy_world_vendor/widgets/custom/custom_textfield.dart';
import 'package:easy_world_vendor/widgets/request_payout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPayoutScreen extends StatelessWidget {
  RequestPayoutScreen({super.key});
  final c = Get.put(AddBankAccountController());
  final controller = Get.put(PayoutController());
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Request Payout",
          style: CustomTextStyles.f16W600(
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            isDark ? AppColors.darkModeColor : AppColors.extraWhite,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WalletWidget(isDark: isDark),
            SizedBox(height: 16),
            BankAccountDetailsWidget(isDark: isDark),
            const SizedBox(height: 10),
            Container(
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
                padding: const EdgeInsets.only(
                  left: 14,
                  right: 14,
                  top: 10,
                  bottom: 13,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.request_page_outlined,
                          size: 22,
                          color:
                              isDark ? AppColors.darkblue : AppColors.fieldVist,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Request Payout",
                          style: CustomTextStyles.f14W600(
                            color:
                                isDark
                                    ? AppColors.extraWhite
                                    : AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    SizedBox(height: 10),
                    Form(
                      key: controller.payoutFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            labelText: "Amount to Withdraw",
                            preIconPath: Icons.attach_money,
                            hint: "Enter Amount to withdraw",
                            controller: controller.amountController,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                controller.requestPayout();
                              },
                              icon: const Icon(
                                Icons.send,
                                size: 16,
                                color: AppColors.extraWhite,
                              ),
                              label: Text(
                                "Submit Request",
                                style: CustomTextStyles.f12W600(
                                  color: AppColors.extraWhite,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            Text(
              "Payout History",
              style: CustomTextStyles.f14W600(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
            ),
            const SizedBox(height: 8),
            // HistoryRow(
            //   amount: 150,
            //   status: "Paid",
            //   date: "2025-06-01",
            //   isDark: isDark,
            // ),
            // HistoryRow(
            //   amount: 100,
            //   status: "Pending",
            //   date: "2025-05-25",
            //   isDark: isDark,
            // ),
            // HistoryRow(
            //   amount: 80,
            //   status: "Rejected",
            //   date: "2025-05-10",
            //   isDark: isDark,
            // ),
            Obx(
              () =>
                  controller.isLoading.value
                      ? Center(
                        child: CircularProgressIndicator(
                          color:
                              isDark
                                  ? AppColors.extraWhite
                                  : AppColors.blackColor,
                        ),
                      )
                      : controller.payoutList.isEmpty
                      ? Center(
                        child: Text(
                          "No payout history available.",
                          style: CustomTextStyles.f12W600(
                            color: AppColors.secondaryTextColor,
                          ),
                        ),
                      )
                      : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.payoutList.length,
                        itemBuilder: (context, index) {
                          final payout = controller.payoutList[index];
                          return HistoryRow(
                            amount:
                                double.tryParse(payout.amount.toString()) ??
                                0.0,
                            status: payout.status ?? "Unknown",
                            date: payout.createdAt ?? "Unknown",
                            isDark: isDark,
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
