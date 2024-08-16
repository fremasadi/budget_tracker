import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/helper/database_helper.dart';

class AddCategoriesView extends StatefulWidget {
  const AddCategoriesView({super.key});

  @override
  _AddCategoriesViewState createState() => _AddCategoriesViewState();
}

class _AddCategoriesViewState extends State<AddCategoriesView> {
  String categoryName = '';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Category'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              await DatabaseHelper().insertCategory({
                'name': categoryName,
                'iconIndex': selectedIcon,
                'colorValue': selectedColor,
              });
              Get.back(); // Go back to the previous screen after saving
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
              TextField(
                onChanged: (value) {
                  setState(() {
                    categoryName = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                ),
              ),
              const SizedBox(height: 16),
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
