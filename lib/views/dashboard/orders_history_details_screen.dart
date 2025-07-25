import 'package:easy_world_vendor/controller/dashboard/order_screen_controller.dart';
import 'package:easy_world_vendor/models/orders.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/widgets/custom/elevated_button.dart';
import 'package:easy_world_vendor/widgets/order_history_details_widget.dart';
import 'package:easy_world_vendor/widgets/order_payment_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: Obx(() {
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
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Deliver to: ${orders.customer?.fullName ?? ""}",
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

              OrderHistoryDetailsWidget(isDark: isDark, orders: orders),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                    OrderRowItem("Placed on", "2025 May 01 09:00:00"),
                    SizedBox(height: 12),
                    OrderRowItem("Paid on", "2025 May 01 09:02:00"),
                    SizedBox(height: 12),
                    OrderRowItem("Order Status", "${orders.status ?? ""}"),
                  ],
                ),
              ),

              buildOrderActionButtons(orders, isDark),
            ],
          ),
        );
      }),
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
        child: Column(
          children: [
            CustomElevatedButton(
              title: "Accept",
              onTap: () {
                controller.changeStatus(orders.id.toString(), "seller to pack");
              },
              backGroundColor: AppColors.primaryColor,
            ),
            const SizedBox(height: 6),
            buildCancelButton(),
          ],
        ),
      );
    }

    if (lowerStatus == 'seller to pack') {
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
