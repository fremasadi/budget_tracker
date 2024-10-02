import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> enableNotifications() async {}

  Future<void> disableNotifications() async {
    await _firebaseMessaging.deleteToken();
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {}
}
