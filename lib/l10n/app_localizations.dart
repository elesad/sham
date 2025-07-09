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
    Locale('en'),
    Locale('ar'),
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

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @chatBot.
  ///
  /// In en, this message translates to:
  /// **'Chat Bot'**
  String get chatBot;

  /// No description provided for @myTrips.
  ///
  /// In en, this message translates to:
  /// **'My Trips'**
  String get myTrips;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0 - Sham Transport'**
  String get version;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @helpGuide.
  ///
  /// In en, this message translates to:
  /// **'User Guide & FAQ'**
  String get helpGuide;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @privacyInfo.
  ///
  /// In en, this message translates to:
  /// **'How we protect your personal data'**
  String get privacyInfo;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @termsInfo.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsInfo;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @darkModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkModeTitle;

  /// No description provided for @darkModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable dark theme'**
  String get darkModeSubtitle;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable app notifications'**
  String get notificationsSubtitle;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get welcomeBack;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello in Sham Transport App'**
  String get hello;

  /// No description provided for @enjoyServices.
  ///
  /// In en, this message translates to:
  /// **'Enjoy our advanced services'**
  String get enjoyServices;

  /// No description provided for @loginToAccess.
  ///
  /// In en, this message translates to:
  /// **'Login to access all services'**
  String get loginToAccess;

  /// No description provided for @aboutAndHelp.
  ///
  /// In en, this message translates to:
  /// **'About & Help'**
  String get aboutAndHelp;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'A comprehensive app for booking public transport trips in Syria, allowing you to book bus, train, and flight trips easily and safely.'**
  String get appDescription;

  /// No description provided for @howToUse.
  ///
  /// In en, this message translates to:
  /// **'How to use the app:'**
  String get howToUse;

  /// No description provided for @step1.
  ///
  /// In en, this message translates to:
  /// **'1. Choose transport type (bus, train, flight)'**
  String get step1;

  /// No description provided for @step2.
  ///
  /// In en, this message translates to:
  /// **'2. Select departure and destination'**
  String get step2;

  /// No description provided for @step3.
  ///
  /// In en, this message translates to:
  /// **'3. Choose the desired date'**
  String get step3;

  /// No description provided for @step4.
  ///
  /// In en, this message translates to:
  /// **'4. Select your seat'**
  String get step4;

  /// No description provided for @step5.
  ///
  /// In en, this message translates to:
  /// **'5. Confirm your booking'**
  String get step5;

  /// No description provided for @step6.
  ///
  /// In en, this message translates to:
  /// **'6. Enjoy your trip!'**
  String get step6;

  /// No description provided for @privacyDescription.
  ///
  /// In en, this message translates to:
  /// **'We are committed to protecting your privacy and personal data.'**
  String get privacyDescription;

  /// No description provided for @termsDescription.
  ///
  /// In en, this message translates to:
  /// **'Please read the terms and conditions carefully before using the app.'**
  String get termsDescription;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get chooseLanguage;

  /// No description provided for @chooseLoginMethod.
  ///
  /// In en, this message translates to:
  /// **'Choose Login Method'**
  String get chooseLoginMethod;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @welcomeToSham.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Sham Transport'**
  String get welcomeToSham;

  /// No description provided for @loginWithApple.
  ///
  /// In en, this message translates to:
  /// **'Login with Apple'**
  String get loginWithApple;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get loginWithGoogle;

  /// No description provided for @loginWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Login with Facebook'**
  String get loginWithFacebook;

  /// No description provided for @loginWithPhone.
  ///
  /// In en, this message translates to:
  /// **'Login with Phone'**
  String get loginWithPhone;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create New Account'**
  String get createNewAccount;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @tripDetails.
  ///
  /// In en, this message translates to:
  /// **'Trip Details'**
  String get tripDetails;

  /// No description provided for @transportType.
  ///
  /// In en, this message translates to:
  /// **'Transport Type'**
  String get transportType;

  /// No description provided for @bus.
  ///
  /// In en, this message translates to:
  /// **'Bus'**
  String get bus;

  /// No description provided for @train.
  ///
  /// In en, this message translates to:
  /// **'Train'**
  String get train;

  /// No description provided for @flight.
  ///
  /// In en, this message translates to:
  /// **'Flight'**
  String get flight;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @showTrainTrips.
  ///
  /// In en, this message translates to:
  /// **'Show Train Trips'**
  String get showTrainTrips;

  /// No description provided for @showFlightTrips.
  ///
  /// In en, this message translates to:
  /// **'Show Flight Trips'**
  String get showFlightTrips;

  /// No description provided for @busCompanies.
  ///
  /// In en, this message translates to:
  /// **'Bus Companies'**
  String get busCompanies;

  /// No description provided for @selectSeat.
  ///
  /// In en, this message translates to:
  /// **'Select Seat'**
  String get selectSeat;

  /// No description provided for @chooseGender.
  ///
  /// In en, this message translates to:
  /// **'Choose Gender'**
  String get chooseGender;

  /// No description provided for @busLayout.
  ///
  /// In en, this message translates to:
  /// **'Bus Layout'**
  String get busLayout;

  /// No description provided for @selectedSeats.
  ///
  /// In en, this message translates to:
  /// **'Selected Seats'**
  String get selectedSeats;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPrice;

  /// No description provided for @confirmSeats.
  ///
  /// In en, this message translates to:
  /// **'Confirm Seats'**
  String get confirmSeats;

  /// No description provided for @accountInfo.
  ///
  /// In en, this message translates to:
  /// **'Account Info'**
  String get accountInfo;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @passport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get passport;

  /// No description provided for @idNumber.
  ///
  /// In en, this message translates to:
  /// **'ID Number'**
  String get idNumber;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @payOnBoard.
  ///
  /// In en, this message translates to:
  /// **'Pay on Board'**
  String get payOnBoard;

  /// No description provided for @visa.
  ///
  /// In en, this message translates to:
  /// **'Visa'**
  String get visa;

  /// No description provided for @confirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get confirmBooking;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// No description provided for @ticket.
  ///
  /// In en, this message translates to:
  /// **'Ticket'**
  String get ticket;

  /// No description provided for @downloadTicket.
  ///
  /// In en, this message translates to:
  /// **'Download Ticket'**
  String get downloadTicket;

  /// No description provided for @sendByEmail.
  ///
  /// In en, this message translates to:
  /// **'Send by Email'**
  String get sendByEmail;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @chooseIdType.
  ///
  /// In en, this message translates to:
  /// **'Choose ID Type'**
  String get chooseIdType;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get id;

  /// No description provided for @myBookings.
  ///
  /// In en, this message translates to:
  /// **'My Bookings'**
  String get myBookings;

  /// No description provided for @viewAllBookings.
  ///
  /// In en, this message translates to:
  /// **'View All Your Bookings'**
  String get viewAllBookings;

  /// No description provided for @createAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create New Account'**
  String get createAccountTitle;

  /// No description provided for @createAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @sendCodeButton.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCodeButton;

  /// No description provided for @enterPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to receive the verification code'**
  String get enterPhone;

  /// No description provided for @enterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter first name'**
  String get enterFirstName;

  /// No description provided for @enterLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter last name'**
  String get enterLastName;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter email'**
  String get enterEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @enterConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter confirm password'**
  String get enterConfirmPassword;

  /// No description provided for @enterIdNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter ID number'**
  String get enterIdNumber;

  /// No description provided for @enterPassport.
  ///
  /// In en, this message translates to:
  /// **'Enter passport number'**
  String get enterPassport;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get enterVerificationCode;

  /// No description provided for @choosePaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Choose payment method'**
  String get choosePaymentMethod;

  /// No description provided for @chooseSeat.
  ///
  /// In en, this message translates to:
  /// **'Choose seat'**
  String get chooseSeat;

  /// No description provided for @chooseDate.
  ///
  /// In en, this message translates to:
  /// **'Choose date'**
  String get chooseDate;

  /// No description provided for @chooseFrom.
  ///
  /// In en, this message translates to:
  /// **'Choose departure point'**
  String get chooseFrom;

  /// No description provided for @chooseTo.
  ///
  /// In en, this message translates to:
  /// **'Choose destination'**
  String get chooseTo;

  /// No description provided for @chooseTransportType.
  ///
  /// In en, this message translates to:
  /// **'Choose transport type'**
  String get chooseTransportType;

  /// No description provided for @chooseGovernorate.
  ///
  /// In en, this message translates to:
  /// **'Choose governorate'**
  String get chooseGovernorate;

  /// No description provided for @chooseAccountType.
  ///
  /// In en, this message translates to:
  /// **'Choose account type'**
  String get chooseAccountType;

  /// No description provided for @chooseBookingType.
  ///
  /// In en, this message translates to:
  /// **'Choose booking type'**
  String get chooseBookingType;

  /// No description provided for @chooseTrip.
  ///
  /// In en, this message translates to:
  /// **'Choose trip'**
  String get chooseTrip;

  /// No description provided for @chooseCompany.
  ///
  /// In en, this message translates to:
  /// **'Choose company'**
  String get chooseCompany;

  /// No description provided for @chooseClass.
  ///
  /// In en, this message translates to:
  /// **'Choose class'**
  String get chooseClass;

  /// No description provided for @chooseTime.
  ///
  /// In en, this message translates to:
  /// **'Choose time'**
  String get chooseTime;

  /// No description provided for @chooseGenderTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose gender'**
  String get chooseGenderTitle;

  /// No description provided for @chooseIdTypeTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose ID type'**
  String get chooseIdTypeTitle;

  /// No description provided for @choosePaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose payment method'**
  String get choosePaymentTitle;

  /// No description provided for @chooseSeatTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose seat'**
  String get chooseSeatTitle;

  /// No description provided for @chooseBookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose booking type'**
  String get chooseBookingTitle;

  /// No description provided for @chooseTripTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose trip'**
  String get chooseTripTitle;

  /// No description provided for @chooseCompanyTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose company'**
  String get chooseCompanyTitle;

  /// No description provided for @chooseClassTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose class'**
  String get chooseClassTitle;

  /// No description provided for @chooseTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose time'**
  String get chooseTimeTitle;

  /// No description provided for @chooseGovernorateTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose governorate'**
  String get chooseGovernorateTitle;

  /// No description provided for @chooseLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get chooseLanguageTitle;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ar', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ar': return AppLocalizationsAr();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
