import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class notificationService{
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> setup() async{
    const iosInitSetting = DarwinInitializationSettings();

    const initSettings = InitializationSettings(iOS: iosInitSetting);
    await _flutterLocalNotificationsPlugin.initialize(initSettings);
  }
}