import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/chat_screen_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.chatId, required this.customerName});
  final c = Get.put(ChatScreenController());
  final coreController = Get.find<CoreController>();
  final String chatId;
  final String customerName;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Future.delayed(const Duration(milliseconds: 100), () {
      c.getChatDetailsById(int.parse(chatId));
    });
    return Scaffold(
      backgroundColor: isDark ? Color(0xFF2E2E2E) : Color(0xFFE6F0FF),
      appBar: AppBar(
        title: Text(
          customerName,
          style: CustomTextStyles.f16W600(
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark ? Color(0xFF2E2E2E) : Color(0xFFE6F0FF),
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final chatDetails = c.chatDetailsByIdLists.value;
              final messages = chatDetails?.messages ?? [];

              return ListView.builder(
                controller: c.scrollController,
                padding: const EdgeInsets.only(
                  left: 14,
                  right: 14,
                  bottom: 12,
                  top: 10,
                ),
                itemCount: messages.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //   width: 205,
                        //   margin: EdgeInsets.only(bottom: 4),
                        //   padding: const EdgeInsets.all(8),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(8),
                        //     color: Color(0xFF2E3A59),
                        //   ),
                        //   child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       ClipRRect(
                        //         borderRadius: BorderRadius.circular(4),
                        //         child: CachedNetworkImage(
                        //           imageUrl: productImage,
                        //           fit: BoxFit.cover,
                        //           height: 55,
                        //           width: 50,
                        //           placeholder:
                        //               (context, url) => Center(
                        //                 child: CircularProgressIndicator(),
                        //               ),
                        //           errorWidget:
                        //               (context, url, error) => Image.asset(
                        //                 ImagePath.noImage,
                        //                 fit: BoxFit.cover,
                        //               ),
                        //         ),
                        //       ),
                        //       const SizedBox(width: 8),
                        //       Expanded(
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               productName,
                        //               maxLines: 2,
                        //               overflow: TextOverflow.ellipsis,
                        //               style: CustomTextStyles.f12W500(
                        //                 height: 1.25,
                        //                 color: AppColors.extraWhite,
                        //               ),
                        //             ),
                        //             const SizedBox(height: 3),
                        //             Obx(() {
                        //               final exchangeRateController = Get.put(
                        //                 ExchangeRateController(),
                        //               );
                        //               final convertedPrice =
                        //                   exchangeRateController
                        //                       .convertPriceFromAUD(productPrice)
                        //                       .toStringAsFixed(2);
                        //               final code =
                        //                   exchangeRateController
                        //                       .selectedCountryData['code'];
                        //               final symbol =
                        //                   code == 'NPR' ? 'Rs.' : '\$';
                        //               return Text(
                        //                 "$symbol$convertedPrice",
                        //                 style: CustomTextStyles.f14W700(
                        //                   color: AppColors.primaryColor,
                        //                 ),
                        //               );
                        //             }),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    );
                  }
                  final msg = messages[index - 1];
                  final isSender =
                      msg.sender?.id ==
                      coreController.currentUser.value?.data?.id;

                  final currentTime = DateTime.tryParse(
                    msg.createdAt ?? '',
                  )?.toUtc().add(const Duration(hours: 5, minutes: 45));

                  final previousMsg = index > 1 ? messages[index - 2] : null;
                  final previousTime = DateTime.tryParse(
                    previousMsg?.createdAt ?? '',
                  )?.toUtc().add(const Duration(hours: 5, minutes: 45));

                  final showTimeDivider =
                      previousTime == null ||
                      currentTime?.difference(previousTime).inMinutes != 0;

                  return Column(
                    children: [
                      if (showTimeDivider && currentTime != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8, top: 6),
                          child: Center(
                            child: Text(
                              c.formatTimestamp(currentTime.toIso8601String()),
                              style: CustomTextStyles.f11W400(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          mainAxisAlignment:
                              isSender
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                c.selectMessage(index - 1);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                          0.7,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          isSender
                                              ? Color(0xFF2E3A59)
                                              : Color(0xFF3E4A61),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      msg.message ?? '',
                                      style: CustomTextStyles.f13W400(
                                        color: Colors.white,
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                  Obx(() {
                                    final isSelected =
                                        c.selectedMessageIndex.value ==
                                        (index - 1);
                                    final showRead = msg.readAt != null;

                                    if (isSelected && c.showTime.value) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 6,
                                          top: 3,
                                        ),
                                        child: Text(
                                          showRead ? "Read" : "Delivered",
                                          style: CustomTextStyles.f11W400(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
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

          SafeArea(child: buildInputArea(context, isDark, chatId)),
        ],
      ),
    );
  }

  Widget buildInputArea(BuildContext context, bool isDark, String chatId) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      color: isDark ? Color(0xFF2E2E2E) : Color(0xFFE6F0FF),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: c.messageController,
              decoration: InputDecoration(
                hintText: "Type your message...",
                hintStyle: CustomTextStyles.f12W400(
                  color: AppColors.secondaryTextColor,
                ),
                // filled: true,
                // fillColor: isDark ? Color(0xFF2E2E2E) : Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: AppColors.secondaryTextColor,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: AppColors.secondaryTextColor,
                    width: 1,
                  ),
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
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => sendMessage(chatId),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primaryColor,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () => sendMessage(chatId),
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage(String chatId) {
    if (c.messageController.text.trim().isEmpty) return;
    c.sendChatMessage(chatId: chatId, messages: c.messageController.text);
    c.messageController.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      c.scrollController.jumpTo(c.scrollController.position.maxScrollExtent);
    });
  }
}
