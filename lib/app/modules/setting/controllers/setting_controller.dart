import 'package:get/get.dart';
import '../../../data/services/notification_services.dart';

class SettingController extends GetxController {
  var isNotificationActive = false.obs;

  final NotificationService _notificationService = NotificationService();

  @override
  void onInit() {
    super.onInit();
    _notificationService.init();
    // Optionally, set `isNotificationActive` based on stored preference or token existence
    _checkNotificationStatus();
  }

  void toggleNotification() async {
    if (isNotificationActive.value) {
      await _notificationService.disableNotifications();
    } else {
      await _notificationService.enableNotifications();
    }
    isNotificationActive.value = !isNotificationActive.value;
  }

  Future<void> _checkNotificationStatus() async {
    // Your logic to check if notifications are currently enabled
    // This could be based on local storage or some other mechanism
    // For now, we'll just assume notifications are enabled
    isNotificationActive.value = true;
  }
}
