import 'package:easy_world_vendor/controller/dashboard/exchange_rate_controller.dart';
import 'package:easy_world_vendor/models/products.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key, required this.isDark, required this.products});

  final bool isDark;
  final Data? products;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Unit Price",
              style: CustomTextStyles.f12W400(
                color:
                    isDark
                        ? AppColors.extraWhite.withOpacity(0.7)
                        : AppColors.secondaryTextColor,
              ),
            ),

            Obx(() {
              final exchangeRateController = Get.put(ExchangeRateController());
              final convertedPrice = exchangeRateController
                  .convertPriceFromAUD(products!.costPrice)
                  .toStringAsFixed(2);
              final code = exchangeRateController.selectedCountryData['code'];
              final symbol = code == 'NPR' ? 'Rs.' : '\$';
              return Text(
                "$symbol$convertedPrice",
                style: CustomTextStyles.f14W700(
                  color:
                      isDark
                          ? AppColors.primaryColor
                          : AppColors.secondaryColor,
                ),
              );
            }),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Purchase Price",
                style: CustomTextStyles.f12W400(
                  color:
                      isDark
                          ? AppColors.extraWhite.withOpacity(0.7)
                          : AppColors.secondaryTextColor,
                ),
              ),

              Obx(() {
                final exchangeRateController = Get.put(
                  ExchangeRateController(),
                );
                final convertedPrice = exchangeRateController
                    .convertPriceFromAUD(products!.price)
                    .toStringAsFixed(2);
                final code = exchangeRateController.selectedCountryData['code'];
                final symbol = code == 'NPR' ? 'Rs.' : '\$';
                return Text(
                  "$symbol$convertedPrice",
                  style: CustomTextStyles.f14W700(
                    color:
                        isDark
                            ? AppColors.primaryColor
                            : AppColors.secondaryColor,
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
