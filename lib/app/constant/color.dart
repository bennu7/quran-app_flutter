import 'package:flutter/material.dart';

const appPurple = Color(0xFF431AA1);
const appPurpleDark = Color(0xFF1E0771);
const appPurpleLight1 = Color(0xFF9345F2);
const appPurpleLight2 = Color(0xFFB9A2D8);
const appWhite = Color(0xFFFAF8FC);
const appOren = Color(0xFFE6704A);

ThemeData themeLight = ThemeData(
  // atur brightness agar bisa menyasuakian theme
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: appPurpleDark),
  brightness: Brightness.light,
  primaryColor: appPurple,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    elevation: 4,
    backgroundColor: appPurple,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: appPurpleDark),
    bodyText2: TextStyle(color: appPurpleDark),
  ),
);

ThemeData themeDark = ThemeData(
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: appWhite),
  brightness: Brightness.dark,
  primaryColor: appPurpleLight2,
  scaffoldBackgroundColor: appPurpleDark,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: appPurpleDark,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: appWhite),
    bodyText2: TextStyle(color: appWhite),
  ),
);