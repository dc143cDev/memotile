import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class notification {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> setup() async {
    const iosInitSetting = DarwinInitializationSettings();

    const initSettings = InitializationSettings(iOS: iosInitSetting);
    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<void> getNotification() async {
    NotificationDetails platFrom = NotificationDetails(
      iOS: DarwinNotificationDetails(badgeNumber: 1),
    );

    await flutterLocalNotificationsPlugin.show(
        0, 'hello', 'test noti!', platFrom);
  }
}
