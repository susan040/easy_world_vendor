import 'package:easy_world_vendor/controller/dashboard/chat_screen_controller.dart';
import 'package:easy_world_vendor/models/all_chats.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
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
        child: Obx(
          () =>
              (messageController.isLoading.value)
                  ? Center(child: CircularProgressIndicator())
                  : messageController.allChatsLists.isEmpty
                  ? Center(child: Text("No messages"))
                  : ListView.builder(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 4,
                      bottom: 10,
                    ),
                    itemCount: messageController.allChatsLists.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final AllChats chats =
                          messageController.allChatsLists[index];
                      return CustomMessagesWidget(isDark: isDark, chats: chats);
                    },
                  ),
        ),
      ),
    );
  }
}
