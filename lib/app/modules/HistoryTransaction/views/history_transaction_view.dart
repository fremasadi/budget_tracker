import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../styles/app_colors.dart';
import '../controllers/history_transaction_controller.dart';

class HistoryTransactionView extends GetView<HistoryTransactionController> {
  const HistoryTransactionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 4), // Posisi bayangan (x,y)
              ),
            ],
          ),
          child: Obx(
            () {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: controller.previousMonth,
                    icon: Icon(Icons.arrow_back_ios),
                    color: AppColors.black,
                  ),
                  SizedBox(width: 8),
                  Text(
                    controller.selectedMonth.value,
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    onPressed: controller.nextMonth,
                    icon: Icon(Icons.arrow_forward_ios),
                    color: AppColors.black,
                  ),
                ],
              );
            },
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 28.sp,
            color: AppColors.white,
          ),
        ),
        actions: [
          SizedBox(
            width: 28.w,
          ),
        ],
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
