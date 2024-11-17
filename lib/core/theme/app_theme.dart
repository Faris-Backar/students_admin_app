import 'package:flutter/material.dart';
import 'package:student_app_admin/gen/fonts.gen.dart';
// import 'package:students_notes_app/gen/fonts.gen.dart';

class AppTheme {
  static const Color darkPurple = Color(0xFF433878);
  static const Color mediumPurple = Color(0xFF7E60BF);
  static const Color lightPurple = Color(0xFFE4B1F0);
  static const Color palePink = Color(0xFFFFE1FF);
  static const Color black = Color(0xFF181C14);
  static const Color white = Colors.white;
  static const Color grey = Color(0xFFB7B7B7);
  static const Color error = Color(0xFFB8001F);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: darkPurple,
      hintColor: mediumPurple,
      colorScheme: ColorScheme.fromSwatch(backgroundColor: palePink),
      // scaffoldBackgroundColor: palePink,
      fontFamily: FontFamily.poppins,
      appBarTheme: const AppBarTheme(
          color: white, elevation: 0.0, foregroundColor: black),
      textTheme: const TextTheme(
        displayLarge:
            TextStyle(color: black, fontSize: 32, fontWeight: FontWeight.bold),
        displayMedium:
            TextStyle(color: black, fontSize: 28, fontWeight: FontWeight.bold),
        displaySmall:
            TextStyle(color: black, fontSize: 24, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: black, fontSize: 16),
        bodyMedium: TextStyle(color: black, fontSize: 14),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: mediumPurple,
        textTheme: ButtonTextTheme.primary,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: darkPurple,
      ),
    );
  }
}
