import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_hi.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('gu'),
    Locale('hi')
  ];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Luna Menu'**
  String get title;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Luna!'**
  String get welcome;

  /// No description provided for @chatPage.
  ///
  /// In en, this message translates to:
  /// **'Chat page'**
  String get chatPage;

  /// No description provided for @mapPage.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get mapPage;

  /// No description provided for @helpPage.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get helpPage;

  /// No description provided for @locationFetching.
  ///
  /// In en, this message translates to:
  /// **'Fetching location…'**
  String get locationFetching;

  /// No description provided for @locationDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied'**
  String get locationDenied;

  /// No description provided for @locationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Location unavailable'**
  String get locationUnavailable;

  /// No description provided for @educationalLessons.
  ///
  /// In en, this message translates to:
  /// **'Educational Lessons'**
  String get educationalLessons;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get faq;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @faqTitle.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faqTitle;

  /// No description provided for @faqSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get quick answers to your questions.\nTo understand more, contact us.'**
  String get faqSubtitle;

  /// No description provided for @faqQ1.
  ///
  /// In en, this message translates to:
  /// **'What is Luna?'**
  String get faqQ1;

  /// No description provided for @faqA1.
  ///
  /// In en, this message translates to:
  /// **'Luna is an Ayurvedic first-aid guide offering natural remedies for common issues.'**
  String get faqA1;

  /// No description provided for @faqQ2.
  ///
  /// In en, this message translates to:
  /// **'Is this medically certified?'**
  String get faqQ2;

  /// No description provided for @faqA2.
  ///
  /// In en, this message translates to:
  /// **'Our content is based on traditional Ayurvedic sources. We recommend consulting a professional for serious cases.'**
  String get faqA2;

  /// No description provided for @faqQ3.
  ///
  /// In en, this message translates to:
  /// **'How do I contact support?'**
  String get faqQ3;

  /// No description provided for @faqA3.
  ///
  /// In en, this message translates to:
  /// **'Tap on the \"Contact us\" button below or reach out via the settings section.'**
  String get faqA3;

  /// No description provided for @faqQ4.
  ///
  /// In en, this message translates to:
  /// **'Can I use it offline?'**
  String get faqQ4;

  /// No description provided for @faqA4.
  ///
  /// In en, this message translates to:
  /// **'Yes! The basic remedies are available even without internet.'**
  String get faqA4;

  /// No description provided for @readAllFAQ.
  ///
  /// In en, this message translates to:
  /// **'Read all FAQ'**
  String get readAllFAQ;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUs;

  /// No description provided for @educationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'For yourself and your loved ones'**
  String get educationSubtitle;

  /// No description provided for @lessons.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get lessons;

  /// No description provided for @lessonFirstAid.
  ///
  /// In en, this message translates to:
  /// **'First Aid'**
  String get lessonFirstAid;

  /// No description provided for @lessonCPR.
  ///
  /// In en, this message translates to:
  /// **'CPR'**
  String get lessonCPR;

  /// No description provided for @lessonBurn.
  ///
  /// In en, this message translates to:
  /// **'Burn Treatment'**
  String get lessonBurn;

  /// No description provided for @lessonSnake.
  ///
  /// In en, this message translates to:
  /// **'Snake Bite'**
  String get lessonSnake;

  /// No description provided for @lessonFracture.
  ///
  /// In en, this message translates to:
  /// **'Fracture Care'**
  String get lessonFracture;

  /// No description provided for @lessonAllergy.
  ///
  /// In en, this message translates to:
  /// **'Allergic Reaction'**
  String get lessonAllergy;

  /// No description provided for @lessonHeat.
  ///
  /// In en, this message translates to:
  /// **'Heat Stroke'**
  String get lessonHeat;

  /// No description provided for @lessonPoison.
  ///
  /// In en, this message translates to:
  /// **'Poisoning'**
  String get lessonPoison;

  /// No description provided for @lessonDrowning.
  ///
  /// In en, this message translates to:
  /// **'Drowning Rescue'**
  String get lessonDrowning;

  /// No description provided for @hosNearME.
  ///
  /// In en, this message translates to:
  /// **'Hospital Near Me'**
  String get hosNearME;

  /// No description provided for @hosNearBY.
  ///
  /// In en, this message translates to:
  /// **'Nearby Hospital'**
  String get hosNearBY;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'gu', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'gu': return AppLocalizationsGu();
    case 'hi': return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
