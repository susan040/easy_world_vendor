import 'package:easy_world_vendor/models/all_chats.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/views/dashboard/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    final bool hasReply =
        chats.customerReply != null && chats.customerReply!.isNotEmpty;

    final String message =
        hasReply ? chats.customerReply! : (chats.vendorMessage ?? '');

    final String time = formatChatTime(
      hasReply ? chats.customerReplyTime : chats.vendorMessageTime,
    );
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          Get.to(
            () => ChatScreen(
              chatId: chats.chatId.toString(),
              customerName: chats.customer!.name ?? "",
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
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
                blurRadius: 1,
                spreadRadius: 1.5,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 48,
                width: 45,
                decoration: BoxDecoration(
                  color:
                      isDark
                          ? AppColors.blackColor.withOpacity(0.3)
                          : AppColors.extraWhite,
                  borderRadius: BorderRadius.circular(13),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://blog.photofeeler.com/wp-content/uploads/2017/02/flattering-pose-profile-pics.jpeg",
                    ),
                    fit: BoxFit.cover,
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
                      message,
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
        ),
      ),
    );
  }
}
