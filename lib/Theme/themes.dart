import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:flutter/material.dart';

final kLightTheme = ThemeData.light().copyWith(
  primaryColor: AppColors.black,
  backgroundColor: AppColors.mainGrey,
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    titleTextStyle: AppFonts.main,
  ),
  scrollbarTheme: const ScrollbarThemeData().copyWith(
    thumbColor: MaterialStateProperty.all(AppColors.green),
    thickness: MaterialStateProperty.all(2),
  ),
);

final ThemeData kDarkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.grey,
  ),
);
