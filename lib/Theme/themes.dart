import 'package:flutter/material.dart';

final ThemeData kLightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.black,
  backgroundColor: const Color.fromRGBO(45, 43, 85, 1),
  appBarTheme: const AppBarTheme(
    color: Colors.blue,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 18),
    bodyText2: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
    subtitle1: TextStyle(color: Colors.green, fontWeight: FontWeight.w400, fontSize: 18),
    headline2: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
    headline5: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
    headline6: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 13),
  ),
);

final ThemeData kDarkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.grey,
  ),
);
