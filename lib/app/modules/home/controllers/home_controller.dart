import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/helper/database_helper.dart';
import '../../../data/models/category.dart';
import '../../../data/models/transaction.dart';

class HomeController extends GetxController {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  var transactions = <Transaction>[].obs;
  var categories = <Category>[].obs;

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
    categories.assignAll(data);
  }

  Category? getCategoryByName(String categoryName) {
    return categories
        .firstWhereOrNull((category) => category.name == categoryName);
  }

  void loadTransactions() async {
    final data = await _dbHelper.getTransactionsWithCategories();

    var allTransactions = data.map((e) {
      return Transaction.fromMap(e);
    }).toList();

    transactions.value = allTransactions;
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

  String formatNumber(double number) {
    final formatter = NumberFormat('#,##0.##', 'en_US');
    return formatter.format(number);
  }
}
