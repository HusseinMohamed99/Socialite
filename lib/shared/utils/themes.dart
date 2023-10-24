import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialite/shared/enum/enum.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/font_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

final getThemeData = {
  AppTheme.lightTheme: ThemeData(
    cardColor: ColorManager.titanWithColor,
    cardTheme: const CardTheme(
      color: ColorManager.titanWithColor,
    ),
    scaffoldBackgroundColor: ColorManager.scaffoldBackgroundColor,
    primarySwatch: Colors.blue,
    appBarTheme: AppBarTheme(
      titleSpacing: 6,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.scaffoldBackgroundColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      backgroundColor: ColorManager.scaffoldBackgroundColor,
      elevation: 0,
      titleTextStyle: GoogleFonts.roboto(
        color: ColorManager.greyDarkColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: ColorManager.blackColor,
      ),
      actionsIconTheme: const IconThemeData(
        color: ColorManager.blackColor,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorManager.blueColor,
      unselectedItemColor: ColorManager.greyDarkColor,
      backgroundColor: ColorManager.scaffoldBackgroundColor,
      elevation: 25.0,
      unselectedIconTheme: IconThemeData(
        color: ColorManager.greyDarkColor,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.roboto(
        color: ColorManager.blackColor,
        fontSize: FontSize.s18,
        height: 2,
      ),
      bodyMedium: GoogleFonts.roboto(
        color: ColorManager.blackColor,
        fontWeight: FontWeight.w500,
      ),
      displayLarge: GoogleFonts.roboto(
          color: ColorManager.blackColor, fontSize: FontSize.s40),
      headlineMedium: GoogleFonts.roboto(
        color: ColorManager.blackColor,
        fontSize: FontSize.s20,
      ),
      headlineLarge: GoogleFonts.roboto(
          color: ColorManager.blackColor, fontSize: FontSize.s60),
      headlineSmall: GoogleFonts.roboto(
        color: ColorManager.greyDarkColor,
        fontSize: FontSize.s14,
      ),
      titleMedium: GoogleFonts.roboto(
        color: ColorManager.greyColor,
        fontSize: FontSize.s16,
      ),
      bodyLarge: GoogleFonts.roboto(
        color: ColorManager.greyColor,
      ),
    ),
  ),
  AppTheme.darkTheme: ThemeData(
    cardColor: ColorManager.titanWithColor,
    cardTheme: const CardTheme(
      color: ColorManager.blackColor,
    ),
    scaffoldBackgroundColor: ColorManager.scaffoldBackgroundDarkColor,
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      titleSpacing: 6,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorManager.scaffoldBackgroundDarkColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      backgroundColor: ColorManager.scaffoldBackgroundDarkColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: ColorManager.whiteColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: ColorManager.whiteColor,
      ),
      actionsIconTheme: IconThemeData(
        color: ColorManager.whiteColor,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorManager.whiteColor,
      unselectedItemColor: ColorManager.greyColor,
      backgroundColor: ColorManager.scaffoldBackgroundDarkColor,
      elevation: 25.0,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.roboto(
        color: ColorManager.whiteColor,
        fontSize: FontSize.s18,
        height: 2,
      ),
      bodyMedium: GoogleFonts.roboto(
        color: ColorManager.whiteColor,
        fontWeight: FontWeight.w500,
      ),
      displayLarge: GoogleFonts.roboto(
          color: ColorManager.whiteColor, fontSize: FontSize.s40),
      headlineMedium: GoogleFonts.roboto(
        color: ColorManager.whiteColor,
        fontSize: FontSize.s20,
      ),
      headlineLarge: GoogleFonts.roboto(
          color: ColorManager.whiteColor, fontSize: FontSize.s60),
      headlineSmall: GoogleFonts.roboto(
        color: ColorManager.greyDarkColor,
        fontSize: FontSize.s14,
      ),
      titleMedium: GoogleFonts.roboto(
        color: ColorManager.greyColor,
        fontSize: FontSize.s16,
      ),
      bodyLarge: GoogleFonts.roboto(
        color: ColorManager.greyColor,
      ),
    ),
    iconTheme: const IconThemeData(
      color: ColorManager.whiteColor,
    ),

    //Input Decoration Theme
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(AppPadding.p8),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.greyColor,
          width: AppSize.s0_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primaryColor,
          width: AppSize.s0_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.redColor,
          width: AppSize.s0_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primaryColor,
          width: AppSize.s0_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
    ),
  ),
};
