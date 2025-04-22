import 'package:flutter/material.dart';
import 'app_color.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.primaryColor,
    scaffoldBackgroundColor: AppColor.whiteColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.primaryColor,
      foregroundColor: AppColor.whiteColor,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColor.blackColor),
      bodyMedium: TextStyle(color: AppColor.blackColor),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColor.primaryColor,
    scaffoldBackgroundColor: AppColor.blackColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.primaryColor,
      foregroundColor: AppColor.whiteColor,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColor.whiteColor),
      bodyMedium: TextStyle(color: AppColor.whiteColor),
    ),
  );
}

