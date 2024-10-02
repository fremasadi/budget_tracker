import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/helper/database_helper.dart';
import '../../../data/models/category.dart';
import '../../../data/models/transaction.dart';
import '../../../routes/app_pages.dart';

class AddTransactionController extends GetxController {
  late TextEditingController amountController;
  var categories = <Category>[].obs;
  var selectedCategory = Rx<Category?>(null);
  final DatabaseHelper _dbHelper = DatabaseHelper();
  var transactions = <Transaction>[].obs; // Daftar transaksi yang dapat diamati
  var selectedTab = 0.obs; // 0 untuk Expense, 1 untuk Income
  var amount = ''.obs; // Observable untuk menyimpan jumlah tanpa simbol $
  final selectedDate = Rx<DateTime>(DateTime.now());

  final NumberFormat numberFormat =
      NumberFormat("#,##0", "en_US"); // Formatter untuk ribuan

  @override
  void onInit() {
    super.onInit();
    amountController = TextEditingController(text: '\$0');
    loadCategories(); // Muat kategori saat inisialisasi controller
  }

  void resetState() {
    amountController.text = '\$0';
    amount.value = '';
    selectedCategory.value = null;
    selectedDate.value = DateTime.now();
    selectedTab.value = 0;
  }

  void loadCategories() async {
    final data = await _dbHelper.getCategories();
    categories.value = data;
  }

  void onTextChanged(String text) {
    String cleanText = text.replaceAll('\$', '').replaceAll(',', '');

    if (cleanText == '0') {
      amount.value = '';
    } else if (cleanText.startsWith('0') && cleanText.length > 1) {
      amount.value = cleanText.substring(1);
    } else {
      amount.value = cleanText;
    }

    String formattedAmount = numberFormat.format(int.parse(amount.value));

    amountController.value = TextEditingValue(
      text: '\$$formattedAmount',
      selection: TextSelection.collapsed(offset: '\$$formattedAmount'.length),
    );
  }

  void pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  Future<void> saveTransaction() async {
    if (selectedCategory.value != null && amountController.text.isNotEmpty) {
      String cleanAmount =
          amountController.text.replaceAll('\$', '').replaceAll(',', '');
      double amount = double.parse(cleanAmount);

      String type = selectedTab.value == 0 ? 'expense' : 'income';

      await _dbHelper.saveTransaction(
        type,
        selectedCategory.value!.id!,
        amount,
        selectedDate.value,
      );

      Get.snackbar(
        "Berhasil Menambahkan",
        "",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        margin: EdgeInsets.all(10.sp),
        borderRadius: 10,
      );

      resetState();
      Get.toNamed(Routes.HOME);
    } else {
      Get.snackbar('Error', 'Silakan pilih kategori dan masukkan jumlahnya.');
    }
  }
}
