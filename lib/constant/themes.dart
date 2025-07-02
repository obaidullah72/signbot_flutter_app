import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF1E88E5);
  static const Color secondary = Color(0xFF90CAF9);
  static const Color accent = Color(0xFF00ACC1);
  static const Color background = Color(0xFFF5F5F5);
  static const Color textDark = Color(0xFF212121);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        tertiary: accent,
        surface: background,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: textDark,
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
        bodyLarge: TextStyle(
          color: textDark,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}