import 'package:easy_world_vendor/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  return ThemeData.light().copyWith(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backGroundColor,
    textTheme: getLightTextTheme(),
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.primaryColor,
      background: AppColors.backGroundColor,
      outline: AppColors.lGrey,
      onSurface: AppColors.lGrey,
      onBackground: AppColors.blackColor,
      shadow: AppColors.shadowColor,
      error: AppColors.errorColor,
    ),
  );
}

TextTheme getLightTextTheme() {
  return ThemeData.light().textTheme.copyWith().apply(
    bodyColor: AppColors.blackColor,
    displayColor: AppColors.blackColor,
    decorationColor: AppColors.secondaryTextColor,
  );
}

TextTheme getDarkTextTheme() {
  return ThemeData.dark().textTheme.copyWith().apply(
    bodyColor: AppColors.backGroundColor,
    displayColor: AppColors.backGroundColor,
    decorationColor: AppColors.secondaryTextColor,
  );
}

ThemeData darkTheme() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  return ThemeData.dark().copyWith(
    textTheme: getDarkTextTheme(),
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backGroundDark,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.primaryColor,
      background: AppColors.backGroundDark,
      onBackground: AppColors.backGroundColor,
      onSurface: AppColors.onBackGroundDark,
      outline: AppColors.lGrey,
      shadow: AppColors.shadowDark,
      error: AppColors.errorColor,
    ),
  );
}
