import 'package:get/get.dart';

class SettingController extends GetxController {
  var isNotificationActive = false.obs;

  void toggleNotification() {
    isNotificationActive.value = !isNotificationActive.value;
  }
}
