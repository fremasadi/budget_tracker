import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTransactionController extends GetxController {
  late TextEditingController amountController;
  var amount = ''.obs; // Observable untuk menyimpan jumlah tanpa simbol $

  final NumberFormat numberFormat =
      NumberFormat("#,##0", "en_US"); // Formatter untuk ribuan

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi dengan '$0'
    amountController = TextEditingController(text: '\$0');
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

  final selectedDate = Rx<DateTime>(DateTime.now());

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
}
