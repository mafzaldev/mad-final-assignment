import 'package:flutter/material.dart';

class Utils {
  void showSnackBar(
      BuildContext context, Color backgroundColor, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }
}

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      primarySwatch: Colors.teal,
    );
  }
}
