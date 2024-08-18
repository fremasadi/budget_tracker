import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/entities/icon_list.dart';
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
    print('Icons List Length: ${iconsList.length}');
    categories.value = data;
  }

  // Fungsi untuk memproses perubahan input
  void onTextChanged(String text) {
    // Hapus simbol '$' sebelum memproses input
    String cleanText = text.replaceAll('\$', '').replaceAll(',', '');

    // Hilangkan angka '0' default jika pengguna mengetik angka pertama
    if (cleanText == '0') {
      amount.value = ''; // Hapus angka '0' jika hanya itu yang ada
    } else if (cleanText.startsWith('0') && cleanText.length > 1) {
      amount.value = cleanText
          .substring(1); // Hilangkan angka '0' saat pengguna mulai mengetik
    } else {
      amount.value = cleanText; // Simpan input tanpa simbol '$' atau ','
    }

    // Format angka dengan NumberFormat (menambahkan pemisah ribuan)
    String formattedAmount = numberFormat.format(int.parse(amount.value));

    // Perbarui controller dengan simbol '$' dan angka yang diformat
    amountController.value = TextEditingValue(
      text: '\$$formattedAmount',
      selection: TextSelection.collapsed(offset: '\$$formattedAmount'.length),
    );
  }

  // Fungsi untuk menampilkan DatePicker
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
      // Hapus simbol '$' dan ',' dari input sebelum parsing ke double
      String cleanAmount =
          amountController.text.replaceAll('\$', '').replaceAll(',', '');
      double amount = double.parse(cleanAmount);

      // Tentukan jenis transaksi
      String type = selectedTab.value == 0 ? 'expense' : 'income';

      // Simpan transaksi ke dalam database menggunakan categoryId
      await _dbHelper.saveTransaction(
        type,
        selectedCategory.value!.id!, // Gunakan categoryId untuk menyimpan
        amount,
        selectedDate.value, // Pass date as String
      );

      // Tampilkan snackbar berhasil
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
      // Tampilkan pesan error jika kategori atau jumlah belum diisi
      Get.snackbar('Error', 'Please select a category and enter an amount.');
    }
  }
}
