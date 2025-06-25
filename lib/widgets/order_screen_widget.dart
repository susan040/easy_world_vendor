import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_world_vendor/controller/dashboard/order_screen_controller.dart';
import 'package:easy_world_vendor/models/orders.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:easy_world_vendor/views/dashboard/orders_history_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderCardWidget extends StatelessWidget {
  final bool isDark;
  final Orders orders;
  final c = Get.put(OrderScreenController());
  OrderCardWidget({required this.isDark, super.key, required this.orders});
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.yellow;
      case 'seller to pack':
        return AppColors.primaryColor;
      case 'confirmed':
        return AppColors.darkblue;
      case 'packed':
        return AppColors.lightblue;
      case 'delivered':
        return AppColors.accepted;
      case 'cancelled':
        return AppColors.redColor;
      default:
        return Colors.grey;
    }
  }

  String getOrderStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return "Payment pending on";
      case 'confirmed':
        return "Order is confirmed on";
      case 'seller to pack':
        return "Seller will pack by";
      case 'packed':
        return "Order is packed on";
      case 'delivered':
      case 'completed':
        return "Order is completed on";
      case 'cancelled':
        return "Order is cancelled on";
      default:
        return "Order status updated on";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: orders.customer!.profileImage ?? "",
                          fit: BoxFit.cover,
                          height: 48,
                          width: 48,
                          placeholder:
                              (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget:
                              (context, url, error) => Image.asset(
                                ImagePath.noImage,
                                fit: BoxFit.cover,
                              ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orders.customer!.fullName ?? "",
                            style: CustomTextStyles.f14W600(
                              color:
                                  isDark
                                      ? AppColors.extraWhite
                                      : AppColors.blackColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Order No: ${orders.orderNo ?? ""}",
                            style: CustomTextStyles.f11W400(
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
                      orders.status ?? "",
                      style: CustomTextStyles.f11W600(
                        color: getStatusColor(orders.status ?? ""),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    getOrderStatusText(orders.status ?? ""),
                    style: CustomTextStyles.f12W400(
                      color:
                          isDark
                              ? AppColors.extraWhite.withOpacity(0.7)
                              : AppColors.secondaryTextColor,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    orders.createdAt != null && orders.createdAt!.isNotEmpty
                        ? DateFormat(
                          'd MMM yyyy hh:mm a',
                        ).format(DateTime.parse(orders.createdAt!).toLocal())
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
                  Text(
                    "\$${orders.totalAmount ?? ""}",
                    style: CustomTextStyles.f16W600(
                      color:
                          isDark
                              ? AppColors.primaryColor
                              : AppColors.secondaryColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor:
                                isDark
                                    ? AppColors.darkModeColor
                                    : AppColors.extraWhite,
                            title: Text(
                              "Confirm Delete",
                              style: CustomTextStyles.f16W700(
                                color:
                                    isDark
                                        ? AppColors.extraWhite
                                        : AppColors.blackColor,
                              ),
                            ),
                            content: Text(
                              "Are you sure you want to delete this order?",
                              style: CustomTextStyles.f14W400(
                                color:
                                    isDark
                                        ? AppColors.extraWhite
                                        : AppColors.textGreyColor,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  "Cancel",
                                  style: CustomTextStyles.f12W400(
                                    color: AppColors.lightblue,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  c.deleteOrder(
                                    int.parse(orders.id.toString()),
                                  );
                                },
                                child: Text(
                                  "Delete",
                                  style: CustomTextStyles.f12W400(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: SvgPicture.asset(ImagePath.delete),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
