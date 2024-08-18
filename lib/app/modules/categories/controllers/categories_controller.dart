import 'package:get/get.dart';

import '../../../data/helper/database_helper.dart';
import '../../../data/models/category.dart';

class CategoriesController extends GetxController {
  var categories = <Category>[].obs;
  var selectedCategory = Rx<Category?>(null);
  final DatabaseHelper _dbHelper = DatabaseHelper();

  void loadCategories() async {
    final data = await _dbHelper.getCategories();
    categories.value = data;
  }
}
