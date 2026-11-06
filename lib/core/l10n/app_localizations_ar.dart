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
  String get onboardingSkip => 'تخطٍّ';

  @override
  String get onboardingStart => 'ابدأ';

  @override
  String get onboardingLocationTitle => 'موقعك';

  @override
  String get onboardingLocationDescription =>
      'نحتاج موقعك لحساب مواقيت الصلاة بدقة، ولا نشاركه مع أحد.';

  @override
  String get onboardingAllowLocation => 'السماح بالموقع';

  @override
  String get onboardingChooseCityManually => 'اختيار المدينة يدويًا';

  @override
  String get onboardingNotificationsTitle => 'التنبيهات';

  @override
  String get onboardingNotificationsDescription =>
      'لننبّهك قبل الصلاة وفي وقتها';

  @override
  String get onboardingAllowNotifications => 'السماح بالإشعارات';

  @override
  String get onboardingLater => 'لاحقًا';

  @override
  String get onboardingExactAlarmHint =>
      '⏱ نحتاج إذن المنبّهات الدقيقة لإشعار في الوقت بالضبط';

  @override
  String get onboardingWelcomeTagline => '«أقوَم: رفيق وردك»';
}
