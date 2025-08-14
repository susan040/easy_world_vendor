import 'package:easy_world_vendor/controller/dashboard/order_screen_controller.dart';
import 'package:easy_world_vendor/models/orders.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/views/dashboard/order_tracking_screen.dart';
import 'package:easy_world_vendor/widgets/custom/elevated_button.dart';
import 'package:easy_world_vendor/widgets/order_history_details_widget.dart';
import 'package:easy_world_vendor/widgets/order_payment_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderHistoryDetailScreen extends StatelessWidget {
  final int orderId;

  OrderHistoryDetailScreen({Key? key, required this.orderId}) : super(key: key);

  final controller = Get.find<OrderScreenController>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
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
      body: SafeArea(
        child: Obx(() {
          final orders = controller.allOrderLists.firstWhereOrNull(
            (o) => o.id == orderId,
          );

          if (orders == null) {
            return Center(child: Text("Order not found"));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 14,
                    right: 14,
                    top: 6,
                    bottom: 6,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? AppColors.blackColor.withOpacity(0.3)
                            : AppColors.extraWhite,
                    boxShadow: [
                      BoxShadow(
                        color:
                            isDark ? AppColors.darkModeColor : AppColors.lGrey,
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
                            "Deliver to: ${orders.customer?.fullName ?? "No Name"}",
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
                                orders.billingAddress?.type?.capitalizeFirst ??
                                    "",
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
                        [
                              orders.billingAddress?.street,
                              orders.billingAddress?.addressLine1,
                              orders.billingAddress?.city,
                              orders.billingAddress?.province,
                              orders.billingAddress?.country,
                            ]
                            .where((e) => e != null && e.trim().isNotEmpty)
                            .join(', '),
                        style: CustomTextStyles.f11W400(
                          color:
                              isDark
                                  ? AppColors.extraWhite
                                  : AppColors.secondaryColor,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        orders.customer?.phone ?? "",
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
                // ["packed", "shipped", "delivered"].contains(orders.status)
                //     ?
                //     : SizedBox.shrink(),
                Container(
                  margin: const EdgeInsets.only(right: 14, left: 14, top: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 9,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? AppColors.blackColor.withOpacity(0.3)
                            : AppColors.extraWhite,
                    boxShadow: [
                      BoxShadow(
                        color:
                            isDark ? AppColors.darkModeColor : AppColors.lGrey,
                        spreadRadius: 1.5,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orders.orderNo ?? "Order No Unknown",
                              style: CustomTextStyles.f14W400(
                                color:
                                    isDark
                                        ? AppColors.extraWhite
                                        : AppColors.blackColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Status: ${orders.status ?? 'Pending Pickup'}",
                              style: CustomTextStyles.f12W400(
                                color:
                                    isDark
                                        ? AppColors.borderColor
                                        : AppColors.secondaryTextColor,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Customer: ${orders.customer?.fullName ?? 'Anonymous'}",
                              style: CustomTextStyles.f12W400(
                                color:
                                    isDark
                                        ? AppColors.borderColor
                                        : AppColors.secondaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                isDark
                                    ? AppColors.lightblue
                                    : AppColors.secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onPressed: () {
                            Get.to(
                              () => SellerOrderTrackingScreen(
                                orderNo: orders.orderNo ?? '',
                                currentStatus: orders.status ?? '',
                              ),
                            );
                          },
                          child: Text(
                            "View Details",
                            style: CustomTextStyles.f11W500(
                              color: AppColors.extraWhite,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                OrderHistoryDetailsWidget(isDark: isDark, orders: orders),

                Container(
                  margin: EdgeInsets.only(left: 14, right: 14, bottom: 16),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? AppColors.blackColor.withOpacity(0.3)
                            : AppColors.extraWhite,
                    boxShadow: [
                      BoxShadow(
                        color:
                            isDark ? AppColors.darkModeColor : AppColors.lGrey,
                        spreadRadius: 1.5,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OrderRowItem(
                        "Placed on",
                        DateFormat(
                          'yyyy-MM-dd HH:mm:ss',
                        ).format(DateTime.parse(orders.createdAt ?? "")),
                      ),
                      orders.status != "pending" &&
                              orders.payments?.first.createdAt != null
                          ? Column(
                            children: [
                              SizedBox(height: 12),
                              OrderRowItem(
                                "Paid on",
                                orders.payments?.first.createdAt ?? "",
                              ),
                            ],
                          )
                          : SizedBox.shrink(),

                      SizedBox(height: 12),
                      OrderRowItem(
                        "Order Status",
                        "${orders.status}".capitalizeFirst ?? "",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget buildOrderActionButtons(Orders orders, bool isDark) {
    final lowerStatus = orders.status?.toLowerCase() ?? '';
    final controller = Get.find<OrderScreenController>();
    const EdgeInsets padding = EdgeInsets.only(
      left: 16,
      right: 16,
      top: 20,
      bottom: 30,
    );

    Widget buildCancelButton() {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primaryColor, width: 1.5),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          onPressed: () {
            controller.changeStatus(orders.id.toString(), "cancelled");
          },
          child: Text(
            "Cancel",
            style: CustomTextStyles.f12W600(color: AppColors.primaryColor),
          ),
        ),
      );
    }

    if (lowerStatus == 'pending') {
      return Padding(padding: padding, child: buildCancelButton());
    }

    if (lowerStatus == 'paid') {
      return Padding(
        padding: padding,
        child: CustomElevatedButton(
          title: "Pack",
          onTap: () {
            controller.changeStatus(orders.id.toString(), "packed");
          },
          backGroundColor: AppColors.primaryColor,
        ),
      );
    }

    if (lowerStatus == 'packed') {
      return Padding(
        padding: padding,
        child: CustomElevatedButton(
          title: "Mark as Delivered",
          onTap: () {
            controller.changeStatus(orders.id.toString(), "delivered");
          },
          backGroundColor: AppColors.primaryColor,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
