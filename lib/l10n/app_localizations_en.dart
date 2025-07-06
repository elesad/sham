// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sham Transport';

  @override
  String get welcome => 'Home';

  @override
  String get busStops => 'Bus Stops';

  @override
  String get fromGovernorate => 'Select departure governorate';

  @override
  String get toGovernorate => 'Select arrival governorate';

  @override
  String get showBusLine => 'Show Bus Line';

  @override
  String get busLineTitle => 'Bus Line';

  @override
  String busLineContent(Object from, Object to) {
    return 'From $from to $to';
  }

  @override
  String get ok => 'OK';

  @override
  String get governorateDamascus => 'Damascus';

  @override
  String get governorateRifDimashq => 'Rif Dimashq';

  @override
  String get governorateAleppo => 'Aleppo';

  @override
  String get governorateHoms => 'Homs';

  @override
  String get governorateHama => 'Hama';

  @override
  String get governorateLatakia => 'Latakia';

  @override
  String get governorateTartus => 'Tartus';

  @override
  String get governorateIdlib => 'Idlib';

  @override
  String get governorateDeirEzzor => 'Deir Ezzor';

  @override
  String get governorateHasakah => 'Hasakah';

  @override
  String get governorateRaqqa => 'Raqqa';

  @override
  String get governorateDaraa => 'Daraa';

  @override
  String get governorateSuwayda => 'Suwayda';

  @override
  String get governorateQuneitra => 'Quneitra';

  // إضافة نصوص جديدة
  String get chatBot => 'Chat Bot';
  String get myTrips => 'My Trips';
  String get myProfile => 'My Profile';
  String get welcomeBack => 'Welcome Back';
  String get hello => 'Hello';
  String get enjoyServices => 'Enjoy our advanced services';
  String get loginToAccess => 'Login to access all services';
  String get login => 'Login';
  String get appSettings => 'App Settings';
  String get language => 'Language';
  String get chooseLanguage => 'Choose Language';
  String get darkMode => 'Dark Mode';
  String get notifications => 'Notifications';
  String get aboutAndHelp => 'About & Help';
  String get aboutApp => 'About App';
  String get help => 'Help';
  String get privacyPolicy => 'Privacy Policy';
  String get version => 'Version 1.0.0 - Sham Transport';
  String get helpGuide => 'User guide and FAQ';
  String get privacyInfo => 'How we protect your personal data';
  
  // نصوص تسجيل الدخول
  String get welcomeToSham => 'Welcome to Sham Transport';
  String get chooseLoginMethod => 'Choose your preferred login method';
  String get loginWithApple => 'Login with Apple';
  String get loginWithGoogle => 'Login with Google';
  String get loginWithFacebook => 'Login with Facebook';
  String get loginWithPhone => 'Login with Phone Number';
  String get or => 'or';
  String get createNewAccount => 'Create New Account';
  String get cancel => 'Cancel';
  
  // نصوص إضافية
  String get termsOfService => 'Terms of Service';
  String get termsAndConditions => 'Terms and Conditions';
  String get close => 'Close';
  String get appDescription => 'A comprehensive app for booking public transportation trips in Syria, allowing you to book bus, train, and flight trips easily and safely.';
  String get howToUse => 'How to use the app:';
  String get step1 => '1. Choose transportation type (bus, train, flight)';
  String get step2 => '2. Select departure and destination points';
  String get step3 => '3. Choose the required date';
  String get step4 => '4. Select company and seat';
  String get step5 => '5. Complete booking data and payment';
  String get step6 => '6. Get your ticket';
  String get privacyDescription => 'We protect your personal data and do not share it with any third party. All transactions are encrypted and secure.';
  String get termsDescription => 'By using this app, you agree to the terms of service and privacy policy.';
  String get darkModeTitle => 'Dark Mode';
  String get darkModeSubtitle => 'Enable dark appearance';
  String get notificationsTitle => 'Notifications';
  String get notificationsSubtitle => 'Enable app notifications';
  String get enterPhoneForCode => 'Enter your phone number to receive verification code';
  String get phoneNumber => 'Phone Number';
  String get sendCode => 'Send Code';
  String get fullName => 'Full Name';
  String get email => 'Email';
  String get password => 'Password';
  String get confirmPassword => 'Confirm Password';
  String get createAccount => 'Create Account';
  String get accountInfo => 'Account Information';
  String get name => 'Name';
  String get logout => 'Logout';
  String get myTripsTitle => 'My Trips';
  String get noTripsMessage => 'All your booked trips will appear here';
  String get transportType => 'Transport Type';
  String get bus => 'Bus';
  String get train => 'Train';
  String get flight => 'Flight';
  String get tripDetails => 'Trip Details';
}
