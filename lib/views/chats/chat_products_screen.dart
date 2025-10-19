import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_world_vendor/controller/dashboard/chat_screen_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/exchange_rate_controller.dart';
import 'package:easy_world_vendor/models/all_chats.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:easy_world_vendor/views/chats/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatProductsScreen extends StatelessWidget {
  final List<AllChats> customerChats;
  ChatProductsScreen({super.key, required this.customerChats});
  final chatController = Get.put(ChatScreenController());
  final exchangeController = Get.put(ExchangeRateController());
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Chat Products",
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
      body: SafeArea(
        child: Obx(() {
          if (chatController.allChatsLists.isEmpty) {
            return Center(
              child: Text(
                "No chats available",
                style: CustomTextStyles.f14W400(
                  color: AppColors.secondaryTextColor,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(left: 12, right: 12),
            itemCount: customerChats.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final chat = customerChats[index];
              final product = chat.product;
              final customer = chat.customer;

              if (product == null || customer == null) return const SizedBox();

              return GestureDetector(
                onTap: () {
                  Get.to(
                    () => ChatScreen(
                      chatId: int.parse(chat.chatId.toString()),
                      customerName: customer.name ?? "",
                    ),
                  )?.then((_) {
                    chatController.getAllChats();
                  });
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color:
                          isDark
                              ? AppColors.darkGrey.withOpacity(0.1)
                              : AppColors.lGrey,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            placeholder:
                                (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                            imageUrl: product.productImages?.first ?? "",
                            errorWidget:
                                (context, url, error) => Image.asset(
                                  ImagePath.noImage,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name ?? "No name",
                                style: CustomTextStyles.f13W600(
                                  color:
                                      isDark
                                          ? AppColors.extraWhite
                                          : AppColors.blackColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Obx(() {
                                final convertedPrice = exchangeController
                                    .convertPriceFromAUD(product.price ?? "N/A")
                                    .toStringAsFixed(2);
                                final code =
                                    exchangeController
                                        .selectedCountryData['code'];
                                final symbol = code == 'NPR' ? 'Rs.' : '\$';
                                return Text(
                                  "$symbol$convertedPrice",
                                  style: CustomTextStyles.f14W700(
                                    color:
                                        isDark
                                            ? AppColors.primaryColor
                                            : AppColors.secondaryColor,
                                  ),
                                );
                              }),
                              const SizedBox(height: 2),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 16,
                                    color: AppColors.secondaryTextColor,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    customer.name ?? "Unknown",
                                    style: CustomTextStyles.f12W400(
                                      color: AppColors.secondaryTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Obx(() {
                          final chatFromController = chatController
                              .allChatsLists
                              .firstWhere(
                                (c) => c.chatId == chat.chatId,
                                orElse: () => chat,
                              );
                          final unreadCount =
                              chatFromController.messages
                                  ?.where(
                                    (msg) =>
                                        msg.senderType == "Customer" &&
                                        msg.readAt == null,
                                  )
                                  .length ??
                              0;

                          if (unreadCount == 0) return const SizedBox();

                          return Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                              color: AppColors.rejected,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                "${unreadCount}",
                                style: CustomTextStyles.f11W600(
                                  color: AppColors.extraWhite,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
