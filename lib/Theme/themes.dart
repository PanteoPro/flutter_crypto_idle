import 'package:flutter/material.dart';

final ThemeData kLightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.white,
  backgroundColor: const Color.fromRGBO(45, 43, 85, 1),
  canvasColor: const Color.fromRGBO(48, 65, 95, 1),
  splashColor: const Color.fromRGBO(46, 43, 151, 1),
  appBarTheme: const AppBarTheme(
    color: Color.fromRGBO(30, 30, 63, 1),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16),
    bodyText2: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
    subtitle1: TextStyle(color: Color.fromRGBO(123, 115, 228, 1), fontWeight: FontWeight.w400, fontSize: 16),
    headline1: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
    headline2: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
    headline5: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
    headline6: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 13),
    subtitle2: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 12),
  ),
);

final kLightTheme2 = ThemeData.light().copyWith(
  primaryColor: Colors.black,
  backgroundColor: const Color.fromRGBO(27, 28, 32, 1),
  canvasColor: const Color.fromRGBO(13, 14, 16, 1),
  hintColor: const Color.fromRGBO(0, 210, 149, 1),
  appBarTheme: const AppBarTheme(
    color: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: 16,
      fontFamily: 'Bahnschrift',
    ),
    bodyText2: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: 14,
      fontFamily: 'Bahnschrift',
    ),
    headline1: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: 20,
      fontFamily: 'Bahnschrift',
    ),
    headline2: TextStyle(
      color: Color.fromRGBO(0, 210, 149, 1),
      fontWeight: FontWeight.normal,
      fontSize: 20,
      fontFamily: 'Bahnschrift',
    ),
    headline3: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: 18,
      fontFamily: 'Bahnschrift',
    ),
    button: TextStyle(
      color: Color.fromRGBO(0, 210, 149, 1),
      fontWeight: FontWeight.normal,
      fontSize: 24,
      fontFamily: 'Bahnschrift',
    ),
  ),
);

final ThemeData kDarkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.grey,
  ),
);
