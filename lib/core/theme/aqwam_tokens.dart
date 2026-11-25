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
  static double get w8 => 8.w;
  static double get w12 => 12.w;
  static double get w13d45 => 13.45.w;
  static double get w14 => 14.w;
  static double get w16 => 16.w;
  static double get w25d45 => 25.45.w;
  static double get h1 => 1.h;
  static double get h8 => 8.h;
  static double get h16 => 16.h;
  static double get onboardingVisualTop => 40.75.h;
  static double get onboardingStarTop => 6.5.h;
  static double get onboardingTitleTop => 69.5.h;
  static double get onboardingTaglineTop => 134.5.h;
  static double get onboardingLocationIconTop => 32.25.h;
  static double get onboardingLocationTitleTop => 104.25.h;
  static double get onboardingLocationDescriptionTop => 156.25.h;
  static double get onboardingDescriptionInset => 23.8.w;
  static double get onboardingNotificationsIconTop => 16.75.h;
  static double get onboardingNotificationsTitleTop => 88.75.h;
  static double get onboardingNotificationsDescriptionTop => 140.75.h;
  static double get onboardingNotificationsHintTop => 173.75.h;
}

abstract final class AqwamRadius {
  static double get r6 => 6.r;
  static double get r10 => 10.r;
  static double get r12 => 12.r;
  static double get r20 => 20.r;
}

abstract final class AqwamSize {
  static double get w6 => 6.w;
  static double get w18 => 18.w;
  static double get w48 => 48.w;
  static double get w64 => 64.w;
  static double get w150 => 150.w;
  static double get w275 => 275.w;
  static double get w328 => 328.w;
  static double get h8 => 8.h;
  static double get h150 => 150.h;
  static double get h32 => 32.h;
  static double get h40 => 40.h;
  static double get h44 => 44.h;
  static double get h48 => 48.h;
  static double get h64 => 64.h;
}

abstract final class AqwamFontSize {
  static double get f10 => 10.sp;
  static double get f11 => 11.sp;
  static double get f11d5 => 11.5.sp;
  static double get f12d5 => 12.5.sp;
  static double get f13 => 13.sp;
  static double get f14 => 14.sp;
  static double get f16 => 16.sp;
  static double get f19 => 19.sp;
  static double get f26 => 26.sp;
}

abstract final class AqwamFontWeight {
  static const FontWeight fw600 = FontWeight.w600;
  static const FontWeight fw700 = FontWeight.w700;
  static const FontWeight fw800 = FontWeight.w800;
}

abstract final class AqwamLineHeight {
  static const double lh1d25 = 1.25;
  static const double lh1d3 = 1.3;
  static const double lh1d4 = 1.4;
  static const double lh1d5 = 1.5;
  static const double lh1d6 = 1.6;
  static const double lh2 = 2;
  static const double lh1d8 = 1.8;
}

abstract final class AqwamFontFamily {
  static const String cairo = 'Cairo';
}

abstract final class AqwamMotion {
  static const Duration sheetDuration = Duration(milliseconds: 320);
  static const Curve sheetCurve = Cubic(0.22, 1, 0.36, 1);
}
