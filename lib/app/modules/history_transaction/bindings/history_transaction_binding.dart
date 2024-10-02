import 'package:get/get.dart';

import '../../add_transaction/controllers/add_transaction_controller.dart';
import '../controllers/history_transaction_controller.dart';

class HistoryTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryTransactionController>(
      () => HistoryTransactionController(),
    );
    Get.put(AddTransactionController());
  }
}
