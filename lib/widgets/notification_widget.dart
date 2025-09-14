import 'package:easy_world_vendor/controller/dashboard/notification_screen_controller.dart';
import 'package:easy_world_vendor/models/notification_details.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart' show ImagePath;
import 'package:easy_world_vendor/views/dashboard/orders_history_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final GetNotificationDetails notifications;
  final bool isDark;

  NotificationCard({
    super.key,
    required this.notifications,
    required this.isDark,
  });

  final controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    final isOrderNotification =
        notifications.type?.contains('OrderNotification') ?? false;
    final String image =
        isOrderNotification ? ImagePath.products : ImagePath.message;
    final Color borderColor =
        isOrderNotification ? AppColors.primaryColor : AppColors.secondaryColor;
    final Color iconColor =
        isOrderNotification ? AppColors.primaryColor : AppColors.darkblue;
    final isRead = notifications.readAt == null;

    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 12),
      child: InkWell(
        onTap: () {
          if (controller.isSelectionMode.value) {
            controller.toggleSelection(notifications.id ?? '');
          } else {
            if (notifications.readAt == null) {
              controller.markNotificationAsRead(notifications.id ?? '');
            }
            if (notifications.type?.contains('OrderNotification') ?? false) {
              final orderId = notifications.data?.orderId;
              if (orderId != null) {
                Get.to(() => OrderHistoryDetailScreen(orderId: orderId));
              }
            }
          }
        },
        onLongPress: () {
          if (!controller.isSelectionMode.value) {
            controller.enterSelectionMode(notifications.id ?? '');
          } else {
            controller.toggleSelection(notifications.id ?? '');
          }
        },
        child: Obx(() {
          final isSelected = controller.selectedNotifications.contains(
            notifications.id ?? '',
          );
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? (isDark
                          ? AppColors.primaryColor.withOpacity(0.3)
                          : AppColors.lightPrimaryColor)
                      : (isRead
                          ? (isDark
                              ? AppColors.primaryColor.withOpacity(0.15)
                              : AppColors.lGrey)
                          : (isDark
                              ? AppColors.blackColor.withOpacity(0.2)
                              : AppColors.extraWhite)),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: isDark ? AppColors.darkModeColor : AppColors.lGrey,
                  blurRadius: 1,
                  spreadRadius: 1.5,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: borderColor.withOpacity(0.18),
                    border: Border.all(width: 0.5, color: borderColor),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: SvgPicture.asset(image, color: iconColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notifications.data?.status!.capitalizeFirst ??
                                'Notification',
                            style: CustomTextStyles.f12W600(
                              color:
                                  isDark
                                      ? AppColors.extraWhite
                                      : AppColors.blackColor,
                            ),
                          ),
                          Text(
                            DateFormat('hh:mm a').format(
                              DateTime.parse(notifications.createdAt ?? ""),
                            ),
                            style: CustomTextStyles.f10W400(
                              color:
                                  isDark
                                      ? AppColors.extraWhite.withOpacity(0.7)
                                      : AppColors.secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        notifications.data?.message ?? '',
                        style: CustomTextStyles.f11W400(
                          color:
                              isDark
                                  ? AppColors.extraWhite.withOpacity(0.7)
                                  : AppColors.secondaryTextColor,
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
