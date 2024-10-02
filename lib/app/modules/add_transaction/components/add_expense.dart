import 'package:budget_tracker/app/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/entities/icon_list.dart';
import '../../../styles/app_fonts.dart';
import '../../categories/views/add_categories_view.dart';
import '../controllers/add_transaction_controller.dart';

class AddExpenses extends StatelessWidget {
  const AddExpenses({
    super.key,
    required this.controller,
  });

  final AddTransactionController controller;

  void _showCategoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0.sp),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.sp),
              )),
          child: Obx(
            () {
              final categories = controller.categories;
              if (categories.isEmpty) {
                return Center(
                  child: TextButton(
                    onPressed: () async {
                      await Get.to(() => const AddCategoriesView());
                      controller.loadCategories();
                      Get.back();
                    },
                    child: Text(
                      'Add Category',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                );
              } else {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'List',
                          style: AppFonts.bold.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await Get.to(() => const AddCategoriesView());
                            controller.loadCategories();
                            Get.back();
                          },
                          child: Text(
                            'Add Category',
                            style: AppFonts.semiBold.copyWith(
                              fontSize: 16.sp,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          var category = categories[index];
                          return ListTile(
                            leading: Container(
                              padding: EdgeInsets.all(8.0.sp),
                              decoration: BoxDecoration(
                                color: Color(category.color).withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                iconsList[category.icon],
                                color: Color(category.color),
                              ),
                            ),
                            title: Text(
                              category.name,
                              style: AppFonts.semiBold.copyWith(
                                fontSize: 16.sp,
                              ),
                            ),
                            onTap: () {
                              controller.selectedCategory.value = category;
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.loadCategories();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 58.0.sp),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: TextField(
                controller: controller.amountController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 32.sp,
                  color: AppColors.primary,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (text) {
                  controller.onTextChanged(text);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
            child: GestureDetector(
              onTap: () => _showCategoryBottomSheet(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category',
                    style: AppFonts.semiBold.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  Row(
                    children: [
                      Obx(
                        () {
                          return Text(
                            controller.selectedCategory.value?.name ?? 'Choose',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: controller.selectedCategory.value != null
                                  ? AppColors.black
                                  : AppColors.grey.withOpacity(0.7),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16.sp,
                        color: AppColors.grey.withOpacity(0.7),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 17.0.sp, horizontal: 20.sp),
            child: Divider(
              color: AppColors.grey.withOpacity(0.3),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
            child: Obx(
              () => GestureDetector(
                onTap: () => controller.pickDate(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date(choose)',
                      style: AppFonts.semiBold.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      DateFormat('dd-MMM-yyyy')
                          .format(controller.selectedDate.value),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
