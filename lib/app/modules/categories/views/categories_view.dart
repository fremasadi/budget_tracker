import 'package:budget_tracker/app/modules/categories/views/add_categories_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/entities/icon_list.dart';
import '../../../data/helper/database_helper.dart';
import '../../../data/models/category.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_fonts.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  List<Category> categories = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadCategories(); // Memuat kategori saat inisialisasi
  }

  Future<void> _loadCategories() async {
    final data = await _dbHelper.getCategories();
    setState(() {
      categories = data;
      for (var category in categories) {}
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
            size: 22.sp,
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
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () async {
                await Get.to(() => const AddCategoriesView());
                _loadCategories(); // Refresh list kategori setelah kembali dari AddCategoriesView
              },
              icon: Row(
                children: [
                  Icon(
                    Icons.add,
                    size: 22.sp,
                  ),
                  Text(
                    'Add',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  )
                ],
              ),
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
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 17.sp, horizontal: 20.sp),
                        margin: EdgeInsets.only(bottom: 8.sp),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20.sp),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset:
                                  const Offset(0, 4), // Posisi bayangan (x,y)
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Color(category.color).withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          iconsList[category.icon],
                                          // Ikon default jika indeks tidak valid
                                          color: Color(category.color),
                                          size: 28.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 21.w,
                                ),
                                Text(
                                  category.name,
                                  style: AppFonts.semiBold.copyWith(
                                    fontSize: 16.sp,
                                  ),
                                )
                              ],
                            ),
                            IconButton(
                              onPressed: () async {
                                bool? confirmDelete = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Delete Category',
                                        style: AppFonts.semiBold.copyWith(
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      content: Text(
                                        'Are you sure you want to delete this category?',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirmDelete == true) {
                                  await _dbHelper.deleteCategory(category.id!);
                                  _loadCategories();
                                }
                              },
                              icon: Icon(
                                Icons.delete,
                                size: 22.sp,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
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
