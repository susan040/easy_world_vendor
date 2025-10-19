import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_world_vendor/controller/dashboard/exchange_rate_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/order_screen_controller.dart';
import 'package:easy_world_vendor/models/orders.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:easy_world_vendor/widgets/order_payment_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistoryDetailsWidget extends StatelessWidget {
  OrderHistoryDetailsWidget({
    super.key,
    required this.isDark,
    required this.orders,
  });

  final bool isDark;
  final Orders orders;
  final orderController = Get.put(OrderScreenController());
  final exchangeRateController = Get.put(ExchangeRateController());
  @override
  Widget build(BuildContext context) {
    double getVoucherDiscount(Voucher? voucher, double totalAmount) {
      if (voucher == null) return 0.0;

      double value = double.tryParse(voucher.value.toString()) ?? 0.0;
      double minPrice = double.tryParse(voucher.minPurchase ?? "0") ?? 0.0;

      if (totalAmount < minPrice) return 0.0;

      if (voucher.type == "percentage") {
        return (totalAmount * value) / 100;
      } else if (voucher.type == "fixed") {
        return value;
      }

      return 0.0;
    }

    // double getPromoDiscount(PromoCode? promo, double totalAmount) {
    //   if (promo == null) return 0.0;

    //   double value = double.tryParse(promo.value.toString()) ?? 0.0;
    //   double minOrder = double.tryParse(promo.minOrderAmount ?? "0") ?? 0.0;

    //   if (totalAmount < minOrder) return 0.0;

    //   if (promo.type == "percentage") {
    //     return (totalAmount * value) / 100;
    //   } else if (promo.type == "fixed") {
    //     return value;
    //   }

    //   return 0.0;
    // }

    return Container(
      margin: EdgeInsets.only(left: 14, right: 14, bottom: 8),
      padding: EdgeInsets.only(left: 14, right: 14, top: 14, bottom: 12),
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
          Text(
            "Order Items",
            style: CustomTextStyles.f14W700(
              color: isDark ? AppColors.extraWhite : AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 8),
          ...?orders.items?.map((item) {
            final product = item.product;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      imageUrl: product?.productImages?.first ?? "",
                      fit: BoxFit.cover,
                      height: 65,
                      width: 60,
                      placeholder:
                          (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                      errorWidget:
                          (context, url, error) =>
                              Image.asset(ImagePath.noImage, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product?.name ?? 'Product name',
                          style: CustomTextStyles.f13W600(
                            height: 1.2,
                            color:
                                isDark
                                    ? AppColors.extraWhite
                                    : AppColors.blackColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Size: ${item.size ?? 'size'} | Color: ${item.color ?? 'Color'}",
                              style: CustomTextStyles.f12W400(
                                color:
                                    isDark
                                        ? AppColors.extraWhite
                                        : AppColors.secondaryTextColor,
                              ),
                            ),
                            Text(
                              "Qty: ${item.quantity ?? ""}",
                              style: CustomTextStyles.f12W400(
                                color:
                                    isDark
                                        ? AppColors.extraWhite
                                        : AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() {
                              final exchangeRateController = Get.put(
                                ExchangeRateController(),
                              );
                              final convertedPrice = exchangeRateController
                                  .convertPriceFromAUD(item.price.toString())
                                  .toStringAsFixed(2);
                              final code =
                                  exchangeRateController
                                      .selectedCountryData['code'];
                              final symbol = code == 'NPR' ? 'Rs.' : '\$';
                              return Text(
                                "$symbol$convertedPrice",
                                style: CustomTextStyles.f14W600(
                                  color:
                                      isDark
                                          ? AppColors.primaryColor
                                          : AppColors.secondaryColor,
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          Divider(),
          SizedBox(height: 6),
          LabelValueRow(
            label: "Order No:",

            valueWidget: Text(
              "${orders.orderNo ?? ""}",
              style: CustomTextStyles.f13W600(color: AppColors.primaryColor),
            ),
            isBold: true,
          ),
          // AmountRow(
          //   title:
          //       "Subtotal (${orderController.calculateTotalQuantity(orders.items ?? [])} items)",
          //   amount: subtotal,
          //   isDark: isDark,
          // ),
          LabelValueRow(
            label:
                "Subtotal (${orderController.calculateTotalQuantity(orders.items ?? [])} items)",
            valueWidget: Obx(() {
              final code = exchangeRateController.selectedCountryData['code'];
              final subtotal = orderController.calculateSubtotal(
                orders.items ?? [],
              );
              final converted = exchangeRateController
                  .convertPriceFromAUD(subtotal.toString())
                  .toStringAsFixed(2);
              return Text(
                "${code == 'NPR' ? 'Rs.' : '\$'}$converted",
                style: CustomTextStyles.f13W400(
                  color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                ),
              );
            }),
          ),
          AmountRow(
            title: "Shipping Fee",
            amount: double.tryParse(orders.totalShippingAmount ?? "0") ?? 0.0,
            isDark: isDark,
          ),
          SizedBox(height: 12),
          LabelValueRow(
            label: "Voucher",
            valueWidget: Obx(() {
              final code = exchangeRateController.selectedCountryData['code'];
              final subtotal = orderController.calculateSubtotal(
                orders.items ?? [],
              );
              final converted = exchangeRateController
                  .convertPriceFromAUD(
                    getVoucherDiscount(orders.voucher, subtotal).toString(),
                  )
                  .toStringAsFixed(2);
              return Text(
                "- ${code == 'NPR' ? 'Rs.' : '\$'}$converted",
                style: CustomTextStyles.f13W400(color: AppColors.rejected),
              );
            }),
          ),

          // LabelValueRow(
          //   label: "Promocode",
          //   valueWidget: Obx(() {
          //     final code = exchangeRateController.selectedCountryData['code'];
          //     final subtotal = orderController.calculateSubtotal(
          //       orders.items ?? [],
          //     );
          //     final converted = exchangeRateController
          //         .convertPriceFromAUD(
          //           getPromoDiscount(orders.promocode, subtotal).toString(),
          //         )
          //         .toStringAsFixed(2);
          //     return Text(
          //       "- ${code == 'NPR' ? 'Rs.' : '\$'}$converted",
          //       style: CustomTextStyles.f13W400(color: AppColors.rejected),
          //     );
          //   }),
          // ),
          AmountRow(
            title: "Total",
            amount: double.tryParse(orders.totalAmount ?? "0") ?? 0.0,
            isBold: true,
            isDark: isDark,
          ),
          SizedBox(height: 8),
          (orders.status != "pending" && orders.status != "cancelled") &&
                  (orders.payments != null &&
                      orders.payments!.isNotEmpty &&
                      orders.payments!.first.paymentMethod != null)
              ? Column(
                children: [
                  Divider(),
                  SizedBox(height: 8),
                  LabelValueRow(
                    label: "Payment method",
                    isBold: true,
                    valueWidget: Text(
                      orders.payments!.first.paymentMethod!.capitalizeFirst ??
                          "",
                      style: CustomTextStyles.f12W600(
                        color: AppColors.darkGreen,
                      ),
                    ),
                  ),
                  Divider(),
                ],
              )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
