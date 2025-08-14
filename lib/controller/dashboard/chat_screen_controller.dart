import 'dart:developer';
import 'package:easy_world_vendor/models/all_chats.dart';
import 'package:easy_world_vendor/repo/chat/get_all_chat_repo.dart';
import 'package:easy_world_vendor/repo/chat/get_chat_by_id_repo.dart';
import 'package:easy_world_vendor/repo/chat/send_message_to_customer_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatScreenController extends GetxController {
  final messageController = TextEditingController();
  RxList<AllChats> allChatsLists = <AllChats>[].obs;
  Rx<AllChats?> currentChat = Rx<AllChats?>(null);
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

  var errorMessage = "".obs;
  void fetchSingleChatById(int chatId) async {
    isLoading.value = true;
    errorMessage.value = "";

    await GetChatByIdRepo.getChatByIdRepo(
      chatId: chatId,
      onSuccess: (chat) {
        // Mark all messages as read
        // chat.messages?.forEach((msg) {
        //   msg.readAt = DateTime.now().toUtc().toIso8601String();
        // });

        // Update current chat without replacing the object entirely
        if (currentChat.value != null &&
            currentChat.value!.chatId == chat.chatId) {
          currentChat.value!.messages = chat.messages;
          currentChat.refresh();
        } else {
          currentChat.value = chat;
        }

        isLoading.value = false;

        // Scroll to bottom after loading
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        });
      },
      onError: (message) {
        errorMessage.value = message;
        currentChat.value = null;
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

  Future<void> sendChatMessage({
    required String chatId,
    required String messages,
  }) async {
    final newMessage = Messages(
      message: messages,
      senderType: "Vendor",
      createdAt: DateTime.now().toUtc().toIso8601String(),
      readAt: null,
    );

    if (currentChat.value == null) {
      currentChat.value = AllChats(chatId: null, messages: RxList<Messages>());
    }

    if (currentChat.value!.messages is! RxList<Messages>) {
      currentChat.value!.messages = RxList<Messages>(
        currentChat.value!.messages ?? [],
      );
    }

    (currentChat.value!.messages as RxList<Messages>).add(newMessage);
    currentChat.refresh();

    await SendMessageToCustomerRepo.sendMessageToCustomer(
      messages: messages,
      chatId: chatId,
      onSuccess: (messageText) {
        log("Message sent successfully");

        // if (currentChat.value != null) {
        //   currentChat.value!.chatId = chatIdFromServer;
        //   currentChat.refresh();
        // }
      },
      onError: (message) {
        log("Error sending message: $message");
      },
    );
  }

  void markMessagesAsRead(AllChats chat) {
    if (chat.messages == null) return;

    bool updated = false;
    for (var msg in chat.messages!) {
      // Only mark customer messages as read if they are not yet read
      if (msg.senderType == "Customer" && msg.readAt == null) {
        msg.readAt = DateTime.now().toUtc().toIso8601String();
        updated = true;
      }
    }

    if (updated) {
      currentChat.refresh();
      allChatsLists.refresh();
      // Optionally, call your API to mark messages as read on server
    }
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

  int totalUnreadMessages(List<AllChats> allChats) {
    int count = 0;

    for (var chat in allChats) {
      if (chat.messages != null && chat.messages!.isNotEmpty) {
        count += chat.messages!.where((msg) => msg.readAt == null).length;
      }
    }

    return count;
  }

  String? getLastMessage(AllChats chat) {
    if (chat.messages == null || chat.messages!.isEmpty) return null;

    final lastMessage = chat.messages!.reduce((a, b) {
      final aTime =
          DateTime.tryParse(a.createdAt ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0);
      final bTime =
          DateTime.tryParse(b.createdAt ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0);
      return aTime.isAfter(bTime) ? a : b;
    });

    return lastMessage.message;
  }
}
