import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Pastikan Anda mengimpor intl untuk memformat tanggal

import '../../../data/helper/database_helper.dart';
import '../../../data/models/category.dart';
import '../../../data/models/transaction.dart';

class HomeController extends GetxController {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  var transactions = <Transaction>[].obs; // Daftar transaksi yang dapat diamati
  var categories = <Category>[].obs;

  // Method untuk mendapatkan salam sesuai dengan waktu
  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Night";
    }
  }

  Future<void> loadCategory() async {
    final data = await _dbHelper.getCategories();
    categories.assignAll(data); // Use assignAll to populate the RxList
    print("Categories loaded");
    print(categories);
  }

  Category? getCategoryByName(String categoryName) {
    return categories
        .firstWhereOrNull((category) => category.name == categoryName);
  }

  // Memuat transaksi dari database dan memfilter hanya yang termasuk bulan ini
  void loadTransactions() async {
    final data = await _dbHelper.getTransactionsWithCategories();

    // Print the data for debugging
    for (var item in data) {
      print(item);
    }

    var allTransactions = data.map((e) {
      print(e); // Print each map entry
      return Transaction.fromMap(e);
    }).toList();

    var now = DateTime.now();

    // Filter transactions to only include those from the current month and year
    var filteredTransactions = allTransactions.where((transaction) {
      return transaction.date.month == now.month &&
          transaction.date.year == now.year;
    }).toList();

    transactions.value = filteredTransactions;
    print(transactions);
    print('Transactions loaded');
  }

  double get totalIncome {
    return transactions
        .where((t) => t.type == 'income')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get totalExpenses {
    return transactions
        .where((t) => t.type == 'expense')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get totalBalance {
    return totalIncome - totalExpenses;
  }

  // Format the number without trailing zeros and with thousands separators
  String formatNumber(double number) {
    final formatter = NumberFormat('#,##0.##', 'en_US');
    return formatter.format(number);
  }
}
