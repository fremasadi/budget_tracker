import 'package:get/get.dart';

import '../../../data/helper/database_helper.dart';

class CategoriesController extends GetxController {
  var categories = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  void loadCategories() async {
    var data = await DatabaseHelper().getCategories();
    categories.value = data;
  }
}
