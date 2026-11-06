import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @home.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get home;

  /// No description provided for @quran.
  ///
  /// In ar, this message translates to:
  /// **'المصحف'**
  String get quran;

  /// No description provided for @adhkar.
  ///
  /// In ar, this message translates to:
  /// **'الأذكار'**
  String get adhkar;

  /// No description provided for @prayerTimes.
  ///
  /// In ar, this message translates to:
  /// **'المواقيت'**
  String get prayerTimes;

  /// No description provided for @settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings;

  /// No description provided for @appTitle.
  ///
  /// In ar, this message translates to:
  /// **'أقوَم'**
  String get appTitle;

  /// No description provided for @onboardingSkip.
  ///
  /// In ar, this message translates to:
  /// **'تخطٍّ'**
  String get onboardingSkip;

  /// No description provided for @onboardingStart.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ'**
  String get onboardingStart;

  /// No description provided for @onboardingLocationTitle.
  ///
  /// In ar, this message translates to:
  /// **'موقعك'**
  String get onboardingLocationTitle;

  /// No description provided for @onboardingLocationDescription.
  ///
  /// In ar, this message translates to:
  /// **'نحتاج موقعك لحساب مواقيت الصلاة بدقة، ولا نشاركه مع أحد.'**
  String get onboardingLocationDescription;

  /// No description provided for @onboardingAllowLocation.
  ///
  /// In ar, this message translates to:
  /// **'السماح بالموقع'**
  String get onboardingAllowLocation;

  /// No description provided for @onboardingChooseCityManually.
  ///
  /// In ar, this message translates to:
  /// **'اختيار المدينة يدويًا'**
  String get onboardingChooseCityManually;

  /// No description provided for @onboardingNotificationsTitle.
  ///
  /// In ar, this message translates to:
  /// **'التنبيهات'**
  String get onboardingNotificationsTitle;

  /// No description provided for @onboardingNotificationsDescription.
  ///
  /// In ar, this message translates to:
  /// **'لننبّهك قبل الصلاة وفي وقتها'**
  String get onboardingNotificationsDescription;

  /// No description provided for @onboardingAllowNotifications.
  ///
  /// In ar, this message translates to:
  /// **'السماح بالإشعارات'**
  String get onboardingAllowNotifications;

  /// No description provided for @onboardingLater.
  ///
  /// In ar, this message translates to:
  /// **'لاحقًا'**
  String get onboardingLater;

  /// No description provided for @onboardingExactAlarmHint.
  ///
  /// In ar, this message translates to:
  /// **'⏱ نحتاج إذن المنبّهات الدقيقة لإشعار في الوقت بالضبط'**
  String get onboardingExactAlarmHint;

  /// No description provided for @onboardingWelcomeTagline.
  ///
  /// In ar, this message translates to:
  /// **'«أقوَم: رفيق وردك»'**
  String get onboardingWelcomeTagline;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
