import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@immutable
final class AqwamColors extends ThemeExtension<AqwamColors> {
  const AqwamColors({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.primary,
    required this.primaryContainer,
    required this.accent,
    required this.text,
    required this.textSecondary,
    required this.divider,
    required this.success,
    required this.onPrimary,
    required this.onHero,
    required this.onHeroMuted,
    required this.onHeroCount,
    required this.heroStart,
    required this.heroEnd,
    required this.ornamentBlue,
    required this.ornamentLine,
    required this.successInk,
    required this.primaryInk,
  });

  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color primary;
  final Color primaryContainer;
  final Color accent;
  final Color text;
  final Color textSecondary;
  final Color divider;
  final Color success;
  final Color onPrimary;
  final Color onHero;
  final Color onHeroMuted;
  final Color onHeroCount;
  final Color heroStart;
  final Color heroEnd;
  final Color ornamentBlue;
  final Color ornamentLine;
  final Color successInk;
  final Color primaryInk;

  static const light = AqwamColors(
    background: Color(0xFFFBF5E3),
    surface: Color(0xFFFFFBEF),
    surfaceVariant: Color(0xFFF5EDD6),
    primary: Color(0xFF8A6400),
    primaryContainer: Color(0xFFF0E4BE),
    accent: Color(0xFFD4A72C),
    text: Color(0xFF2B2418),
    textSecondary: Color(0xFF6E6451),
    divider: Color(0xFFE8DDC5),
    success: Color(0xFF5F7C3A),
    onPrimary: Color(0xFFFFFCF2),
    onHero: Color(0xFFFFFCF2),
    onHeroMuted: Color(0xFFFFFCF2),
    onHeroCount: Color(0xFFFFFCF2),
    heroStart: Color(0xFF7A5900),
    heroEnd: Color(0xFF5A4200),
    ornamentBlue: Color(0xFF1B3A8B),
    ornamentLine: Color(0xFFB08A22),
    successInk: Color(0xFF4C6434),
    primaryInk: Color(0xFF6B5214),
  );

  static const dark = AqwamColors(
    background: Color(0xFF0E1626),
    surface: Color(0xFF151F33),
    surfaceVariant: Color(0xFF1E2A44),
    primary: Color(0xFFE8CF8A),
    primaryContainer: Color(0xFF303A4C),
    accent: Color(0xFF9DB4D9),
    text: Color(0xFFEDE6D3),
    textSecondary: Color(0xFFA9A491),
    divider: Color(0xFF2A3550),
    success: Color(0xFF8FB36B),
    onPrimary: Color(0xFF1A1405),
    onHero: Color(0xFFEDE6D3),
    onHeroMuted: Color(0xFFA9A491),
    onHeroCount: Color(0xFFE8CF8A),
    heroStart: Color(0xFF20304A),
    heroEnd: Color(0xFF18233A),
    ornamentBlue: Color(0xFF7E9BC4),
    ornamentLine: Color(0xFF9A8A55),
    successInk: Color(0xFF8FB36B),
    primaryInk: Color(0xFFE9D59E),
  );

  @override
  AqwamColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? primary,
    Color? primaryContainer,
    Color? accent,
    Color? text,
    Color? textSecondary,
    Color? divider,
    Color? success,
    Color? onPrimary,
    Color? onHero,
    Color? onHeroMuted,
    Color? onHeroCount,
    Color? heroStart,
    Color? heroEnd,
    Color? ornamentBlue,
    Color? ornamentLine,
    Color? successInk,
    Color? primaryInk,
  }) => AqwamColors(
    background: background ?? this.background,
    surface: surface ?? this.surface,
    surfaceVariant: surfaceVariant ?? this.surfaceVariant,
    primary: primary ?? this.primary,
    primaryContainer: primaryContainer ?? this.primaryContainer,
    accent: accent ?? this.accent,
    text: text ?? this.text,
    textSecondary: textSecondary ?? this.textSecondary,
    divider: divider ?? this.divider,
    success: success ?? this.success,
    onPrimary: onPrimary ?? this.onPrimary,
    onHero: onHero ?? this.onHero,
    onHeroMuted: onHeroMuted ?? this.onHeroMuted,
    onHeroCount: onHeroCount ?? this.onHeroCount,
    heroStart: heroStart ?? this.heroStart,
    heroEnd: heroEnd ?? this.heroEnd,
    ornamentBlue: ornamentBlue ?? this.ornamentBlue,
    ornamentLine: ornamentLine ?? this.ornamentLine,
    successInk: successInk ?? this.successInk,
    primaryInk: primaryInk ?? this.primaryInk,
  );

  @override
  AqwamColors lerp(AqwamColors? other, double t) => this;
}

abstract final class AqwamSpacing {
  static double get space1 => 8.w;
  static double get space2 => 16.w;
  static double get pageInset => 12.w;
  static double get frameInnerLine => 13.45.w;
  static double get textInset => 25.45.w;
}

abstract final class AqwamPadding {
  static EdgeInsets get page => EdgeInsets.all(AqwamSpacing.pageInset);
  static EdgeInsets get standard => EdgeInsets.all(AqwamSpacing.space2);
}

abstract final class AqwamRadius {
  static double get card => 12.r;
  static double get hero => 20.r;
  static double get control => 10.r;
}

abstract final class AqwamSize {
  static double get touchTarget => 48.w;
  static double get bottomNavigation => 64.h;
}
