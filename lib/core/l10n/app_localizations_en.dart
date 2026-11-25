// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get quran => 'Quran';

  @override
  String get adhkar => 'Adhkar';

  @override
  String get prayerTimes => 'Prayer times';

  @override
  String get settings => 'Settings';

  @override
  String get appTitle => 'Aqwam';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingStart => 'Start';

  @override
  String get onboardingLocationTitle => 'Your location';

  @override
  String get onboardingLocationDescription =>
      'Your location is used to calculate accurate prayer times and is not shared.';

  @override
  String get onboardingAllowLocation => 'Allow location';

  @override
  String get onboardingChooseCityManually => 'Choose city manually';

  @override
  String get onboardingNotificationsTitle => 'Notifications';

  @override
  String get onboardingNotificationsDescription =>
      'Get reminders before and at prayer time.';

  @override
  String get onboardingAllowNotifications => 'Allow notifications';

  @override
  String get onboardingLater => 'Later';

  @override
  String get onboardingExactAlarmHint =>
      'Exact alarms permission is needed for precise timing.';

  @override
  String get onboardingWelcomeTagline => 'Aqwam: Your daily companion';

  @override
  String onboardingStepProgress(String current, String total) {
    return 'Step $current of $total';
  }

  @override
  String get cityPickerTitle => 'Choose city';

  @override
  String get cityPickerCountry => 'Country';

  @override
  String get cityPickerCity => 'City';

  @override
  String cityPickerRegionSearchHint(String region) {
    return 'Search for $region';
  }

  @override
  String get cityPickerRegionGeneric => 'Region';

  @override
  String get cityPickerCountrySearchHint => 'Search for a country';

  @override
  String get cityPickerCitySearchHint => 'Search for a city';

  @override
  String get cityPickerConfirmLocation => 'Confirm location';

  @override
  String cityPickerSelectedLocation(
    Object city,
    Object country,
    Object governorate,
  ) {
    return '$city, $governorate, $country';
  }

  @override
  String cityPickerStepLabel(String current, String total, String label) {
    return 'Step $current of $total · $label';
  }

  @override
  String cityPickerSelectedLocationShort(String city, String country) {
    return '$city, $country';
  }

  @override
  String get cityPickerNoResults => 'No results';

  @override
  String get cityPickerLoadError => 'Couldn\'t load locations';

  @override
  String get cityPickerRetry => 'Try again';

  @override
  String get cityPickerSaveError => 'Couldn\'t save the location. Try again.';

  @override
  String get cityPickerStorageError =>
      'Couldn\'t access the saved location. Try again.';

  @override
  String get cityPickerEmpty => 'No locations are available.';

  @override
  String get onboardingPermissionError =>
      'Permission request failed. You can try again.';
}
