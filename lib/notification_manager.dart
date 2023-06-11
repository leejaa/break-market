import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationManager {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  init() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
