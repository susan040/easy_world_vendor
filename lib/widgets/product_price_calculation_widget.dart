import 'package:easy_world_vendor/controller/dashboard/exchange_rate_controller.dart';
import 'package:easy_world_vendor/models/products.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPriceCalculationWidget extends StatelessWidget {
  const ProductPriceCalculationWidget({
    super.key,
    required this.products,
    required this.isDark,
    required this.quantity,
    required this.exchangeRateController,
    required this.discountPercent,
  });

  final Data? products;
  final bool isDark;
  final int quantity;
  final ExchangeRateController exchangeRateController;
  final double discountPercent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.star, size: 16, color: AppColors.amberYellow),
            Text(
              "${products?.averageRating ?? ""} (${products?.totalReviews ?? ""} reviews)",
              style: CustomTextStyles.f12W400(
                color:
                    isDark
                        ? AppColors.extraWhite
                        : AppColors.secondaryTextColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  Text(
                    "|  ",
                    style: CustomTextStyles.f12W400(
                      color:
                          isDark
                              ? AppColors.extraWhite
                              : AppColors.secondaryTextColor,
                    ),
                  ),
                  Text(
                    quantity > 5
                        ? "${products?.quantity} Left"
                        : "Only ${products?.quantity} left",
                    style: CustomTextStyles.f12W400(
                      color:
                          quantity > 5
                              ? AppColors.primaryColor
                              : AppColors.rejected,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Obx(() {
              final convertedPrice = exchangeRateController
                  .convertPriceFromAUD(products?.discountTotalAmount ?? "0")
                  .toStringAsFixed(2);
              final code = exchangeRateController.selectedCountryData['code'];
              final symbol = code == 'NPR' ? 'Rs.' : '\$';
              return Text(
                "$symbol$convertedPrice",
                style: CustomTextStyles.f16W700(
                  color:
                      isDark
                          ? AppColors.primaryColor
                          : AppColors.secondaryColor,
                ),
              );
            }),
            const SizedBox(width: 6),

            if (products?.discount != null &&
                products?.discountType != null &&
                products?.discountTotalAmount != null)
              Row(
                children: [
                  Obx(() {
                    final convertedPrice = exchangeRateController
                        .convertPriceFromAUD(products?.price ?? "0")
                        .toStringAsFixed(2);
                    final code =
                        exchangeRateController.selectedCountryData['code'];
                    final symbol = code == 'NPR' ? 'Rs.' : '\$';
                    return Text(
                      "$symbol$convertedPrice",
                      style: const TextStyle(
                        color: AppColors.textGreyColor,
                        fontSize: 12,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.lineThrough,
                      ),
                      overflow: TextOverflow.ellipsis,
                    );
                  }),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 3,
                      right: 3,
                      top: 1,
                      bottom: 1,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.rejected,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Center(
                      child: Text(
                        "-${discountPercent.toStringAsFixed(0)}%",
                        style: CustomTextStyles.f10W400(
                          color: AppColors.extraWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
