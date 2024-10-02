import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/entities/icon_list.dart';
import '../../../data/helper/database_helper.dart';
import '../../../data/models/category.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_fonts.dart';

class AddCategoriesView extends StatefulWidget {
  const AddCategoriesView({super.key});

  @override
  _AddCategoriesViewState createState() => _AddCategoriesViewState();
}

class _AddCategoriesViewState extends State<AddCategoriesView> {
  final TextEditingController _categoryNameController = TextEditingController();
  int selectedColor = 0xff000000;
  int selectedIcon = 0;

  final List<Color> availableColors = [
    Colors.black,
    Colors.orange,
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.grey,
    Colors.brown,
    Colors.red,
  ];

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void dispose() {
    _categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          'Add Categories',
          style: AppFonts.semiBold.copyWith(
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 22.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              String categoryName = _categoryNameController.text.trim();
              if (categoryName.isNotEmpty) {
                Category newCategory = Category(
                  name: categoryName,
                  color: selectedColor,
                  icon: selectedIcon,
                  id: null,
                );
                await _dbHelper.insertCategory(newCategory);
                Get.back();
              } else {
                Get.snackbar(
                  'Error',
                  'Category name cannot be empty!',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.black,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  iconsList[selectedIcon],
                  color: Color(selectedColor),
                  size: 100.sp,
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: 8.sp, horizontal: 20.sp),
                margin:
                    EdgeInsets.symmetric(horizontal: 72.sp, vertical: 20.sp),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(50.sp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: _categoryNameController,
                  decoration: InputDecoration(
                    hintText: 'Category Name',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16.sp,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0.sp),
                child: Center(
                  child: Text(
                    'Select Color',
                    style: TextStyle(fontSize: 22.sp),
                  ),
                ),
              ),
              Center(
                child: Wrap(
                  spacing: 8,
                  children: availableColors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = color.value;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: color,
                        child: selectedColor == color.value
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0.sp, top: 20.sp),
                child: Center(
                  child: Text(
                    'Select Icon',
                    style: TextStyle(fontSize: 22.sp),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: iconsList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIcon = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedIcon == index
                              ? Theme.of(context).primaryColor
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          iconsList[index],
                          size: 22.sp,
                          color: selectedIcon == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
