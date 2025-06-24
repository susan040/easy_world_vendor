import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_world_vendor/models/orders.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
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

    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 6),
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
                        color:
                            isDark
                                ? AppColors.extraWhite
                                : AppColors.blackColor,
                      ),
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
                      const SizedBox(width: 115),
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
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${orders.items!.first.price ?? ""}",
                        style: CustomTextStyles.f16W600(
                          color: AppColors.primaryColor,
                        ),
                      ),
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
          OrderRowItem("Subtotal (1 items)", "\$20.00"),
          SizedBox(height: 12),
          OrderRowItem("Shipping Fee", "\$20.00"),
          SizedBox(height: 12),
          OrderRowItem(
            "App Voucher",
            "-\$${getDiscountAmount(orders.voucher)}",
            isRejected: true,
          ),
          SizedBox(height: 12),
          OrderRowItem("Shipping Fee Voucher", "-\$4.00", isRejected: true),
          SizedBox(height: 12),
          OrderRowItem("Total", "\$${orders.totalAmount ?? ""}", isBold: true),

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
        isDark
            ? AppColors.extraWhite.withOpacity(0.7)
            : AppColors.secondaryTextColor;

    // Determine rightText color based on status
    Color getRightTextColor() {
      switch (rightText.toLowerCase()) {
        case 'pending':
          return AppColors.yellow;
        case 'seller to pack':
          return AppColors.primaryColor;
        case 'packed':
          return AppColors.lightblue;
        case 'delivered':
          return AppColors.accepted;
        case 'cancelled':
          return AppColors.redColor;
        case 'to pay':
          return Colors.brown;
        default:
          return isRejected
              ? AppColors.rejected
              : (rightBold && isBold ? textColor : secondaryColor);
      }
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
          rightText,
          style: CustomTextStyles.f12W400(color: getRightTextColor()),
        ),
      ],
    );
  }
}
