import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../styles/app_colors.dart';
import '../../../styles/app_fonts.dart';
import '../components/history_transaction_expenses.dart';
import '../components/history_transaction_income.dart';
import '../controllers/history_transaction_controller.dart';

class HistoryTransactionView extends GetView<HistoryTransactionController> {
  const HistoryTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
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
          title: Container(
            width: 250.w,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.grey)),
            child: Obx(
              () {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: controller.previousMonth,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 16.sp,
                      ),
                      color: AppColors.black,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      controller.selectedMonth.value,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8.w),
                    IconButton(
                      onPressed: controller.nextMonth,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.sp,
                      ),
                      color: AppColors.black,
                    ),
                  ],
                );
              },
            ),
          ),
          centerTitle: true,
          actions: [
            SizedBox(
              width: 30.w,
            )
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
                  HistoryTransactionExpenses(),
                  HistoryTransactionIncome(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
