import 'package:budget_tracker/app/styles/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../styles/app_colors.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  color: Colors.orange.withOpacity(0.3),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0.sp),
                  child: Icon(
                    Icons.shop,
                    color: Colors.orange,
                    size: 30.sp,
                  ),
                ),
              ),
              SizedBox(width: 9.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shopping',
                    style: AppFonts.semiBold.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    'Buy some one',
                    style: AppFonts.medium.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.grey.withOpacity(0.7),
                    ),
                  )
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '-\$13',
                style: AppFonts.semiBold.copyWith(
                  fontSize: 16.sp,
                  color: Colors.red,
                ),
              ),
              Text(
                '10.00Am',
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
