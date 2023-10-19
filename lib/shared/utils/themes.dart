import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialite/shared/enum/enum.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/font_manager.dart';
import 'package:socialite/shared/utils/style_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

final getThemeData = {
  AppTheme.lightTheme: ThemeData(
    //Colors
    primaryColor: ColorManager.primaryColor,
    primaryColorLight: ColorManager.titanWithColor,
    primaryColorDark: ColorManager.primaryDarkColor,
    disabledColor: ColorManager.greyColor,
    splashColor: ColorManager.primaryColor,

    //Cards Theme
    cardTheme: const CardTheme(
      color: ColorManager.whiteColor,
      shadowColor: ColorManager.greyColor,
      elevation: AppSize.s4,
    ),

    //AppBar Theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: Colors.transparent,
        elevation: AppSize.s0,
        shadowColor: ColorManager.greyColor,
        titleTextStyle: getRegularStyle(
          color: ColorManager.blackColor,
          fontSize: FontSize.s16,
        )),

    //Button Theme
    buttonTheme: const ButtonThemeData(
        shape: StadiumBorder(),
        disabledColor: ColorManager.greyColor,
        buttonColor: ColorManager.primaryColor,
        splashColor: ColorManager.primaryDarkColor),

    //Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
              color: ColorManager.whiteColor,
              fontSize: FontSize.s17,
            ),
            backgroundColor: ColorManager.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),

    //Text Theme
    textTheme: TextTheme(
      headlineLarge:
          getBoldStyle(color: ColorManager.whiteColor, fontSize: FontSize.s60),
      displayLarge:
          getBoldStyle(color: ColorManager.blackColor, fontSize: FontSize.s40),
      titleLarge: getBoldStyle(
          color: ColorManager.whiteColor, fontSize: FontSize.s18, height: 2),
      headlineMedium:
          getBoldStyle(color: ColorManager.blackColor, fontSize: FontSize.s20),
      headlineSmall: getRegularStyle(
          color: ColorManager.greyDarkColor, fontSize: FontSize.s14),
      titleMedium:
          getMediumStyle(color: ColorManager.greyColor, fontSize: FontSize.s16),
      bodySmall: getRegularStyle(color: ColorManager.greyColor),
      bodyLarge: getRegularStyle(color: ColorManager.greyColor),
    ),

    dialogTheme: DialogTheme(
        backgroundColor: ColorManager.whiteColor,
        titleTextStyle: getBoldStyle(
            color: ColorManager.blackColor, fontSize: FontSize.s18),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s16)),
        contentTextStyle: getRegularStyle(color: ColorManager.blackColor),
        alignment: Alignment.center),

    //Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
        color: ColorManager.greyColor,
        fontSize: FontSize.s14,
      ),
      labelStyle: getMediumStyle(
        color: ColorManager.greyColor,
        fontSize: FontSize.s14,
      ),
      errorStyle: getRegularStyle(color: ColorManager.redColor, height: 1),
      enabledBorder: const OutlineInputBorder(
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
      focusedBorder: const OutlineInputBorder(
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
      errorBorder: const OutlineInputBorder(
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
      focusedErrorBorder: const OutlineInputBorder(
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
      headlineLarge:
          getBoldStyle(color: ColorManager.whiteColor, fontSize: FontSize.s60),
      displayLarge:
          getBoldStyle(color: ColorManager.blackColor, fontSize: FontSize.s40),
      titleLarge: getBoldStyle(
          color: ColorManager.whiteColor, fontSize: FontSize.s18, height: 2),
      headlineMedium:
          getBoldStyle(color: ColorManager.blackColor, fontSize: FontSize.s20),
      headlineSmall: getRegularStyle(
          color: ColorManager.greyDarkColor, fontSize: FontSize.s14),
      titleMedium:
          getMediumStyle(color: ColorManager.greyColor, fontSize: FontSize.s16),
      bodySmall: getRegularStyle(color: ColorManager.greyColor),
      bodyLarge: getRegularStyle(color: ColorManager.greyColor),
    ),

    dialogTheme: DialogTheme(
        backgroundColor: ColorManager.whiteColor,
        titleTextStyle: getBoldStyle(
            color: ColorManager.blackColor, fontSize: FontSize.s18),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s16)),
        contentTextStyle: getRegularStyle(color: ColorManager.blackColor),
        alignment: Alignment.center),

    //Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
        color: ColorManager.greyColor,
        fontSize: FontSize.s14,
      ),
      labelStyle: getMediumStyle(
        color: ColorManager.greyColor,
        fontSize: FontSize.s14,
      ),
      errorStyle: getRegularStyle(color: ColorManager.redColor, height: 1),
      enabledBorder: const OutlineInputBorder(
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
      focusedBorder: const OutlineInputBorder(
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
      errorBorder: const OutlineInputBorder(
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
      focusedErrorBorder: const OutlineInputBorder(
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
