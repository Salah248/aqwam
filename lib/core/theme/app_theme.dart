import 'package:flutter/material.dart';

import 'aqwam_tokens.dart';

ThemeData _buildTheme(AqwamColors tokens, Brightness brightness) {
  final colorScheme = ColorScheme(
    brightness: brightness,
    primary: tokens.primary,
    onPrimary: tokens.onPrimary,
    secondary: tokens.accent,
    onSecondary: tokens.onPrimary,
    error: tokens.primary,
    onError: tokens.onPrimary,
    surface: tokens.surface,
    onSurface: tokens.text,
  );
  return ThemeData(
    brightness: brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: tokens.background,
    extensions: <ThemeExtension<dynamic>>[tokens],
    fontFamily: 'Cairo',
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
      bodyMedium: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
      labelMedium: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700),
    ).apply(bodyColor: tokens.text, displayColor: tokens.text),
  );
}

ThemeData buildLightTheme() => _buildTheme(AqwamColors.light, Brightness.light);

ThemeData buildDarkTheme() => _buildTheme(AqwamColors.dark, Brightness.dark);
