import 'package:budget_tracker/app/data/entities/icon_list.dart';
import 'package:budget_tracker/app/styles/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../data/models/transaction.dart';
import '../../../styles/app_colors.dart';
import '../../../data/models/category.dart';

class HistoryCard extends StatelessWidget {
  final Transaction transaction;
  final Category category; // Add category parameter

  const HistoryCard({
    super.key,
    required this.transaction,
    required this.category, // Add category to the constructor
  });

  @override
  Widget build(BuildContext context) {
    // Get the color directly from the category
    Color color = Color(category.color);

    // Get the icon directly from the category
    IconData? icon = iconsList[category.icon];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.sp, horizontal: 17.sp),
      margin: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 20.sp),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: color.withOpacity(0.3),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0.sp),
                  child: Icon(
                    icon,
                    color: color,
                    size: 30.sp,
                  ),
                ),
              ),
              SizedBox(width: 9.w),
              Text(
                category.name, // Use category name
                style: AppFonts.semiBold.copyWith(
                  fontSize: 16.sp,
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${transaction.type == 'expense' ? '-' : ''}\$${transaction.amount == transaction.amount.roundToDouble() ? NumberFormat("#,##0", "en_US").format(transaction.amount) : NumberFormat("#,##0.00", "en_US").format(transaction.amount)}',
                style: AppFonts.semiBold.copyWith(
                  fontSize: 16.sp,
                  color:
                      transaction.type == 'expense' ? Colors.red : Colors.green,
                ),
              ),
              Text(
                DateFormat('dd-MMM-yyyy').format(transaction.date),
                style: AppFonts.medium.copyWith(
                  fontSize: 13.sp,
                  color: AppColors.grey.withOpacity(0.7),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
