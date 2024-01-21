import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';

import '../../firebase_options.dart';
import 'local_notification.dart';

class FCMService {
  static final box=GetStorage();
  static Future<void> initialize() async {
    await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
     });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        LocalNotification.flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  LocalNotification.getChannel().id,
                  LocalNotification.getChannel().name,
                  channelDescription: LocalNotification.getChannel().description,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
                iOS: const IOSNotificationDetails(
                  presentAlert: true,
                  presentBadge: true,
                  presentSound: true,
                  badgeNumber: 1,
                )));
      }
    });
  }

  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  }

  static setForgroundNotification() async {
      LocalNotification.initialize();
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  //
  // static void sendFCM(String content,AppUser user){
  //   Dio dio=Dio();
  //   dio.options.headers["Authorization"]=FirebaseFCMConstants.serverKey;
  //   dio.options.headers["Content-Type"]=FirebaseFCMConstants.contentType;
  //   Map<String,dynamic>dataToSend=Map();
  //   dataToSend['notification']=
  //   {
  //     'title': FirebaseAuth.instance.currentUser!.displayName,
  //     'body' : content,
  //
  //   };
  //
  //   dataToSend['priority']='high';
  //
  //   dataToSend['content_available']= true;
  //   dataToSend['to'] = user.fcmToken;//'cfuNFP9aQ5CQanQs2sq6nw:APA91bFidmFjd9IHZhIKKDh5oIZmYo0_xVPZpGQwofjBQjrOvaFnGL6VxydIjA0L3sScEl_CSVLj_8UD-8uaAUmcpvEg7y6QUsi9aM6GLNo4bVrQ56XPVZfcpGMNQc3W8BSoMNWi3Lo7';
  //   dio.post(FirebaseFCMConstants.URL,
  //       data: dataToSend
  //   );
  // }

  static Future<String?> get token async=>await FirebaseMessaging.instance.getToken();
}
