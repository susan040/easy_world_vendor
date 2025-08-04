import 'dart:developer';

import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/controller/theme_controller.dart';
import 'package:easy_world_vendor/views/dashboard/chat_screen.dart';
import 'package:easy_world_vendor/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

late FirebaseMessaging _messaging;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await _initializeFirebaseMessaging();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launcher_icon');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(MyApp());
}

Future<void> _initializeFirebaseMessaging() async {
  _messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
      log("Foreground Notification: ${message.notification?.body}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("Notification tapped from background.");
      if (message.data.isNotEmpty) {
        log("Message data: ${message.data}");
        Get.to(
          () => ChatScreen(
            chatId: message.data['chat_id'],
            customerName: message.data['customer_name'],
          ),
        );
      }
    });

    final token = await _messaging.getToken();
    log('FCM Token: $token');
  } else {
    log('Notification permission not granted');
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  showNotification(message);
}

Future<void> showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        playSound: true,
        largeIcon: DrawableResourceAndroidBitmap("@mipmap/launcher_icon"),
      );

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    DateTime.now().millisecondsSinceEpoch ~/ 1000,
    message.notification?.title ?? 'No title',
    message.notification?.body ?? 'No body',
    platformChannelSpecifics,
  );
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeController.theme,
      initialBinding: BindingsBuilder(() {
        Get.put(CoreController());
      }),
      home: SplashScreen(),
    );
  }
}
