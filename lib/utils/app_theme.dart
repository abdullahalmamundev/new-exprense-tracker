import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.yellow,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor:
    AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor:
      AppColors.background,
      foregroundColor: Colors.white,
    ),
  );
}