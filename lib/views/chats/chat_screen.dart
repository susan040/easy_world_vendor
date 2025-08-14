import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/chat_screen_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/exchange_rate_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/widgets/chat_screen_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ChatScreen extends StatelessWidget {
  final int chatId;
  final String customerName;
  ChatScreen({required this.chatId, required this.customerName});

  final TextEditingController messageController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool productDetailsSent = false.obs;
  final exchangeRateController = Get.put(ExchangeRateController());
  final controller = Get.put(ChatScreenController());
  final coreController = Get.put(CoreController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchSingleChatById(chatId);
    });
    return Scaffold(
      backgroundColor: isDark ? Color(0xFF121212) : Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: isDark ? Color(0xFF1F1F1F) : AppColors.extraWhite,
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
        title: Obx(() {
          final customer =
              controller.allChatsLists.isNotEmpty
                  ? controller.allChatsLists.first.customer
                  : null;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                customerName,
                style: CustomTextStyles.f16W600(
                  color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.circle,
                    color:
                        customer?.isOnline == true ? Colors.green : Colors.grey,
                    size: 10,
                  ),
                  SizedBox(width: 6),
                  Text(
                    customer?.isOnline == true ? "Online" : "Offline",
                    style: CustomTextStyles.f11W400(
                      color:
                          customer?.isOnline == true
                              ? Colors.green
                              : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 14,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    final isVendor = index % 2 == 0;
                    return Align(
                      alignment:
                          isVendor
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      child: Shimmer.fromColors(
                        baseColor:
                            isDark ? Colors.grey[800]! : Colors.grey[300]!,
                        highlightColor:
                            isDark ? Colors.grey[700]! : Colors.grey[100]!,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(12),

                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.6,
                            minHeight: 35,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(20),
                              topRight: const Radius.circular(20),
                              bottomLeft: Radius.circular(isVendor ? 20 : 0),
                              bottomRight: Radius.circular(isVendor ? 0 : 20),
                            ),
                          ),
                          height: 20,
                        ),
                      ),
                    );
                  },
                );
              }

              final chat = controller.currentChat.value;
              final messages = chat?.messages ?? [];
              if (messages.isEmpty) {
                return Center(
                  child: Text(
                    "No messages yet",
                    style: CustomTextStyles.f13W400(
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                );
              }
              return ListView.builder(
                reverse: false,
                padding: const EdgeInsets.only(
                  left: 14,
                  right: 14,
                  bottom: 16,
                  top: 8,
                ),
                controller: controller.scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  final isCustomer = msg.senderType == "Vendor";
                  final currentTime = DateTime.tryParse(
                    msg.createdAt ?? '',
                  )?.toUtc().add(const Duration(hours: 5, minutes: 45));

                  final previousMsg = index > 0 ? messages[index - 1] : null;
                  final previousTime = DateTime.tryParse(
                    previousMsg?.createdAt ?? '',
                  )?.toUtc().add(const Duration(hours: 5, minutes: 45));

                  bool showTimeDivider = true;

                  if (previousTime != null && currentTime != null) {
                    showTimeDivider =
                        !(currentTime.hour == previousTime.hour &&
                            currentTime.minute == previousTime.minute);
                  }
                  return Column(
                    crossAxisAlignment:
                        isCustomer
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                    children: [
                      if (showTimeDivider && currentTime != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Center(
                            child: Text(
                              controller.formatTimestamp(msg.createdAt),
                              style: CustomTextStyles.f11W400(
                                color: AppColors.secondaryTextColor,
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment:
                              isCustomer
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => controller.selectMessage(index),
                              child: Column(
                                crossAxisAlignment:
                                    isCustomer
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                          0.7,
                                    ),
                                    padding: const EdgeInsets.only(
                                      left: 14,
                                      right: 14,
                                      top: 8,
                                      bottom: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          isCustomer
                                              ? const Color(0xFF2E3A59)
                                              : const Color(0xFF3E4A61),
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(20),
                                        topRight: const Radius.circular(20),
                                        bottomLeft: Radius.circular(
                                          isCustomer ? 20 : 0,
                                        ),
                                        bottomRight: Radius.circular(
                                          isCustomer ? 0 : 20,
                                        ),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      msg.message ?? '',
                                      style: CustomTextStyles.f13W400(
                                        color: AppColors.extraWhite,
                                      ),
                                    ),
                                  ),
                                  Obx(() {
                                    final isSelected =
                                        controller.selectedMessageIndex.value ==
                                        index;
                                    if (isSelected &&
                                        controller.showTime.value) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          msg.readAt != null
                                              ? "Read"
                                              : "Delivered",
                                          style: CustomTextStyles.f11W400(
                                            color: AppColors.secondaryTextColor,
                                          ),
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
          ),
          SafeArea(
            child: ChatInputArea(
              isDark: isDark,
              isLoading: isLoading,
              chatId: chatId.toString(),
              messageController: messageController,
              scrollController: controller.scrollController,
              onSend: (message, chatId) {
                controller.sendChatMessage(chatId: chatId, messages: message);
              },
            ),
          ),
        ],
      ),
    );
  }
}

