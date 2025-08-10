import 'package:easy_world_vendor/controller/dashboard/notification_screen_controller.dart';
import 'package:easy_world_vendor/models/notification_details.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final c = Get.put(NotificationController());
  String formatDate(DateTime date) {
    final today = DateTime.now();
    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return "Today";
    } else if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.subtract(const Duration(days: 1)).day) {
      return "Yesterday";
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }

  Map<String, List<GetNotificationDetails>> groupNotification(
    List<GetNotificationDetails> notification,
  ) {
    final Map<String, List<GetNotificationDetails>> groupNotifications = {};
    for (var notifications in notification) {
      final createdAt = notifications.createdAt;
      if (createdAt != null) {
        final dateKey = formatDate(DateTime.parse(createdAt));
        groupNotifications.putIfAbsent(dateKey, () => []).add(notifications);
      }
    }
    return groupNotifications;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkModeColor
                : AppColors.extraWhite,
        leading: Obx(() {
          if (!c.isSelectionMode.value) {
            return InkWell(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back,
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? AppColors.extraWhite
                        : AppColors.blackColor,
              ),
            );
          } else {
            return IconButton(
              icon: Icon(
                Icons.close,
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? AppColors.extraWhite
                        : AppColors.blackColor,
              ),
              onPressed: () {
                c.clearSelection();
              },
            );
          }
        }),
        title: Obx(() {
          if (!c.isSelectionMode.value) {
            return Text(
              "Notifications",
              style: CustomTextStyles.f16W600(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? AppColors.extraWhite
                        : AppColors.blackColor,
              ),
            );
          } else {
            return Text(
              '${c.selectedNotifications.length} selected',
              style: CustomTextStyles.f16W600(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? AppColors.extraWhite
                        : AppColors.blackColor,
              ),
            );
          }
        }),
        centerTitle: false,
        elevation: 0,
        actions: [
          Obx(() {
            if (c.allNotificationList.isEmpty) {
              return const SizedBox(); // Don't show any actions if empty
            }

            final isDark = Theme.of(context).brightness == Brightness.dark;

            if (!c.isSelectionMode.value) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () {
                    c.markAllNotificationsAsRead();
                  },
                  child: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color:
                          isDark
                              ? AppColors.blackColor.withOpacity(0.1)
                              : AppColors.extraWhite,
                      border: Border.all(
                        width: 1,
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "Mark all as read",
                        style: CustomTextStyles.f11W400(
                          color:
                              isDark
                                  ? AppColors.extraWhite
                                  : AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              bool allSelected =
                  c.selectedNotifications.length ==
                  c.allNotificationList.length;

              return Row(
                children: [
                  IconButton(
                    icon: Icon(
                      allSelected ? Icons.cancel : Icons.done,
                      color:
                          isDark
                              ? AppColors.extraWhite
                              : AppColors.secondaryTextColor,
                    ),
                    onPressed: () {
                      if (allSelected) {
                        c.clearSelection();
                      } else {
                        c.selectAll();
                      }
                    },
                    tooltip: allSelected ? 'Clear Selection' : 'Select All',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      if (allSelected) {
                        c.deleteAllNotifications();
                      } else {
                        c.deleteSelected();
                      }
                    },
                    tooltip: 'Delete Selected',
                  ),
                ],
              );
            }
          }),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (c.isLoading.value) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 14,
                  right: 14,
                  top: 4,
                  bottom: 20,
                ),
                child: Shimmer.fromColors(
                  baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
                  highlightColor:
                      isDark ? Colors.grey[700]! : Colors.grey[100]!,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 80,
                      );
                    },
                  ),
                ),
              ),
            );
          } else if (c.allNotificationList.isEmpty) {
            return Center(
              child: Text(
                "No notification",
                style: CustomTextStyles.f14W400(
                  color: AppColors.secondaryTextColor,
                ),
              ),
            );
          } else {
            final groupedNotification = groupNotification(
              c.allNotificationList.toList(),
            );
            return ListView.builder(
              itemCount: groupedNotification.keys.length,
              itemBuilder: (context, index) {
                final dateKey = groupedNotification.keys.toList()[index];
                final notification = groupedNotification[dateKey]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 10),
                      child: Text(
                        dateKey,
                        style: CustomTextStyles.f12W600(
                          color:
                              isDark
                                  ? AppColors.extraWhite.withOpacity(0.8)
                                  : AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: notification.length,
                      itemBuilder: (context, index) {
                        final notif = notification[index];
                        return NotificationCard(
                          notifications: notif,
                          isDark: isDark,
                        );
                      },
                    ),
                  ],
                );
              },
            );
          }
        }),
      ),
    );
  }
}
