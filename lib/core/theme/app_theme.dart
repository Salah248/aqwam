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
    fontFamily: AqwamTokens.vCairo,
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: AqwamTokens.f26,
        fontWeight: AqwamTokens.fw800,
      ),
      titleLarge: TextStyle(
        fontSize: AqwamTokens.f19,
        height: AqwamTokens.lh1d25,
        fontWeight: AqwamTokens.fw800,
      ),
      titleMedium: TextStyle(
        fontSize: AqwamTokens.f16,
        height: AqwamTokens.lh1d3,
        fontWeight: AqwamTokens.fw800,
      ),
      bodyMedium: TextStyle(
        fontSize: AqwamTokens.f12d5,
        height: AqwamTokens.lh1d5,
        fontWeight: AqwamTokens.fw700,
      ),
      labelLarge: TextStyle(
        fontSize: AqwamTokens.f13,
        fontWeight: AqwamTokens.fw800,
      ),
      labelMedium: TextStyle(
        fontSize: AqwamTokens.f11d5,
        height: AqwamTokens.lh1d4,
        fontWeight: AqwamTokens.fw700,
      ),
      labelSmall: TextStyle(
        fontSize: AqwamTokens.f11,
        height: AqwamTokens.lh1d8,
        fontWeight: AqwamTokens.fw600,
      ),
    ).apply(bodyColor: tokens.text, displayColor: tokens.text),
  );
}

ThemeData buildLightTheme() => _buildTheme(AqwamColors.light, Brightness.light);

ThemeData buildDarkTheme() => _buildTheme(AqwamColors.dark, Brightness.dark);
