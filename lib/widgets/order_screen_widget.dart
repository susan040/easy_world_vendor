import 'package:easy_world_vendor/controller/dashboard/exchange_rate_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/order_screen_controller.dart';
import 'package:easy_world_vendor/models/orders.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/views/dashboard/orders_history_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderCardWidget extends StatelessWidget {
  final bool isDark;
  final Orders orders;
  final c = Get.put(OrderScreenController());
  OrderCardWidget({required this.isDark, super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 10),
      child: InkWell(
        onTap: () {
          Get.to(
            () => OrderHistoryDetailScreen(
              orderId: int.parse(orders.id.toString()),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          width: double.infinity,
          decoration: BoxDecoration(
            color:
                isDark
                    ? AppColors.blackColor.withOpacity(0.3)
                    : AppColors.extraWhite,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.transparent : AppColors.lGrey,
                blurRadius: 1.5,
                spreadRadius: 2.5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orders.customer?.fullName ?? "No Name",
                            style: CustomTextStyles.f16W600(
                              color:
                                  isDark
                                      ? AppColors.extraWhite
                                      : AppColors.blackColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Order No: ${orders.orderNo ?? ""}",
                            style: CustomTextStyles.f13W400(
                              color:
                                  isDark
                                      ? AppColors.extraWhite.withOpacity(0.7)
                                      : AppColors.secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      orders.status?.toLowerCase() == "paid"
                          ? "Seller to pack"
                          : "${orders.status}".capitalizeFirst ?? "",
                      style: CustomTextStyles.f12W600(
                        color: c.getStatusColor(orders.status ?? ""),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    c.getOrderStatusText(orders.status ?? ""),
                    style: CustomTextStyles.f13W400(
                      color:
                          isDark
                              ? AppColors.extraWhite.withOpacity(0.7)
                              : AppColors.secondaryTextColor,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    orders.createdAt != null && orders.createdAt!.isNotEmpty
                        ? DateFormat('d MMM yyyy hh:mm a').format(
                          DateTime.parse(orders.createdAt ?? "").toLocal(),
                        )
                        : '',
                    style: CustomTextStyles.f12W400(
                      color:
                          isDark
                              ? AppColors.extraWhite.withOpacity(0.7)
                              : AppColors.secondaryTextColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    final exchangeRateController = Get.put(
                      ExchangeRateController(),
                    );
                    final convertedPrice = exchangeRateController
                        .convertPriceFromAUD(orders.totalAmount ?? "")
                        .toStringAsFixed(2);
                    final code =
                        exchangeRateController.selectedCountryData['code'];
                    final symbol = code == 'NPR' ? 'Rs.' : '\$';
                    return Text(
                      "$symbol$convertedPrice",
                      style: CustomTextStyles.f16W600(
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
      ),
    );
  }
}
