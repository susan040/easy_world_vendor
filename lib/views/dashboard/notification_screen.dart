import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Notifications",
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
      body: ListView(
        padding: const EdgeInsets.only(left: 16, right: 16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today",
                style: CustomTextStyles.f12W600(
                  color:
                      isDark
                          ? AppColors.extraWhite.withOpacity(0.8)
                          : AppColors.secondaryTextColor,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? AppColors.blackColor.withOpacity(0.1)
                            : AppColors.extraWhite,
                    border: Border.all(width: 1, color: AppColors.primaryColor),
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
            ],
          ),
          const SizedBox(height: 14),
          NotificationCard(
            image: ImagePath.products,
            iconColor: AppColors.primaryColor,
            title: "Processed",
            message:
                "Your have received a new order #234930304. Start preparing it for shipping!",
            time: "Now",
            isDark: isDark,
            borderColor: AppColors.primaryColor,
          ),
          const SizedBox(height: 10),
          NotificationCard(
            image: ImagePath.newMessage,
            iconColor: AppColors.secondaryColor,
            title: "New Message",
            message:
                "Your have received a new order #234930304. Start preparing it for shipping!",
            time: "2 min ago",
            isDark: isDark,
            borderColor: AppColors.secondaryColor,
          ),
          const SizedBox(height: 18),
          Text(
            "Yesterday",
            style: CustomTextStyles.f12W600(
              color:
                  isDark
                      ? AppColors.extraWhite.withOpacity(0.8)
                      : AppColors.secondaryTextColor,
            ),
          ),
          const SizedBox(height: 8),
          NotificationCard(
            image: ImagePath.products,
            iconColor: AppColors.primaryColor,
            title: "Processed",
            message:
                "Your have received a new order #234930304. Start preparing it for shipping!",
            time: "1 day ago",
            isDark: isDark,
            borderColor: AppColors.primaryColor,
          ),
          const SizedBox(height: 10),
          NotificationCard(
            image: ImagePath.newMessage,
            iconColor: AppColors.darkblue,
            title: "New Message",
            message:
                "Your have received a new order #234930304. Start preparing it for shipping!",
            time: "1 day ago",
            isDark: isDark,
            borderColor: AppColors.secondaryColor,
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String image;
  final Color iconColor;
  final String title;
  final String message;
  final String time;
  final Color borderColor;
  final bool isDark;

  const NotificationCard({
    super.key,
    required this.image,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.time,
    required this.isDark,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 10),
      decoration: BoxDecoration(
        color:
            isDark
                ? AppColors.blackColor.withOpacity(0.3)
                : AppColors.extraWhite,
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
            child: SvgPicture.asset(image),
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
                      title,
                      style: CustomTextStyles.f12W600(
                        color:
                            isDark
                                ? AppColors.extraWhite
                                : AppColors.blackColor,
                      ),
                    ),
                    Text(
                      time,
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
                  message,
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
  }
}
