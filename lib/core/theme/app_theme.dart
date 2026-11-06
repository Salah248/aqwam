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
    fontFamily: AqwamTypography.uiFontFamily,
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: AqwamTypography.displaySize,
        fontWeight: AqwamTypography.displayWeight,
      ),
      titleLarge: TextStyle(
        fontSize: AqwamTypography.titleSize,
        height: AqwamTypography.titleLineHeight,
        fontWeight: AqwamTypography.titleWeight,
      ),
      titleMedium: TextStyle(
        fontSize: AqwamTypography.sectionTitleSize,
        height: AqwamTypography.sectionTitleLineHeight,
        fontWeight: AqwamTypography.sectionTitleWeight,
      ),
      bodyMedium: TextStyle(
        fontSize: AqwamTypography.bodySize,
        height: AqwamTypography.bodyLineHeight,
        fontWeight: AqwamTypography.bodyWeight,
      ),
      labelLarge: TextStyle(
        fontSize: AqwamTypography.actionSize,
        fontWeight: AqwamTypography.actionWeight,
      ),
      labelMedium: TextStyle(
        fontSize: AqwamTypography.labelSize,
        height: AqwamTypography.labelLineHeight,
        fontWeight: AqwamTypography.labelWeight,
      ),
      labelSmall: TextStyle(
        fontSize: AqwamTypography.hintSize,
        height: AqwamTypography.hintLineHeight,
        fontWeight: AqwamTypography.hintWeight,
      ),
    ).apply(bodyColor: tokens.text, displayColor: tokens.text),
  );
}

ThemeData buildLightTheme() => _buildTheme(AqwamColors.light, Brightness.light);

ThemeData buildDarkTheme() => _buildTheme(AqwamColors.dark, Brightness.dark);
