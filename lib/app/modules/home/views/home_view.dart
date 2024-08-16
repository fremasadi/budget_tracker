import 'package:budget_tracker/app/styles/app_colors.dart';
import 'package:budget_tracker/app/styles/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../components/history_card.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(8.sp),
        child: IconButton(
          icon: Icon(
            Icons.add,
            color: AppColors.white,
            size: 22.sp,
          ),
          onPressed: () {
            Get.toNamed(Routes.ADD_TRANSACTION);
          },
        ),
      ),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        title: Text(
          controller.getGreeting(),
          style: AppFonts.semiBold.copyWith(
            fontSize: 22.sp,
            color: AppColors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.HISTORY_TRANSACTION);
              },
              icon: Image.asset(
                'assets/icons/ic_history.png',
                width: 30.w,
                height: 30.h,
              )),
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.SETTING);
            },
            icon: Icon(
              Icons.settings,
              size: 30.sp,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 33.0.sp),
                  child: Container(
                    height: 230,
                    decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(22)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
                  child: Container(
                    margin: EdgeInsets.only(top: 22.sp),
                    padding: EdgeInsets.symmetric(vertical: 24.sp),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(22)),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Total Balance',
                            style: AppFonts.semiBold.copyWith(
                              fontSize: 16.sp,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Center(
                          child: Text(
                            '\$6.890.000',
                            style: AppFonts.extraBold.copyWith(
                              fontSize: 32.sp,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0.sp),
                                    child: Icon(
                                      Icons.arrow_downward,
                                      size: 18.sp,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Expenses',
                                      style: AppFonts.semiBold.copyWith(
                                        fontSize: 12.sp,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    Text(
                                      '\$1.000.000',
                                      style: AppFonts.extraBold.copyWith(
                                        fontSize: 14.sp,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0.sp),
                                    child: Icon(
                                      Icons.arrow_upward,
                                      size: 18.sp,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Income',
                                      style: AppFonts.semiBold.copyWith(
                                        fontSize: 12.sp,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    Text(
                                      '\$1.000.000',
                                      style: AppFonts.extraBold.copyWith(
                                        fontSize: 14.sp,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0.sp, bottom: 20.sp),
            child: Text(
              'Expenses In Month',
              style: AppFonts.regular.copyWith(
                fontSize: 22.sp,
                color: AppColors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return HistoryCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}
