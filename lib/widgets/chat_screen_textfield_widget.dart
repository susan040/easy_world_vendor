import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ChatInputArea extends StatelessWidget {
  final bool isDark;
  final RxBool isLoading;
  final TextEditingController messageController;
  final ScrollController scrollController;
  final String chatId;
  final void Function(String message, String chatId) onSend;

  const ChatInputArea({
    Key? key,
    required this.isDark,
    required this.isLoading,
    required this.messageController,
    required this.scrollController,
    required this.chatId,
    required this.onSend,
  }) : super(key: key);

  void sendMessage(BuildContext context) {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    onSend(text, chatId);
    messageController.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 14, bottom: 16, left: 14, top: 8),
      color: isDark ? Color(0xFF1F1F1F) : AppColors.extraWhite,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
              minLines: 1,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                hintText: "Type your message...",
                hintStyle: CustomTextStyles.f12W400(
                  color: AppColors.secondaryTextColor,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: AppColors.grey, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: AppColors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 1,
                  ),
                ),
              ),
              style: CustomTextStyles.f12W400(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
              onSubmitted: (_) {
                sendMessage(context);
              },
            ),
          ),

          const SizedBox(width: 8),
          Obx(
            () =>
                isLoading.value
                    ? const SizedBox(
                      width: 48,
                      height: 48,
                      child: Center(child: CircularProgressIndicator()),
                    )
                    : CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.primaryColor,
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () => sendMessage(context),
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
