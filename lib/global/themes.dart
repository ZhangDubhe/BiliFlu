import 'package:flutter/material.dart';

class GlobalTheme {
  static ThemeData buildTheme() {
    return ThemeData(
      primaryColor: Colors.pink,
      primarySwatch: Colors.pink,
      buttonTheme: primaryButtonTheme,
      backgroundColor: Colors.white,
    );
  }

  static ButtonThemeData primaryButtonTheme = ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    disabledColor: Colors.pink[100],
    height: 44
  );
}