import 'package:flutter/material.dart';

class AppColor{
    static Color primaryColor = const Color.fromRGBO(0, 123, 255, 1);  // Light Blue
  static Color primaryAccent = const Color.fromRGBO(0, 86, 179, 1);  // Darker Blue
  static Color secondaryColor = const Color.fromARGB(255, 92, 92, 92);
    static Color secondaryAccent = const Color.fromARGB(255, 255, 255, 255);
  static Color titleColor = const Color.fromRGBO(200, 200, 200, 1);
  static Color textColor = const Color.fromARGB(255, 37, 37, 37);
  static Color successColor = const Color.fromRGBO(9, 149, 110, 1);
  static Color highlightColor = const Color.fromRGBO(212, 172, 13, 1);
}

ThemeData primaryTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryAccent),

  scaffoldBackgroundColor: AppColor.secondaryAccent,

  appBarTheme: AppBarTheme(
    backgroundColor: AppColor.primaryAccent,
    foregroundColor: AppColor.textColor,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: AppColor.textColor,
      fontSize: 16,
      letterSpacing: 1,
    ),
    headlineMedium: TextStyle(
      color: AppColor.textColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 1
    ),
    titleMedium: TextStyle(
      color: AppColor.textColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 2
    )
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColor.secondaryColor.withOpacity(0.5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25)
    ),
    labelStyle: TextStyle(color: AppColor.textColor),
    prefixIconColor: AppColor.textColor
  ),
);