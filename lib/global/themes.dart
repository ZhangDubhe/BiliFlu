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
    height: 44,
    padding: EdgeInsets.all(0)
  );

  static List<BoxShadow> commonShadow({Color color = Colors.black12, double opacity = 0.1, Offset offset = const Offset(0.0, 3), double radius = 3.0}) {
    return [
      BoxShadow(
        color: color.withOpacity(0.08),
        offset: offset,
        blurRadius: 15,
      ),
    ];
  }

  static Border commonBorder ({Color color = Colors.black12}) {
    return Border.all(color: color, width: 1);
  }

  static BorderRadius commonRadius({double radius = 20}) {
    return BorderRadius.only(topLeft: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
        bottomRight: Radius.circular(radius));
  }
}