import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:zeeh_mobile/constants/colors.dart';

class FCM {
  // Implementing Singleton
  static final FCM _instance = FCM._();
  factory FCM() {
    return _instance;
  }

  FCM._();

  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<String> getToken() async {
    return (await FirebaseMessaging.instance.getToken() ?? '');
  }

  Future<void> setNotification() async {
    // Request Notification Permission
    await _firebaseMessaging.requestPermission();

    await _firebaseMessaging.subscribeToTopic('news');

    // Set foreground notification for iOS
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // init awesome notification
    AwesomeNotifications().initialize(
      // Drawable declared as null
      "resource://drawable/notificationicon",
      [
        NotificationChannel(
          channelKey: 'usezeeh_channel',
          channelName: 'usezeeh_channel',
          channelDescription: 'usezeeh_notifications',
          onlyAlertOnce: true,
          importance: NotificationImportance.Max,
        )
      ],
    );

    // Request Authorization
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );

    // Background has to be declared on main

    // Foreground
    FirebaseMessaging.onMessage.listen(
      (message) async {
        if (message.data.containsKey("notification")) {
          // final data = message.data["notification"];
        }

        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: Random().nextInt(10),
            channelKey: 'usezeeh_channel',
            color: ZeehColors.buttonPurple,
            title: message.notification!.title ?? 'UseZeeh',
            body: message.notification!.body ?? 'UseZeeh',
            icon: 'resource://drawable/notificationicon',
            displayOnBackground: true,
            displayOnForeground: true,
            largeIcon: 'resource://drawable/largenotificon',
          ),
        );
      },
    );
  }
}

void createNotification({String? title, String? message, int? notificationId}) {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: notificationId ?? Random().nextInt(10),
      channelKey: 'usezeeh_channel',
      color: ZeehColors.buttonPurple,
      title: title ?? 'UseZeeh',
      body: message ?? 'UseZeeh',
      icon: 'resource://drawable/notificationicon',
      displayOnBackground: true,
      displayOnForeground: true,
      largeIcon: 'resource://drawable/largenotificon',
    ),
  );
}
