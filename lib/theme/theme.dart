import 'package:flutter/material.dart';

import '../global/color.dart';

class AppTheme {

  static ThemeData getThemeData() {
    return ThemeData(
      colorScheme: _colorScheme(),
      textTheme: _textTheme(),
      inputDecorationTheme: _inputDecorationTheme(),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
      ),
    );
  }

  static ColorScheme _colorScheme() {
    return const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.grey_600,
        onPrimary: Colors.white,
        secondary: AppColors.orange_600,
        onSecondary: Colors.white,
        error: AppColors.red_600,
        onError: Colors.white,
        surface: Colors.white,
        onSurface: AppColors.grey_900
    );
  }

  static TextTheme _textTheme() {
    return const TextTheme(
      displayLarge: TextStyle(fontFamily: 'Inter', fontSize: 57, fontVariations: [FontVariation('wght', 900)]),
      displayMedium: TextStyle(fontFamily: 'Inter', fontSize: 45, fontVariations: [FontVariation('wght', 800)]),
      displaySmall: TextStyle(fontFamily: 'Inter', fontSize: 36, fontVariations: [FontVariation('wght', 700)]),
      headlineLarge: TextStyle(fontFamily: 'Inter', fontSize: 32, fontVariations: [FontVariation('wght', 600)]),
      headlineMedium: TextStyle(fontFamily: 'Inter', fontSize: 28, fontVariations: [FontVariation('wght', 500)]),
      headlineSmall: TextStyle(fontFamily: 'Inter', fontSize: 24, fontVariations: [FontVariation('wght', 400)]),

      titleLarge: TextStyle(fontFamily: 'Inter', fontSize: 22, fontVariations: [FontVariation('wght', 400)]),

      // Used by TextField (hint text) by default?
      titleMedium: TextStyle(fontFamily: 'Inter', fontSize: 15, fontVariations: [FontVariation('wght', 300)]),
      titleSmall: TextStyle(fontFamily: 'Inter', fontSize: 14, fontVariations: [FontVariation('wght', 300)]),

      // Used by TextField by default?
      bodyLarge: TextStyle(fontFamily: 'Inter', fontSize: 15, fontVariations: [FontVariation('wght', 300)]),

      // User by Text by default?
      bodyMedium: TextStyle(fontFamily: 'Inter', fontSize: 15, fontVariations: [FontVariation('wght', 300)]),
      bodySmall: TextStyle(fontFamily: 'Inter', fontSize: 12, fontVariations: [FontVariation('wght', 300)]),

      // User for Button's by default?
      labelLarge: TextStyle(fontFamily: 'Inter', fontSize: 14, fontVariations: [FontVariation('wght', 300)]),
      labelMedium: TextStyle(fontFamily: 'Inter', fontSize: 12, fontVariations: [FontVariation('wght', 300)]),
      labelSmall: TextStyle(fontFamily: 'Inter', fontSize: 10, fontVariations: [FontVariation('wght', 300)]),
    );
  }

  static InputDecorationTheme _inputDecorationTheme() {
    return const InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.grey_500)
    );
  }

}