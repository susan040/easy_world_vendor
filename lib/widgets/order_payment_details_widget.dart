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

class LabelValueRow extends StatelessWidget {
  final String label;
  final Widget valueWidget;
  final bool isBold;
  final bool isRejected;
  final bool showMinus;

  const LabelValueRow({
    super.key,
    required this.label,
    required this.valueWidget,
    this.isBold = false,
    this.isRejected = false,
    this.showMinus = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final labelStyle =
        isBold
            ? CustomTextStyles.f12W600(
              color: isDark ? AppColors.extraWhite : AppColors.blackColor,
            )
            : CustomTextStyles.f12W400(
              color: isDark ? AppColors.extraWhite : AppColors.blackColor,
            );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: labelStyle), valueWidget],
      ),
    );
  }
}
