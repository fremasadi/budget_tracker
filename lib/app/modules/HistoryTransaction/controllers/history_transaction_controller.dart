import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryTransactionController extends GetxController {
  var selectedMonth = ''.obs;
  var currentDate = DateTime.now();
  var now = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    selectedMonth.value = DateFormat.yMMMM().format(currentDate);
  }

  void previousMonth() {
    currentDate = DateTime(currentDate.year, currentDate.month - 1);
    selectedMonth.value = DateFormat.yMMMM().format(currentDate);
  }

  void nextMonth() {
    // Pastikan tidak bisa melewati bulan saat ini
    if (currentDate.year < now.year ||
        (currentDate.year == now.year && currentDate.month < now.month)) {
      currentDate = DateTime(currentDate.year, currentDate.month + 1);
      selectedMonth.value = DateFormat.yMMMM().format(currentDate);
    } else {
      // Tampilkan Snackbar jika mencoba memilih bulan di masa depan
      Get.snackbar(
        "Tidak Dapat Melanjutkan",
        "Anda tidak dapat memilih bulan di masa depan.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        margin: EdgeInsets.all(10.sp),
        borderRadius: 10,
      );
    }
  }
}
