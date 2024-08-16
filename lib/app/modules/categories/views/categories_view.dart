import 'package:budget_tracker/app/modules/categories/views/add_categories_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../styles/app_colors.dart';
import '../../../styles/app_fonts.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final List<IconData> iconsList = [
    Icons.home,
    Icons.shopping_cart,
    Icons.car_rental,
    Icons.restaurant,
    Icons.school,
    Icons.work,
  ];

  List<Map<String, dynamic>> categories = [];

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    Database db = await openDatabase(
      join(await getDatabasesPath(), 'categories.db'),
    );
    final List<Map<String, dynamic>> data = await db.query('categories');
    setState(() {
      categories = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 28.sp,
            color: AppColors.black,
          ),
        ),
        backgroundColor: AppColors.white,
        title: Text(
          'Categories',
          style: AppFonts.semiBold.copyWith(
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const AddCategoriesView()),
              );
              loadCategories(); // Reload categories after returning from AddCategoriesView
            },
            icon: Row(
              children: [
                Icon(
                  Icons.add,
                  size: 28.sp,
                ),
                Text(
                  'New',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            categories.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      var category = categories[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(category['colorValue']),
                          child: Icon(
                            iconsList[category['iconIndex']],
                            color: Colors.white,
                          ),
                        ),
                        title: Text(category['name']),
                      );
                    },
                  )
                : const Center(
                    child: Text('No categories added yet!'),
                  ),
          ],
        ),
      ),
    );
  }
}
