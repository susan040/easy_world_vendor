import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_world_vendor/controller/dashboard/exchange_rate_controller.dart';
import 'package:easy_world_vendor/models/orders.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:easy_world_vendor/widgets/order_payment_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistoryDetailsWidget extends StatelessWidget {
  const OrderHistoryDetailsWidget({
    super.key,
    required this.isDark,
    required this.orders,
  });

  final bool isDark;
  final Orders orders;
  @override
  Widget build(BuildContext context) {
    double getDiscountAmount(Voucher? voucher) {
      if (voucher == null) return 0.0;

      final minPrice = double.tryParse(voucher.minPurchase ?? "0") ?? 0.0;
      final value = double.tryParse(voucher.value.toString()) ?? 0.0;

      return voucher.type == "percentage"
          ? (minPrice * value) / 100
          : (voucher.type == "fixed" ? value : 0.0);
    }

    double subtotal =
        double.parse(orders.items!.first.price ?? "") *
        (double.parse(orders.items!.first.quantity ?? "1"));
    double total = subtotal + 20.00;
    double totalAmount = total - getDiscountAmount(orders.voucher);
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
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
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: orders.items!.first.product!.productImages!.first,
                  fit: BoxFit.fill,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width / 1.56,
                    child: Text(
                      orders.items!.first.product!.name ?? "",
                      style: CustomTextStyles.f11W600(
                        height: 1.2,
                        color:
                            isDark
                                ? AppColors.extraWhite
                                : AppColors.blackColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        orders.items!.first.product!.brand ?? "No Brand",
                        style: CustomTextStyles.f10W400(
                          color:
                              isDark
                                  ? AppColors.extraWhite
                                  : AppColors.secondaryTextColor,
                        ),
                      ),
                      const SizedBox(width: 110),
                      Text(
                        "Qty: ${orders.items!.first.quantity ?? ""}",
                        style: CustomTextStyles.f11W400(
                          color:
                              isDark
                                  ? AppColors.extraWhite
                                  : AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        final exchangeRateController = Get.put(
                          ExchangeRateController(),
                        );
                        final convertedPrice = exchangeRateController
                            .convertPriceFromAUD(orders.items!.first.price)
                            .toStringAsFixed(2);
                        final code =
                            exchangeRateController.selectedCountryData['code'];
                        final symbol = code == 'NPR' ? 'Rs.' : '\$';
                        return Text(
                          "$symbol$convertedPrice",
                          style: CustomTextStyles.f14W600(
                            color: AppColors.primaryColor,
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 6),
          Divider(),
          SizedBox(height: 6),
          OrderRowItem("Order No:", "${orders.orderNo ?? ""}", isBold: true),
          SizedBox(height: 12),
          AmountRow(
            title: "Subtotal (${orders.items?.first.quantity ?? 0} items)",
            amount: subtotal,
            isDark: isDark,
          ),
          SizedBox(height: 12),
          AmountRow(title: "Shipping Fee", amount: 20.00, isDark: isDark),
          SizedBox(height: 12),
          AmountRow(
            title: "App Voucher",
            amount: getDiscountAmount(orders.voucher),
            isDiscount: true,
            isDark: isDark,
          ),
          SizedBox(height: 12),
          AmountRow(
            title: "Shipping Voucher",
            amount: getDiscountAmount(orders.voucher),
            isDiscount: true,
            isDark: isDark,
          ),
          SizedBox(height: 12),
          AmountRow(
            title: "Total",
            amount: totalAmount,
            isBold: true,
            isDark: isDark,
          ),
          SizedBox(height: 12),
          Divider(),
          SizedBox(height: 8),

          OrderRowItem(
            "Payment method",
            "PayPal Mobile Wallet",
            isBold: true,
            rightBold: false,
          ),
          SizedBox(height: 8),
          Divider(),
        ],
      ),
    );
  }
}
