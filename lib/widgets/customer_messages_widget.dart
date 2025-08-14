import 'package:easy_world_vendor/models/all_chats.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomMessagesWidget extends StatelessWidget {
  const CustomMessagesWidget({
    super.key,
    required this.isDark,
    required this.chats,
  });

  final bool isDark;
  final AllChats chats;
  String formatChatTime(String? timestamp) {
    if (timestamp == null) return '';
    final msgDate = DateTime.tryParse(timestamp)?.toLocal();
    if (msgDate == null) return '';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final msgDay = DateTime(msgDate.year, msgDate.month, msgDate.day);

    if (msgDay == today) {
      return DateFormat.jm().format(msgDate);
    } else if (msgDay == yesterday) {
      return "Yesterday";
    } else {
      return DateFormat('dd MMM').format(msgDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lastMessage =
        (chats.messages != null && chats.messages!.isNotEmpty)
            ? chats.messages!.last
            : null;

    final messageText = lastMessage?.message ?? '';
    final messageTime = lastMessage?.createdAt;
    final time = formatChatTime(messageTime);
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Container(
              height: 48,
              width: 45,
              color: AppColors.lightPrimaryColor,
              alignment: Alignment.center,
              child: Text(
                (chats.customer?.name != null &&
                        chats.customer!.name!.isNotEmpty)
                    ? chats.customer!.name![0].toUpperCase()
                    : "?",
                style: CustomTextStyles.f18W600(
                  color: AppColors.extraWhite,
                ),
              ),
            ),
          ),
    
          SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      chats.customer!.name ?? "",
                      style: CustomTextStyles.f12W600(
                        color:
                            isDark
                                ? AppColors.extraWhite
                                : AppColors.blackColor,
                      ),
                    ),
                    Text(
                      time,
                      style: CustomTextStyles.f11W400(
                        color:
                            isDark
                                ? AppColors.extraWhite.withOpacity(0.7)
                                : AppColors.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  messageText,
                  style: CustomTextStyles.f11W400(
                    color:
                        isDark
                            ? AppColors.extraWhite.withOpacity(0.7)
                            : AppColors.secondaryTextColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
