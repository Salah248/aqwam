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
    fontFamily: AqwamFontFamily.cairo,
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: AqwamFontSize.f26,
        fontWeight: AqwamFontWeight.fw800,
      ),
      titleLarge: TextStyle(
        fontSize: AqwamFontSize.f19,
        height: AqwamLineHeight.lh1d25,
        fontWeight: AqwamFontWeight.fw800,
      ),
      titleMedium: TextStyle(
        fontSize: AqwamFontSize.f16,
        height: AqwamLineHeight.lh1d3,
        fontWeight: AqwamFontWeight.fw800,
      ),
      bodyMedium: TextStyle(
        fontSize: AqwamFontSize.f12d5,
        height: AqwamLineHeight.lh1d5,
        fontWeight: AqwamFontWeight.fw700,
      ),
      labelLarge: TextStyle(
        fontSize: AqwamFontSize.f13,
        fontWeight: AqwamFontWeight.fw800,
      ),
      labelMedium: TextStyle(
        fontSize: AqwamFontSize.f11d5,
        height: AqwamLineHeight.lh1d4,
        fontWeight: AqwamFontWeight.fw700,
      ),
      labelSmall: TextStyle(
        fontSize: AqwamFontSize.f11,
        height: AqwamLineHeight.lh1d8,
        fontWeight: AqwamFontWeight.fw600,
      ),
    ).apply(bodyColor: tokens.text, displayColor: tokens.text),
  );
}

ThemeData buildLightTheme() => _buildTheme(AqwamColors.light, Brightness.light);

ThemeData buildDarkTheme() => _buildTheme(AqwamColors.dark, Brightness.dark);
