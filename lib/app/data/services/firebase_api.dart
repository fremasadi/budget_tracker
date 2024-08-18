import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMassage(RemoteMessage message) async {
  print('title : ${message.notification?.title}');
  print('body : ${message.notification?.body}');
  print('title : ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('token $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMassage);
  }
}
