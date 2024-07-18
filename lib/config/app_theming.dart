import 'package:dashboard_task/core/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheming {

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.primaryColor ,
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light ,
      primary: AppColors.blueLightColor
    )
  );
}