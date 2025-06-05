import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/widgets/custom/elevated_button.dart';
import 'package:easy_world_vendor/widgets/order_history_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistoryDetailScreen extends StatelessWidget {
  const OrderHistoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Order Details",
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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
              padding: EdgeInsets.only(left: 10, right: 10, top: 9, bottom: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color:
                    isDark
                        ? AppColors.blackColor.withOpacity(0.3)
                        : AppColors.extraWhite,
                boxShadow: [
                  BoxShadow(
                    color: isDark ? AppColors.darkModeColor : AppColors.lGrey,
                    spreadRadius: 1.5,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Deliver to: San Afzark",
                        style: CustomTextStyles.f12W700(
                          color:
                              isDark
                                  ? AppColors.extraWhite
                                  : AppColors.blackColor,
                        ),
                      ),
                      Container(
                        height: 18,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            "Home",
                            style: CustomTextStyles.f11W400(
                              color: AppColors.extraWhite,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    "123 George Street, Sydney NSW 2000, Australia",
                    style: CustomTextStyles.f11W400(
                      color:
                          isDark
                              ? AppColors.extraWhite
                              : AppColors.secondaryColor,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "+61 412 345 678",
                    style: CustomTextStyles.f11W300(
                      color:
                          isDark
                              ? AppColors.extraWhite
                              : AppColors.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
            OrderHistoryDetailsWidget(isDark: isDark),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 20),
              padding: EdgeInsets.only(
                left: 14,
                right: 14,
                top: 12,
                bottom: 12,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color:
                    isDark
                        ? AppColors.blackColor.withOpacity(0.3)
                        : AppColors.extraWhite,
                boxShadow: [
                  BoxShadow(
                    color: isDark ? AppColors.darkModeColor : AppColors.lGrey,
                    spreadRadius: 1.5,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderRowItem("Placed on", "2025 May 01 09:00:00"),
                  SizedBox(height: 12),
                  OrderRowItem("Paid on", "2025 May 01 09:02:00"),
                  SizedBox(height: 12),
                  OrderRowItem("Order Status", "Processing"),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 20,
                bottom: 30,
              ),
              child: CustomElevatedButton(
                title: "Pack",
                onTap: () {},
                backGroundColor: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
