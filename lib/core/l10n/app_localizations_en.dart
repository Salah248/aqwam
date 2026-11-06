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
}
