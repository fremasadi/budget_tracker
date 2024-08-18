import 'package:budget_tracker/app/modules/AddTransaction/components/add_income.dart';
import 'package:budget_tracker/app/styles/app_colors.dart';
import 'package:budget_tracker/app/styles/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../categories/views/add_categories_view.dart';
import '../components/add_expense.dart';
import '../controllers/add_transaction_controller.dart';

class AddTransactionView extends GetView<AddTransactionController> {
  const AddTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadCategories();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          leading: Padding(
            padding: EdgeInsets.only(left: 16.0.sp),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 22.sp,
              ),
            ),
          ),
          title: Text(
            'Add Transaction',
            style: AppFonts.semiBold.copyWith(
              fontSize: 20.sp,
            ),
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  controller.saveTransaction();
                },
                child: Text(
                  'Save',
                  style: AppFonts.semiBold.copyWith(
                    fontSize: 16.sp,
                  ),
                ))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TabBar(
                indicatorColor: Colors.transparent,
                unselectedLabelColor: Colors.black,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                labelPadding: EdgeInsets.symmetric(horizontal: 12.0.sp),
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onTap: (index) {
                  controller.selectedTab.value = index;
                },
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          size: 22.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Expense',
                          style: AppFonts.regular.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.attach_money,
                          size: 22.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Income',
                          style: AppFonts.regular.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AddExpenses(controller: controller),
                  AddIncome(controller: controller),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
