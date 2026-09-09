import 'package:flutter/material.dart';

class AppTheme {
  // Figma exact colors (Tailwind CSS palette)
  static const Color purple600 = Color(0xFF9333EA); // purple-600 ka exact code
  static const Color pink500 = Color(0xFFEC4899); // pink-500 ka exact code
  static const Color orange400 = Color(0xFFFB923C); // orange-400 ka exact code

  static ThemeData lightTheme = ThemeData(
    primaryColor: purple600, // Main identity purple rakhi hai
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: pink500, // Secondary highlight pink hai
    ),
  );
}
