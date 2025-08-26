import 'package:flutter/material.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';

class AppTheme {
  static final ThemeData darkTheme=ThemeData(
    scaffoldBackgroundColor: AppColors.blackColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.blackColor,
      iconTheme: IconThemeData(color: AppColors.primaryColor)
    )
  );
}