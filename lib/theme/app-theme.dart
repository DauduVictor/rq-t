import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData themeData = ThemeData(
    colorScheme: _colorScheme,
    textTheme: _textTheme(_colorScheme),
    useMaterial3: false,
    toggleableActiveColor: AppColors.primaryColor,
    primaryColor: AppColors.primaryColor,
    fontFamily: 'Satoshi',
    highlightColor: Colors.transparent,
    dialogTheme: _dialogTheme,
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(AppColors.greenColor),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      splashRadius: 5,
      side: BorderSide(
        width: 1,
        color: AppColors.pureBlackColor.withOpacity(0.4),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0.35,
      toolbarHeight: 65,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: AppColors.whiteColor,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(
      brightness: Brightness.light,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.blackColor,
    ),
  );

  static const ColorScheme _colorScheme = ColorScheme(
    primary: AppColors.primaryColor,
    background: AppColors.lightBgColor,
    brightness: Brightness.dark,
    secondary: AppColors.secondaryColor,
    surface: AppColors.primaryColor,
    onBackground: AppColors.lightBgColor,
    onError: AppColors.redColor,
    onPrimary: AppColors.primaryColor,
    onSecondary: AppColors.secondaryColor,
    onSurface: AppColors.primaryColor,
    error: AppColors.redColor,
  );

  static TextTheme _textTheme(ColorScheme colorScheme) => TextTheme(
        headlineMedium: TextStyle(
          fontSize: 35.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
        headlineSmall: TextStyle(
          fontSize: 25.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor,
        ),
        titleLarge: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor,
        ),
        titleMedium: TextStyle(
          color: AppColors.blackColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        titleSmall: TextStyle(
          color: AppColors.blackColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
        bodyLarge: TextStyle(
          fontSize: 15.sp,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          fontSize: 18.sp,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          fontSize: 16.sp,
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w700,
        ),
      );

  static const DialogTheme _dialogTheme = DialogTheme(
    backgroundColor: AppColors.whiteColor,
  );
}
