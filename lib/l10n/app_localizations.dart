import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

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
    Locale('ar'),
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Transport App'**
  String get appTitle;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @busStops.
  ///
  /// In en, this message translates to:
  /// **'Bus Stops'**
  String get busStops;

  /// No description provided for @fromGovernorate.
  ///
  /// In en, this message translates to:
  /// **'Select departure governorate'**
  String get fromGovernorate;

  /// No description provided for @toGovernorate.
  ///
  /// In en, this message translates to:
  /// **'Select arrival governorate'**
  String get toGovernorate;

  /// No description provided for @showBusLine.
  ///
  /// In en, this message translates to:
  /// **'Show Bus Line'**
  String get showBusLine;

  /// No description provided for @busLineTitle.
  ///
  /// In en, this message translates to:
  /// **'Bus Line'**
  String get busLineTitle;

  /// No description provided for @busLineContent.
  ///
  /// In en, this message translates to:
  /// **'From {from} to {to}'**
  String busLineContent(Object from, Object to);

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @governorateDamascus.
  ///
  /// In en, this message translates to:
  /// **'Damascus'**
  String get governorateDamascus;

  /// No description provided for @governorateRifDimashq.
  ///
  /// In en, this message translates to:
  /// **'Rif Dimashq'**
  String get governorateRifDimashq;

  /// No description provided for @governorateAleppo.
  ///
  /// In en, this message translates to:
  /// **'Aleppo'**
  String get governorateAleppo;

  /// No description provided for @governorateHoms.
  ///
  /// In en, this message translates to:
  /// **'Homs'**
  String get governorateHoms;

  /// No description provided for @governorateHama.
  ///
  /// In en, this message translates to:
  /// **'Hama'**
  String get governorateHama;

  /// No description provided for @governorateLatakia.
  ///
  /// In en, this message translates to:
  /// **'Latakia'**
  String get governorateLatakia;

  /// No description provided for @governorateTartus.
  ///
  /// In en, this message translates to:
  /// **'Tartus'**
  String get governorateTartus;

  /// No description provided for @governorateIdlib.
  ///
  /// In en, this message translates to:
  /// **'Idlib'**
  String get governorateIdlib;

  /// No description provided for @governorateDeirEzzor.
  ///
  /// In en, this message translates to:
  /// **'Deir ez-Zor'**
  String get governorateDeirEzzor;

  /// No description provided for @governorateHasakah.
  ///
  /// In en, this message translates to:
  /// **'Hasakah'**
  String get governorateHasakah;

  /// No description provided for @governorateRaqqa.
  ///
  /// In en, this message translates to:
  /// **'Raqqa'**
  String get governorateRaqqa;

  /// No description provided for @governorateDaraa.
  ///
  /// In en, this message translates to:
  /// **'Daraa'**
  String get governorateDaraa;

  /// No description provided for @governorateSuwayda.
  ///
  /// In en, this message translates to:
  /// **'As-Suwayda'**
  String get governorateSuwayda;

  /// No description provided for @governorateQuneitra.
  ///
  /// In en, this message translates to:
  /// **'Quneitra'**
  String get governorateQuneitra;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
