import 'package:flutter/material.dart';

import 'aqwam_tokens.dart';

ThemeData buildAppTheme(Brightness brightness) {
  final tokens = brightness == Brightness.light
      ? AqwamTokens.light
      : AqwamTokens.dark;
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
    textTheme:
        const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w800),
          bodyMedium: TextStyle(fontWeight: FontWeight.w700),
          labelMedium: TextStyle(fontWeight: FontWeight.w700),
        ).apply(
          bodyColor: tokens.text,
          displayColor: tokens.text,
        ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: tokens.surface,
      indicatorColor: tokens.primaryContainer,
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(
          color: tokens.text,
          fontSize: AqwamTokens.navSize,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}
