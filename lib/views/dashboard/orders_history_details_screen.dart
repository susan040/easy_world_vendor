import 'package:easy_world_vendor/controller/dashboard/order_screen_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/views/dashboard/order_tracking_screen.dart';
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
                [
                      "paid",
                      "packed",
                      "shipped",
                      "delivered",
                    ].contains(orders.status)
                    ? Container(
                      margin: const EdgeInsets.only(
                        right: 14,
                        left: 14,
                        top: 4,
                        bottom: 10,
                      ),
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
                                isDark
                                    ? AppColors.darkModeColor
                                    : AppColors.lGrey,
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
                                  "${orders.orderNo ?? "Order No Unknown"}",
                                  style: CustomTextStyles.f12W700(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Status: ${orders.status ?? 'Pending Pickup'}",
                                  style: CustomTextStyles.f12W400(
                                    color: AppColors.accepted,
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
                                    orderId: int.parse(orders.id.toString()),
                                    trackingId: orders.orderTrackingId ?? '',
                                  ),
                                );
                              },
                              child: Text(
                                "Track Order",
                                style: CustomTextStyles.f11W500(
                                  color: AppColors.extraWhite,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    : SizedBox.shrink(),

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
                      // "Placed on"
                      LabelValueRow(
                        label: "Placed on",
                        isBold: false,
                        valueWidget: Text(
                          DateFormat('yyyy-MM-dd HH:mm:ss').format(
                            DateTime.parse(
                              orders.createdAt ?? '1970-01-01T00:00:00',
                            ),
                          ),
                          style: CustomTextStyles.f12W400(
                            color:
                                isDark
                                    ? AppColors.extraWhite
                                    : AppColors.blackColor,
                          ),
                        ),
                      ),

                      if (orders.status != null &&
                          orders.status!.toLowerCase() != "pending" &&
                          orders.status!.toLowerCase() != "cancelled" &&
                          orders.payments != null &&
                          orders.payments!.isNotEmpty &&
                          orders.payments!.first.createdAt != null)
                        LabelValueRow(
                          label: "Paid on",
                          isBold: false,
                          valueWidget: Text(
                            DateFormat('yyyy-MM-dd HH:mm:ss').format(
                              DateTime.parse(orders.payments!.first.createdAt!),
                            ),
                            style: CustomTextStyles.f12W400(
                              color:
                                  isDark
                                      ? AppColors.extraWhite
                                      : AppColors.blackColor,
                            ),
                          ),
                        ),
                      LabelValueRow(
                        label: "Order Status",
                        isBold: false,
                        valueWidget: Text(
                          orders.status?.toLowerCase() == "paid"
                              ? "Seller to pack"
                              : "${orders.status}".capitalizeFirst ?? "",
                          style: CustomTextStyles.f12W400(
                            color: controller.getStatusColor(
                              orders.status ?? "",
                            ),
                          ),
                        ),
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
}
