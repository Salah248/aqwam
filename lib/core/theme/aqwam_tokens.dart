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

abstract final class AqwamTokens {
  /// الخط الأساسي لواجهة المستخدم.
  static const String vCairo = 'Cairo';

  /// مسافة الشبكة الصغيرة.
  static double get p8 => 8.w;

  /// مسافة الشبكة القياسية.
  static double get p16 => 16.w;

  /// الهامش الداخلي للصفحة.
  static double get p12 => 12.w;

  /// موضع الخط الداخلي للإطار.
  static double get p13d45 => 13.45.w;

  /// الهامش الداخلي للنص.
  static double get p25d45 => 25.45.w;

  /// المسافة الأفقية للزر.
  static double get p14 => 14.w;

  /// نصف قطر البطاقة.
  static double get r12 => 12.r;

  /// نصف قطر البطاقة الرئيسية.
  static double get r20 => 20.r;

  /// نصف قطر عناصر التحكم.
  static double get r10 => 10.r;

  /// ارتفاع شريط الحالة.
  static double get s32 => 32.h;

  /// ارتفاع الزر في التصميم.
  static double get s44 => 44.h;

  /// حجم الأيقونة الكبيرة.
  static double get s64 => 64.w;

  /// حجم الرسم التوضيحي.
  static double get s150 => 150.w;

  /// حجم الزخرفة.
  static double get s48 => 48.w;

  /// حجم مؤشر التقدم النشط.
  static double get s18 => 18.w;

  /// حجم نقطة مؤشر التقدم.
  static double get s6 => 6.w;

  /// ارتفاع شريط التنقل السفلي.
  static double get s64h => 64.h;

  /// حجم نص العنوان الرئيسي.
  static const double f26 = 26;

  /// حجم نص العنوان.
  static const double f19 = 19;

  /// حجم عنوان القسم.
  static const double f16 = 16;

  /// حجم نص المحتوى.
  static const double f12d5 = 12.5;

  /// حجم نص التسمية.
  static const double f11d5 = 11.5;

  /// حجم نص الإجراء.
  static const double f13 = 13;

  /// حجم نص التلميح.
  static const double f11 = 11;

  /// وزن النص الثقيل جدًا.
  static const FontWeight fw800 = FontWeight.w800;

  /// وزن النص الثقيل.
  static const FontWeight fw700 = FontWeight.w700;

  /// وزن النص المتوسط.
  static const FontWeight fw600 = FontWeight.w600;

  /// ارتفاع سطر العنوان.
  static const double lh1d25 = 1.25;

  /// ارتفاع سطر عنوان القسم.
  static const double lh1d3 = 1.3;

  /// ارتفاع سطر المحتوى.
  static const double lh1d5 = 1.5;

  /// ارتفاع سطر التسمية.
  static const double lh1d4 = 1.4;

  /// ارتفاع سطر التلميح.
  static const double lh1d8 = 1.8;

  /// قيمة عرض ثابتة تستخدم لحجم الزر.
  static double get s328 => 328.w;
}

@Deprecated('Use AqwamTokens instead.')
abstract final class AqwamSpacing {
  static double get space2 => AqwamTokens.p16;
}

@Deprecated('Use AqwamTokens instead.')
abstract final class AqwamRadius {
  static double get control => AqwamTokens.r10;
}

@Deprecated('Use AqwamTokens instead.')
abstract final class AqwamSize {
  static double get buttonHeight => AqwamTokens.s44;
}
