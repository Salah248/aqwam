// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get home => 'الرئيسية';

  @override
  String get quran => 'المصحف';

  @override
  String get adhkar => 'الأذكار';

  @override
  String get prayerTimes => 'المواقيت';

  @override
  String get settings => 'الإعدادات';

  @override
  String get appTitle => 'أقوَم';

  @override
  String get placeholder => 'هذه الشاشة قيد الإنشاء';

  @override
  String get lightTheme => 'ذهبي هادئ';

  @override
  String get darkTheme => 'ضوء القمر';

  @override
  String get language => 'اللغة';

  @override
  String get digits => 'الأرقام';

  @override
  String get arabicDigits => '١٢٣';

  @override
  String get westernDigits => '123';

  @override
  String get theme => 'المظهر';

  @override
  String get toggleTheme => 'تبديل المظهر';
}
