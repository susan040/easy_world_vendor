import 'package:easy_world_vendor/controller/dashboard/exchange_rate_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/home_screen_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletWidget extends StatelessWidget {
  WalletWidget({super.key, required this.isDark});

  final bool isDark;
  final homeController = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor.withOpacity(0.9),
            AppColors.secondaryColor.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.transparent : AppColors.lGrey,
            blurRadius: 3,
            spreadRadius: 3,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.extraWhite.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.extraWhite.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white30),
                ),
                child: Text(
                  "Active",
                  style: CustomTextStyles.f12W600(color: AppColors.extraWhite),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Wallet Balance",
            style: CustomTextStyles.f14W400(color: Colors.white70),
          ),
          const SizedBox(height: 2),
          Obx(() {
            final exchangeRateController = Get.put(ExchangeRateController());
            final rawEarnings =
                homeController.earningDetails.value?.netEarnings;
            if (rawEarnings == null) return SizedBox.shrink();

            final double earningsDouble = double.tryParse(rawEarnings) ?? 0.0;
            final convertedPrice = exchangeRateController
                .convertPriceFromAUD(earningsDouble.toString())
                .toStringAsFixed(2);

            final code = exchangeRateController.selectedCountryData['code'];
            final symbol = code == 'NPR' ? 'Rs.' : '\$';

            return Text(
              "$symbol$convertedPrice",
              style: CustomTextStyles.f32W700(color: AppColors.extraWhite),
            );
          }),
          const SizedBox(height: 6),
          const Text(
            "Available for withdrawal",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 14,
              fontFamily: "Robot0",
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;

  const InfoRow({
    Key? key,
    required this.label,
    required this.value,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              "$label:",
              style: CustomTextStyles.f12W600(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
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

class HistoryRow extends StatelessWidget {
  final double amount;
  final String status;
  final String date;
  final bool isDark;

  const HistoryRow({
    Key? key,
    required this.amount,
    required this.status,
    required this.date,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;

    switch (status) {
      case "Paid":
        icon = Icons.check_circle_outline;
        color = Colors.green;
        break;
      case "Pending":
        icon = Icons.timelapse;
        color = Colors.orange;
        break;
      case "Rejected":
        icon = Icons.cancel_outlined;
        color = Colors.red;
        break;
      default:
        icon = Icons.info_outline;
        color = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color:
            isDark
                ? AppColors.blackColor.withOpacity(0.2)
                : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 25),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  final exchangeRateController = Get.put(
                    ExchangeRateController(),
                  );
                  final convertedPrice = exchangeRateController
                      .convertPriceFromAUD(amount.toString())
                      .toStringAsFixed(2);
                  final code =
                      exchangeRateController.selectedCountryData['code'];
                  final symbol = code == 'NPR' ? 'Rs.' : '\$';
                  return Text(
                    "$symbol$convertedPrice",
                    style: CustomTextStyles.f14W600(
                      color:
                          isDark ? AppColors.extraWhite : AppColors.blackColor,
                    ),
                  );
                }),

                Text(
                  date,
                  style: CustomTextStyles.f12W400(
                    color: AppColors.secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(status, style: CustomTextStyles.f11W600(color: color)),
          ),
        ],
      ),
    );
  }
}
