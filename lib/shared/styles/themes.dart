import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeApp {
  static const Color darkPrimary = Color(0xff141A2E);
  static const Color yellow = Color(0xffFACC1D);
  static const Color white = Color(0xffffffff);

  static final ThemeData darkTheme = ThemeData(
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: darkPrimary,
    ),
    cardColor: darkPrimary,
    scaffoldBackgroundColor: darkPrimary,
    primarySwatch: Colors.blue,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0.sp,
        fontWeight: FontWeight.bold,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        size: 30.sp,
        color: yellow,
      ),
      unselectedIconTheme: IconThemeData(
        size: 24.sp,
        color: Colors.grey,
      ),
      selectedLabelStyle: const TextStyle(
        color: yellow,
      ),
      selectedItemColor: yellow,
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    cardColor: Colors.white,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0.sp,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0.sp,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        size: 36.sp,
        color: Colors.blueAccent,
      ),
      unselectedIconTheme: IconThemeData(
        size: 30.sp,
        color: Colors.grey,
      ),
      selectedLabelStyle: const TextStyle(
        color: Colors.blue,
      ),
      selectedItemColor: Colors.blueAccent,
    ),
  );
}
