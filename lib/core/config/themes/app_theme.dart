import 'package:flutter/material.dart';
import 'package:sistem_magang/core/config/themes/app_color.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    brightness: Brightness.light
  );
}