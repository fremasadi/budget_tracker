import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMassage(RemoteMessage message) async {}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMassage);
  }
}
