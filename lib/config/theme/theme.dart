import 'package:flutter/material.dart';

//Light Theme & Dark Theme
class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: Colors.green,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Colors.green,
      ),
      iconTheme: const IconThemeData(color: Colors.black54),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.black,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.green,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.grey[900],
      appBarTheme: const AppBarTheme(
        color: Colors.black,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.tealAccent,
      ),
    );
  }
}
