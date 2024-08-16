import 'package:budget_tracker/app/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../styles/app_fonts.dart';
import '../controllers/add_transaction_controller.dart';

class AddExpenses extends StatelessWidget {
  const AddExpenses({
    super.key,
    required this.controller,
  });

  final AddTransactionController controller;

  @override
  Widget build(BuildContext context) {
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
                  // Hanya izinkan input angka
                ],
                onChanged: (text) {
                  // Ketika input berubah, kita panggil controller untuk memproses inputnya
                  controller.onTextChanged(text);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
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
                    Text(
                      'Choose',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.grey.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                      color: AppColors.grey.withOpacity(0.7),
                    )
                  ],
                )
              ],
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
