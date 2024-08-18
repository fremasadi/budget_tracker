import 'package:budget_tracker/app/data/services/firebase_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app/routes/app_pages.dart';
import 'app/styles/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBy38pDp23wpl9jdiskTIal94RoXPXPWBQ',
      appId: '1:880634012461:android:c5ba1a95c1166f1672e9a4',
      messagingSenderId: '880634012461',
      projectId: 'absensi-9da95',
    ),
  );
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          builder: (context, child) {
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
                data: data.copyWith(
                  textScaler: const TextScaler.linear(1.10),
                ),
                child: child!);
          },
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.white,
            textTheme: GoogleFonts.nunitoTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
