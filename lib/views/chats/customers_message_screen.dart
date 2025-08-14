import 'package:easy_world_vendor/controller/dashboard/chat_screen_controller.dart';
import 'package:easy_world_vendor/models/all_chats.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/views/chats/chat_products_screen.dart';
import 'package:easy_world_vendor/widgets/customer_messages_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomersMessageScreen extends StatelessWidget {
  CustomersMessageScreen({super.key});
  final messageController = Get.put(ChatScreenController());
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Messages",
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
          if (messageController.isLoading.value) {
            Center(child: CircularProgressIndicator());
          }
          final groupedChats = <int, List<AllChats>>{};

          for (var chat in messageController.allChatsLists) {
            if (chat.customer?.id == null) continue;

            final customId = chat.customer!.id!;
            if (!groupedChats.containsKey(customId)) {
              groupedChats[customId] = [];
            }
            groupedChats[customId]!.add(chat);
          }

          if (groupedChats.isEmpty) {
            return Center(
              child: Text(
                "No messages",
                style: CustomTextStyles.f14W400(
                  color: AppColors.secondaryTextColor,
                ),
              ),
            );
          }
          final customerChatsLists = groupedChats.values.toList();
          return ListView.builder(
            itemCount: customerChatsLists.length,
            padding: EdgeInsets.only(bottom: 10),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final customChats = customerChatsLists[index];
              final chats = customChats.last;
              return InkWell(
                onTap: () {
                  Get.to(() => ChatProductsScreen(customerChats: customChats));
                },
                child: CustomMessagesWidget(isDark: isDark, chats: chats),
              );
            },
          );
        }),
      ),
    );
  }
}
