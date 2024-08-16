import 'package:budget_tracker/app/routes/app_pages.dart';
import 'package:budget_tracker/app/styles/app_colors.dart';
import 'package:budget_tracker/app/styles/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 28.sp,
            color: AppColors.black,
          ),
        ),
        backgroundColor: AppColors.white,
        title: Text(
          'Setting',
          style: AppFonts.semiBold.copyWith(
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0.sp),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.CATEGORIES);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 17.sp, horizontal: 20.sp),
                  margin: EdgeInsets.only(bottom: 8.sp),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20.sp),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.grid_view_sharp,
                        color: AppColors.primary,
                        size: 28.sp,
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                      Text(
                        'Categories',
                        style: AppFonts.semiBold.copyWith(
                          fontSize: 16.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: 14.sp, horizontal: 20.sp),
                margin: EdgeInsets.only(bottom: 8.sp),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20.sp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4), // Posisi bayangan (x,y)
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.notifications,
                          color: Colors.red,
                          size: 28.sp,
                        ),
                        SizedBox(
                          width: 25.w,
                        ),
                        Text(
                          'Notification',
                          style: AppFonts.semiBold.copyWith(
                            fontSize: 16.sp,
                          ),
                        )
                      ],
                    ),
                    Obx(() {
                      return Switch(
                        value: controller.isNotificationActive.value,
                        onChanged: (value) {
                          controller.toggleNotification();
                        },
                        activeColor: AppColors.primary,
                        inactiveThumbColor: AppColors.grey,
                        inactiveTrackColor: AppColors.grey.withOpacity(0.4),
                      );
                    }),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: 17.sp, horizontal: 20.sp),
                margin: EdgeInsets.only(bottom: 8.sp),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20.sp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4), // Posisi bayangan (x,y)
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.question_mark,
                      color: AppColors.primary,
                      size: 28.sp,
                    ),
                    SizedBox(
                      width: 25.w,
                    ),
                    Text(
                      'About',
                      style: AppFonts.semiBold.copyWith(
                        fontSize: 16.sp,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
