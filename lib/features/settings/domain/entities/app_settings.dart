import 'package:flutter/material.dart';

import 'package:aqwam/core/utils/number_formatter.dart';

@immutable
final class AppSettings {
  const AppSettings({
    required this.themeMode,
    required this.locale,
    required this.digitStyle,
  });

  const AppSettings.defaults()
    : themeMode = ThemeMode.light,
      locale = const Locale('ar'),
      digitStyle = DigitStyle.arabicIndic;

  final ThemeMode themeMode;
  final Locale locale;
  final DigitStyle digitStyle;

  AppSettings copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    DigitStyle? digitStyle,
  }) => AppSettings(
    themeMode: themeMode ?? this.themeMode,
    locale: locale ?? this.locale,
    digitStyle: digitStyle ?? this.digitStyle,
  );

  @override
  bool operator ==(Object other) =>
      other is AppSettings &&
      other.themeMode == themeMode &&
      other.locale == locale &&
      other.digitStyle == digitStyle;

  @override
  int get hashCode => Object.hash(themeMode, locale, digitStyle);
}
