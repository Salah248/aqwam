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

  @override
  String onboardingStepProgress(String current, String total) {
    return 'الخطوة $current من $total';
  }

  @override
  String get cityPickerTitle => 'اختيار المدينة';

  @override
  String get cityPickerCountry => 'الدولة';

  @override
  String get cityPickerCity => 'المدينة';

  @override
  String cityPickerRegionSearchHint(String region) {
    return 'ابحث عن $region';
  }

  @override
  String get cityPickerRegionGeneric => 'المنطقة';

  @override
  String get cityPickerCountrySearchHint => 'ابحث عن الدولة';

  @override
  String get cityPickerCitySearchHint => 'ابحث عن المدينة';

  @override
  String get cityPickerConfirmLocation => 'تأكيد الموقع';

  @override
  String cityPickerSelectedLocation(
    Object city,
    Object country,
    Object governorate,
  ) {
    return '$city، $governorate، $country';
  }

  @override
  String cityPickerStepLabel(String current, String total, String label) {
    return 'الخطوة $current من $total · $label';
  }

  @override
  String cityPickerSelectedLocationShort(String city, String country) {
    return '$city، $country';
  }

  @override
  String get cityPickerNoResults => 'لا توجد نتائج';

  @override
  String get cityPickerLoadError => 'تعذّر تحميل المواقع';

  @override
  String get cityPickerRetry => 'إعادة المحاولة';

  @override
  String get cityPickerSaveError => 'تعذّر حفظ الموقع، حاول مرة أخرى';

  @override
  String get cityPickerStorageError =>
      'تعذّر الوصول إلى الموقع المحفوظ، حاول مرة أخرى';

  @override
  String get cityPickerEmpty => 'لا توجد مواقع متاحة';

  @override
  String get onboardingPermissionError =>
      'تعذّر طلب الإذن، يمكنك المحاولة مرة أخرى';
}
