import 'package:easy_world_vendor/controller/dashboard/exchange_rate_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmountRow extends StatelessWidget {
  final String title;
  final double amount;
  final bool isDiscount;
  final bool isBold;
  final bool isDark;

  const AmountRow({
    super.key,
    required this.title,
    required this.amount,
    this.isDiscount = false,
    this.isBold = false,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final exchangeRateController = Get.put(ExchangeRateController());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              isBold
                  ? CustomTextStyles.f12W600(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  )
                  : CustomTextStyles.f12W400(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
        ),
        Obx(() {
          final convertedPrice = exchangeRateController
              .convertPriceFromAUD(amount.toString())
              .toStringAsFixed(2);
          final code = exchangeRateController.selectedCountryData['code'];
          final symbol = code == 'NPR' ? 'Rs.' : '\$';
          final text = "${isDiscount ? '-' : ''}$symbol$convertedPrice";

          return Text(
            text,
            style:
                isDiscount
                    ? CustomTextStyles.f12W400(color: AppColors.rejected)
                    : isBold
                    ? CustomTextStyles.f12W600(
                      color:
                          isDark ? AppColors.extraWhite : AppColors.blackColor,
                    )
                    : CustomTextStyles.f12W400(
                      color:
                          isDark ? AppColors.extraWhite : AppColors.blackColor,
                    ),
          );
        }),
      ],
    );
  }
}

class OrderRowItem extends StatelessWidget {
  final String leftText;
  final String rightText;
  final bool isBold;
  final bool isRejected;
  final bool rightBold;

  const OrderRowItem(
    this.leftText,
    this.rightText, {
    super.key,
    this.isBold = false,
    this.isRejected = false,
    this.rightBold = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color textColor =
        isDark ? AppColors.extraWhite : AppColors.blackColor;
    final Color secondaryColor =
        isDark ? AppColors.extraWhite.withOpacity(0.7) : AppColors.blackColor;

    // Decide the color based on the original status
    Color getRightTextColor() {
      switch (rightText.toLowerCase()) {
        case 'pending':
          return AppColors.yellow;
        case 'paid':
          return AppColors.skyBlue;
        case 'packed':
          return AppColors.lightblue;
        case 'in transit':
          return AppColors.darkblue;
        case 'delivered':
          return AppColors.accepted;
        case 'cancelled':
          return AppColors.redColor;
        case 'paypal':
          return AppColors.lightGreen;
        default:
          return isRejected
              ? AppColors.rejected
              : (rightBold && isBold ? textColor : secondaryColor);
      }
    }

    String getDisplayText() {
      if (rightText.toLowerCase() == 'paid') {
        return 'Seller to pack';
      }
      return rightText.capitalizeFirst ?? '';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText,
          style:
              isBold
                  ? CustomTextStyles.f12W600(color: textColor)
                  : CustomTextStyles.f12W400(color: textColor),
        ),
        Text(
          getDisplayText(),
          style: CustomTextStyles.f12W400(color: getRightTextColor()),
        ),
      ],
    );
  }
}
