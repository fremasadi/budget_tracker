import 'package:budget_tracker/app/data/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/helper/database_helper.dart';
import '../../../data/models/transaction.dart';

class HistoryTransactionController extends GetxController {
  var selectedMonth = ''.obs;
  var currentDate = DateTime.now();
  var now = DateTime.now();
  var selectedTab = 0.obs; // 0 untuk Expense, 1 untuk Income
  final DatabaseHelper _dbHelper = DatabaseHelper();
  var transactions = <Transaction>[].obs;
  var categories = <Category>[].obs;

  // Mengubah string selectedMonth menjadi DateTime
  DateTime getSelectedMonthDate() {
    return DateFormat('MMMM yyyy').parse(selectedMonth.value);
  }

  Future<void> loadTransactions() async {
    // Mendapatkan semua transaksi dari database
    final allTransactions = await _dbHelper.getTransactionsWithCategories();

    // Mengubah data transaksi ke list Transaction
    var allTransactionObjects = allTransactions.map((data) {
      return Transaction.fromMap(data);
    }).toList();

    // Mendapatkan bulan dan tahun dari selectedMonth
    DateTime selectedDate = getSelectedMonthDate();

    // Memfilter transaksi berdasarkan bulan dan tahun yang dipilih
    transactions.value = allTransactionObjects.where((transaction) {
      return transaction.date.month == selectedDate.month &&
          transaction.date.year == selectedDate.year;
    }).toList();

    // Fetch categories jika belum dimuat
    categories.assignAll(await _dbHelper.getCategories());
  }

  Future<void> loadCategory() async {
    final data = await _dbHelper.getCategories();
    categories.assignAll(data);
  }

  Category? getCategoryByName(String categoryName) {
    return categories
        .firstWhereOrNull((category) => category.name == categoryName);
  }

  @override
  void onInit() {
    super.onInit();
    // Set bulan yang dipilih ke bulan saat ini
    selectedMonth.value = DateFormat.yMMMM().format(currentDate);
    loadTransactions();
    loadCategory();
  }

  void previousMonth() {
    if (currentDate.month > 1) {
      currentDate = DateTime(currentDate.year, currentDate.month - 1);
    } else {
      currentDate = DateTime(currentDate.year - 1, 12);
    }
    selectedMonth.value = DateFormat.yMMMM().format(currentDate);
    loadTransactions();
  }

  void nextMonth() {
    if (currentDate.year < now.year ||
        (currentDate.year == now.year && currentDate.month < now.month)) {
      currentDate = DateTime(currentDate.year, currentDate.month + 1);
      selectedMonth.value = DateFormat.yMMMM().format(currentDate);
      loadTransactions();
    } else {
      Get.snackbar(
        "Tidak Dapat Melanjutkan",
        "Anda tidak dapat memilih bulan di masa depan.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        margin: EdgeInsets.all(10.sp),
        borderRadius: 10,
      );
    }
  }
}
