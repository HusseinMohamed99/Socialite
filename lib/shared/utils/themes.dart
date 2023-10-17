import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialite/shared/enum/enum.dart';
import 'package:socialite/shared/utils/color_manager.dart';

final getThemeData = {
  AppTheme.lightTheme: ThemeData(
    scaffoldBackgroundColor: ColorManager.titanWithColor,
    primarySwatch: Colors.blue,
    cardColor: ColorManager.titanWithColor,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: GoogleFonts.roboto(
        color: ColorManager.greyDarkColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: ColorManager.greyDarkColor,
        size: 24.sp,
      ),
      actionsIconTheme: IconThemeData(
        color: ColorManager.greyDarkColor,
        size: 24.sp,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorManager.blueColor,
      unselectedItemColor: ColorManager.greyDarkColor,
      backgroundColor: ColorManager.whiteColor,
      elevation: 25.0,
      unselectedIconTheme: IconThemeData(
        color: ColorManager.greyDarkColor,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.roboto(
        color: ColorManager.greyDarkColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
      labelLarge: GoogleFonts.roboto(
        color: ColorManager.greyDarkColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.roboto(
        color: ColorManager.greyDarkColor,
        fontWeight: FontWeight.w500,
      ),
      displayLarge: GoogleFonts.roboto(
        color: ColorManager.greyDarkColor,
      ),
      displayMedium: GoogleFonts.roboto(
        color: ColorManager.greyDarkColor,
      ),
      displaySmall: GoogleFonts.roboto(
        color: ColorManager.greyDarkColor,
        fontWeight: FontWeight.bold,
        fontSize: 40.sp,
      ),
      headlineMedium: GoogleFonts.roboto(
        color: ColorManager.greyDarkColor,
      ),
      headlineSmall: GoogleFonts.roboto(
        color: ColorManager.greyDarkColor,
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: GoogleFonts.roboto(
        color: ColorManager.greyDarkColor,
      ),
      bodyLarge: GoogleFonts.roboto(
        color: ColorManager.greyDarkColor,
      ),
    ),
  ),
  AppTheme.darkTheme: ThemeData(
    cardColor: ColorManager.primaryDarkColor,
    scaffoldBackgroundColor: ColorManager.primaryDarkColor,
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorManager.primaryDarkColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      backgroundColor: ColorManager.primaryDarkColor,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: ColorManager.whiteColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      actionsIconTheme: IconThemeData(
        color: ColorManager.whiteColor,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorManager.blueColor,
      unselectedItemColor: ColorManager.whiteColor,
      backgroundColor: ColorManager.greyDarkColor,
      elevation: 25.0,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.roboto(
        color: ColorManager.whiteColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
      labelLarge: GoogleFonts.roboto(
        color: ColorManager.whiteColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.roboto(
        color: ColorManager.whiteColor,
        fontWeight: FontWeight.w500,
      ),
      displayLarge: GoogleFonts.roboto(
        color: ColorManager.whiteColor,
      ),
      displayMedium: GoogleFonts.roboto(
        color: ColorManager.whiteColor,
      ),
      displaySmall: GoogleFonts.roboto(
        color: ColorManager.whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 40.sp,
      ),
      headlineMedium: GoogleFonts.roboto(
        color: ColorManager.whiteColor,
      ),
      headlineSmall: GoogleFonts.roboto(
        color: ColorManager.whiteColor,
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: GoogleFonts.roboto(
        color: ColorManager.whiteColor,
      ),
      bodyLarge: GoogleFonts.roboto(
        color: ColorManager.whiteColor,
      ),
    ),
    iconTheme: const IconThemeData(
      color: ColorManager.greyColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.roboto(
        color: ColorManager.whiteColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
      hintStyle: GoogleFonts.roboto(
        color: ColorManager.whiteColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.whiteColor,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.whiteColor,
        ),
      ),
    ),
  ),
};
