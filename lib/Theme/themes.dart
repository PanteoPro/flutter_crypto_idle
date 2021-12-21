import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:flutter/material.dart';

final kLightTheme2 = ThemeData.light().copyWith(
  primaryColor: AppColors.black,
  backgroundColor: AppColors.mainGrey,
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    titleTextStyle: AppFonts.main,
  ),
);

final ThemeData kDarkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.grey,
  ),
);
