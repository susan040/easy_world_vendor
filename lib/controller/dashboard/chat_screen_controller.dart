import 'package:easy_world_vendor/models/all_chats.dart';
import 'package:easy_world_vendor/models/chat_by_id.dart';
import 'package:easy_world_vendor/repo/chat/get_all_chat_repo.dart';
import 'package:easy_world_vendor/repo/chat/get_chat_by_id_repo.dart';
import 'package:easy_world_vendor/repo/chat/send_message_to_customer_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatScreenController extends GetxController {
  final messageController = TextEditingController();
  RxList<AllChats> allChatsLists = <AllChats>[].obs;
  Rxn<ChatWithID> chatDetailsByIdLists = Rxn<ChatWithID>();
  final ScrollController scrollController = ScrollController();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getAllChats();
  }

  getAllChats() async {
    isLoading.value = true;
    await GetAllChatRepo.getAllChatRepo(
      onSuccess: (chatList) {
        isLoading.value = false;
        allChatsLists.assignAll(chatList);
      },
      onError: (message) {
        isLoading.value = false;
      },
    );
  }

  void getChatDetailsById(int chatId, {bool showLoader = true}) async {
    if (showLoader) isLoading.value = true;
    await GetChatByIdRepo.getChatByIdRepo(
      chatId: chatId,
      onSuccess: (chatDetails) {
        chatDetailsByIdLists.value = chatDetails;
        if (showLoader) isLoading.value = true;
      },
      onError: (message) {
        isLoading.value = false;
      },
    );
  }

  final selectedMessageIndex = (-1).obs;
  final showTime = false.obs;

  void selectMessage(int index) {
    if (selectedMessageIndex.value == index) {
      // Toggle off
      showTime.value = !showTime.value;
    } else {
      selectedMessageIndex.value = index;
      showTime.value = true;
    }
  }

  void sendChatMessage({required String chatId, required String messages}) {
    // final user = Get.find<CoreController>().currentUser.value?.data;

    final newMessage = Messages(
      chatId: chatId,
      message: messages,
      createdAt: DateTime.now().toUtc().toIso8601String(),
      senderType: "customer",
      // sender:
      //     user != null
      //         ? Customer(id: user.id, name: user.storeName, email: user.email)
      //         : null,
    );

    if (chatDetailsByIdLists.value?.messages == null) {
      chatDetailsByIdLists.value?.messages = [];
    }
    chatDetailsByIdLists.value?.messages?.add(newMessage);
    chatDetailsByIdLists.refresh();
    messageController.clear();

    SendMessageToCustomerRepo.sendMessageToCustomer(
      messages: messages,
      chatId: chatId,
      onSuccess: (message) {
        Get.snackbar("Success", message);
      },
      onError: (message) {
        Get.snackbar("Error", message);
        // Optional: Mark message as failed in UI
      },
    );
  }

  String formatTimestamp(String? timestamp) {
    if (timestamp == null || timestamp.isEmpty) return "";

    final DateTime utcTime =
        DateTime.tryParse(timestamp)?.toUtc() ?? DateTime.now().toUtc();
    final DateTime nepalTime = utcTime.add(
      const Duration(hours: 5, minutes: 45),
    ); // adjust timezone

    final now = DateTime.now().toUtc().add(
      const Duration(hours: 5, minutes: 45),
    );

    final today = DateTime(now.year, now.month, now.day);
    final msgDay = DateTime(nepalTime.year, nepalTime.month, nepalTime.day);
    final oneWeekAgo = now.subtract(const Duration(days: 7));

    if (msgDay == today) {
      return DateFormat('hh:mm a').format(nepalTime);
    } else if (nepalTime.isAfter(oneWeekAgo)) {
      final day = DateFormat('EEE').format(nepalTime).toUpperCase();
      final time = DateFormat('hh:mm a').format(nepalTime);
      return "$day AT $time";
    } else {
      final date = DateFormat('MMMM dd').format(nepalTime);
      final time = DateFormat('hh:mm a').format(nepalTime);
      return "$date AT $time";
    }
  }
}
