import 'package:easy_world_vendor/controller/dashboard/chat_screen_controller.dart';
import 'package:easy_world_vendor/models/all_chats.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomMessagesWidget extends StatelessWidget {
  CustomMessagesWidget({super.key, required this.isDark, required this.chats});
  final bool isDark;
  final AllChats chats;
  final c = Get.put(ChatScreenController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    // color: AppColors.lightGreen,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor.withOpacity(0.9),
                        AppColors.secondaryColor.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    (chats.customer?.name?.isNotEmpty ?? false)
                        ? chats.customer!.name![0].toUpperCase()
                        : "?",
                    style: CustomTextStyles.f20W700(color: Colors.white),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chats.customer?.name ?? "",
                        style: CustomTextStyles.f14W600(
                          color:
                              isDark
                                  ? AppColors.extraWhite
                                  : AppColors.blackColor,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        c.getLastMessage(chats) ?? "",
                        style: CustomTextStyles.f12W400(
                          color: AppColors.secondaryTextColor,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${formatChatTime(chats.messages?.first.createdAt)}",
                  style: CustomTextStyles.f11W400(
                    color: AppColors.secondaryTextColor,
                  ),
                ),
                SizedBox(height: 4),
                Obx(() {
                  final unreadCount = c.totalUnreadMessages(c.allChatsLists);
                  if (unreadCount == 0)
                    return const SizedBox.shrink(); // don't show anything
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.rejected,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "$unreadCount",
                      style: CustomTextStyles.f11W600(
                        color: AppColors.extraWhite,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatChatTime(String? timestamp) {
    if (timestamp == null) return '';
    final msgDate = DateTime.tryParse(timestamp)?.toLocal();
    if (msgDate == null) return '';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final msgDay = DateTime(msgDate.year, msgDate.month, msgDate.day);

    if (msgDay == today) {
      return DateFormat('hh:mm a').format(msgDate);
    } else if (msgDay == yesterday) {
      return "Yesterday";
    } else {
      return DateFormat('dd MMM hh:mm a').format(msgDate);
    }
  }
}
