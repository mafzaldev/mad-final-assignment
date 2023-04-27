import 'package:flutter/material.dart';

class Utils {
  void showSnackBar(
      BuildContext context, Color backgroundColor, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
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

class ApiConstants {
  static String apiUrl = 'https://dummyjson.com/posts/';
}
