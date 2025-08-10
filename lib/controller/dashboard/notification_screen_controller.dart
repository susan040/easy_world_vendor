import 'dart:developer';
import 'package:easy_world_vendor/main.dart';
import 'package:easy_world_vendor/models/notification_details.dart';
import 'package:easy_world_vendor/repo/notification/delete_notification_by_id_repo.dart';
import 'package:easy_world_vendor/repo/notification/get_notification_repo.dart';
import 'package:easy_world_vendor/repo/notification/read_notification_repo.dart';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  late final FirebaseMessaging _messaging;
  var notificationMessage = ''.obs;
  RxList<GetNotificationDetails> allNotificationList =
      <GetNotificationDetails>[].obs;
  var isLoading = true.obs;
  int get unreadCount =>
      allNotificationList.where((n) => n.readAt == null).length;
  @override
  void onInit() {
    super.onInit();
    // _initializeFirebaseMessaging();
    getAllNotificationDetails();
  }

  void getAllNotificationDetails() async {
    isLoading.value = true;
    await GetNotificationRepo.getNotificationRepo(
      onSuccess: (notifications) {
        allNotificationList.assignAll(notifications);
        isLoading.value = false;
      },
      onError: (message) {
        isLoading.value = false;
        print('Error fetching notifications: $message');
      },
    );
  }

  void initializeFirebaseMessaging() async {
    _messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        showNotification(message);
        notificationMessage.value =
            message.notification?.body ?? 'New Notification';
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        // handle click
      });

      final token = await _messaging.getToken();
      log('FCM Token: $token');
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? 'No title',
      message.notification?.body ?? 'No body',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  void markNotificationAsRead(String id) async {
    await ReadNotificationRepo.readNotificationRepo(
      notificationId: id,
      onSuccess: (_) {
        final index = allNotificationList.indexWhere((e) => e.id == id);
        if (index != -1) {
          final updatedNotification = allNotificationList[index];
          updatedNotification.readAt = DateTime.now().toIso8601String();
          allNotificationList[index] = updatedNotification;
        }
      },
      onError: (message) {
        CustomSnackBar.error(title: "Notification", message: message);
      },
    );
  }

  void markAllNotificationsAsRead() async {
    await MarkAllAsReadNotification.markAllAsReadNotification(
      onSuccess: (_) {
        final updatedList =
            allNotificationList.map((n) {
              n.readAt = DateTime.now().toIso8601String();
              return n;
            }).toList();
        allNotificationList.value = updatedList;
      },
      onError: (message) {
        CustomSnackBar.error(title: "Notification", message: message);
      },
    );
  }

  void deleteNotificationById(String id) async {
    await DeleteNotificationByIdRepo.deleteNotificationByIdRepo(
      notificationId: id,
      onSuccess: (_) {
        allNotificationList.removeWhere((n) => n.id == id);
      },
      onError: (message) {
        CustomSnackBar.error(title: "Notification", message: message);
      },
    );
  }

  void deleteAllNotifications() async {
    await DeleteAllNotificationsRepo.deleteAllNotificationsRepo(
      onSuccess: (_) {
        clearSelection();
        allNotificationList.clear();
      },
      onError: (message) {
        CustomSnackBar.error(title: "Notification", message: message);
      },
    );
  }

  var isSelectionMode = false.obs;
  var selectedNotifications = <String>{}.obs;

  // Select one
  void enterSelectionMode(String id) {
    isSelectionMode.value = true;
    selectedNotifications.add(id);
  }

  // Toggle individual selection
  void toggleSelection(String id) {
    if (selectedNotifications.contains(id)) {
      selectedNotifications.remove(id);
      if (selectedNotifications.isEmpty) {
        isSelectionMode.value = false;
      }
    } else {
      selectedNotifications.add(id);
    }
    selectedNotifications.refresh();
  }

  // Select all
  void selectAll() {
    selectedNotifications
      ..clear()
      ..addAll(allNotificationList.map((e) => e.id ?? ''));
    selectedNotifications.refresh();
    isSelectionMode.value = true;
  }

  // Clear selection
  void clearSelection() {
    selectedNotifications.clear();
    selectedNotifications.refresh();
    isSelectionMode.value = false;
  }

  void deleteSelected() async {
    for (final id in selectedNotifications) {
      deleteNotificationById(id);
    }
    allNotificationList.removeWhere(
      (e) => selectedNotifications.contains(e.id),
    );
    clearSelection();
  }
}
