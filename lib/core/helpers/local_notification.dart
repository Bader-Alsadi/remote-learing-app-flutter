import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class LocalNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {

    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,

    );

    //flutterLocalNotificationsPlugin.initialize(initializationSettings);
      flutterLocalNotificationsPlugin.initialize(
          initializationSettings,
        onSelectNotification: (String? payload) async {
      // Handle the notification when the user taps on it.
      print('Notification tapped with payload: $payload');
      // You can navigate to a specific screen or handle the action accordingly.
    });
  }

  static Future<void> onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
    // Handle the notification when the app is in the foreground on iOS.
  }
  

  static AndroidNotificationDetails getAndroidNotificationDetails() {
    return AndroidNotificationDetails(
      LocalNotification.getChannel().id,
      LocalNotification.getChannel().name,
      channelDescription: LocalNotification.getChannel().description,
      playSound: true,
      icon: '@mipmap/ic_launcher',
    );
  }

  static IOSNotificationDetails getIOSNotificationDetails() {
    return const IOSNotificationDetails();
  }

  static NotificationDetails getNotificationDetails() {
    return NotificationDetails(
      android: getAndroidNotificationDetails(),
      iOS: getIOSNotificationDetails(),
    );
  }

  static AndroidNotificationChannel getChannel() {
    return const AndroidNotificationChannel(
      'channel_id',
      'channel_name',
      importance: Importance.max,
    );
  }
}
