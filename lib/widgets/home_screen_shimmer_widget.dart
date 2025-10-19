import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/notification_screen_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:easy_world_vendor/views/dashboard/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class HomePageShimmerWidget extends StatelessWidget {
  HomePageShimmerWidget({super.key, required this.isDark});
  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
              highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
              child: Container(
                height: 25,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Shimmer.fromColors(
              baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
              highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 13,
                crossAxisSpacing: 13,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 155 / 73,
                children: List.generate(4, (_) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 18),
            Shimmer.fromColors(
              baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
              highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
              child: Container(
                height: 25,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Shimmer.fromColors(
              baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
              highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
                  highlightColor:
                      isDark ? Colors.grey[700]! : Colors.grey[100]!,
                  child: Container(
                    height: 25,
                    width: 135,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
                  highlightColor:
                      isDark ? Colors.grey[700]! : Colors.grey[100]!,
                  child: Container(
                    height: 25,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Shimmer.fromColors(
              baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
              highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
              child: Column(
                children: List.generate(4, (_) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreenNotificationWidget extends StatelessWidget {
  HomeScreenNotificationWidget({super.key, required this.isDark});

  final bool isDark;
  final notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        height: 33,
        width: 33,
        decoration: BoxDecoration(
          color:
              isDark
                  ? AppColors.darkGrey.withOpacity(0.6)
                  : AppColors.extraWhite,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: isDark ? AppColors.darkModeColor : AppColors.lGrey,
              spreadRadius: 1.5,
              blurRadius: 1,
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Get.to(() => NotificationScreen());
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: SvgPicture.asset(
                  ImagePath.notification,
                  color:
                      isDark ? AppColors.extraWhite : AppColors.darkModeColor,
                ),
              ),
              Obx(() {
                final unread = notificationController.unreadCount;
                return unread > 0
                    ? Positioned(
                      top: 3,
                      right: 3,
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: const BoxDecoration(
                          color: AppColors.rejected,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            unread.toString(),
                            style: CustomTextStyles.f10W400(
                              color: AppColors.extraWhite,
                            ),
                          ),
                        ),
                      ),
                    )
                    : const SizedBox();
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreenAppBar extends StatelessWidget {
  HomeScreenAppBar({super.key, required this.isDark});

  final coreController = Get.put(CoreController());
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() {
          final storeName = coreController.currentUser.value?.data?.storeName;
          if (storeName == null) {
            return Shimmer.fromColors(
              baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
              highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
              child: Container(width: 120, height: 16, color: Colors.white),
            );
          }
          return Text(
            "Hi, $storeName",
            style: CustomTextStyles.f16W600(
              color: isDark ? AppColors.extraWhite : AppColors.blackColor,
            ),
          );
        }),
        const SizedBox(height: 4),
        Text(
          DateFormat('d MMMM, yyyy').format(DateTime.now()),
          style: CustomTextStyles.f13W400(
            color:
                isDark
                    ? AppColors.extraWhite.withOpacity(0.7)
                    : AppColors.secondaryTextColor,
          ),
        ),
      ],
    );
  }
}
