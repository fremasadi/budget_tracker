import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    // Request permission and get the token
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('token: $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> enableNotifications() async {
    // Your logic to enable notifications (if needed)
    print('Notifications enabled');
  }

  Future<void> disableNotifications() async {
    // Your logic to disable notifications
    // For example, you might want to delete the FCM token
    await _firebaseMessaging.deleteToken();
    print('Notifications disabled');
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('title: ${message.notification?.title}');
    print('body: ${message.notification?.body}');
    print('data: ${message.data}');
  }
}
