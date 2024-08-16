import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/helper/database_helper.dart';
import '../../../data/models/category.dart';

class AddCategoriesView extends StatefulWidget {
  const AddCategoriesView({super.key});

  @override
  _AddCategoriesViewState createState() => _AddCategoriesViewState();
}

class _AddCategoriesViewState extends State<AddCategoriesView> {
  final TextEditingController _categoryNameController = TextEditingController();
  int selectedColor = 0xFFFFA500;
  int selectedIcon = 0;

  final List<Color> availableColors = [
    Colors.orange,
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.grey,
    Colors.brown,
    Colors.red,
  ];

  final List<IconData> iconsList = [
    Icons.home,
    Icons.shopping_cart,
    Icons.car_rental,
    Icons.restaurant,
    Icons.school,
    Icons.work,
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
        title: const Text('Add Category'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              String categoryName = _categoryNameController.text.trim();
              if (categoryName.isNotEmpty) {
                Category newCategory = Category(
                  name: categoryName,
                  color: selectedColor,
                  icon: selectedIcon,
                );
                await _dbHelper.insertCategory(newCategory);
                Get.back();  // Kembali ke halaman sebelumnya setelah menyimpan
              } else {
                Get.snackbar(
                  'Error',
                  'Category name cannot be empty!',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
CircleAvatar(
                    backgroundColor: Color(selectedColor),
                    radius: 25,
                    child: Icon(
                      iconsList[selectedIcon],
                      color: Colors.white,
                      size: 30,
                    ),
                  ),        
                      TextFormField(
                      controller: _categoryNameController,
                      decoration: const InputDecoration(
                        labelText: 'Category Name',
                      ),
                    ),
              const SizedBox(height: 16),
              // Pilihan warna
              Wrap(
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
              const SizedBox(height: 16),
              // Pilihan ikon
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
