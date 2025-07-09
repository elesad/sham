// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تطبيق المواصلات';

  @override
  String get welcome => 'مرحباً';

  @override
  String get busStops => 'مواقف الباصات';

  @override
  String get fromGovernorate => 'اختر محافظة الانطلاق';

  @override
  String get toGovernorate => 'اختر محافظة الوصول';

  @override
  String get showBusLine => 'عرض خط الباص';

  @override
  String get busLineTitle => 'خط الباص';

  @override
  String busLineContent(Object from, Object to) {
    return 'من $from إلى $to';
  }

  @override
  String get ok => 'حسناً';

  @override
  String get governorateDamascus => 'دمشق';

  @override
  String get governorateRifDimashq => 'ريف دمشق';

  @override
  String get governorateAleppo => 'حلب';

  @override
  String get governorateHoms => 'حمص';

  @override
  String get governorateHama => 'حماة';

  @override
  String get governorateLatakia => 'اللاذقية';

  @override
  String get governorateTartus => 'طرطوس';

  @override
  String get governorateIdlib => 'إدلب';

  @override
  String get governorateDeirEzzor => 'دير الزور';

  @override
  String get governorateHasakah => 'الحسكة';

  @override
  String get governorateRaqqa => 'الرقة';

  @override
  String get governorateDaraa => 'درعا';

  @override
  String get governorateSuwayda => 'السويداء';

  @override
  String get governorateQuneitra => 'القنيطرة';

  @override
  String get homeTitle => 'الرئيسية';

  @override
  String get chatBot => 'شات بوت';

  @override
  String get myTrips => 'رحلاتي';

  @override
  String get myProfile => 'ملفي الشخصي';

  @override
  String get cancel => 'إلغاء';

  @override
  String get sendCode => 'إرسال الرمز';

  @override
  String get createAccount => 'إنشاء الحساب';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get aboutApp => 'حول التطبيق';

  @override
  String get version => 'إصدار 1.0.0 - مواصلات الشام';

  @override
  String get help => 'المساعدة';

  @override
  String get helpGuide => 'دليل الاستخدام والأسئلة الشائعة';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get privacyInfo => 'كيف نحمي بياناتك الشخصية';

  @override
  String get termsOfService => 'شروط الاستخدام';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get termsInfo => 'الشروط والأحكام';

  @override
  String get close => 'إغلاق';

  @override
  String get darkModeTitle => 'الوضع الداكن';

  @override
  String get darkModeSubtitle => 'تفعيل المظهر الداكن';

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get notificationsSubtitle => 'تفعيل إشعارات التطبيق';

  @override
  String get welcomeBack => 'أهلاً بعودتك!';

  @override
  String get hello => 'مرحباً بك في تطبيق مواصلات الشام';

  @override
  String get enjoyServices => 'استمتع بخدماتنا المتقدمة';

  @override
  String get loginToAccess => 'سجل دخولك للوصول إلى جميع الخدمات';

  @override
  String get aboutAndHelp => 'حول التطبيق والمساعدة';

  @override
  String get appDescription => 'تطبيق شامل لحجز رحلات النقل العام في سوريا، يتيح لك حجز رحلات الباص والقطار والطيران بسهولة وأمان.';

  @override
  String get howToUse => 'كيفية استخدام التطبيق:';

  @override
  String get step1 => '1. اختر نوع النقل (باص، قطار، طيران)';

  @override
  String get step2 => '2. حدد نقطة الانطلاق والوجهة';

  @override
  String get step3 => '3. اختر التاريخ المطلوب';

  @override
  String get step4 => '4. اختر مقعدك';

  @override
  String get step5 => '5. أكد الحجز';

  @override
  String get step6 => '6. استمتع برحلتك!';

  @override
  String get privacyDescription => 'نلتزم بحماية خصوصيتك وبياناتك الشخصية.';

  @override
  String get termsDescription => 'يرجى قراءة الشروط والأحكام بعناية قبل استخدام التطبيق.';

  @override
  String get appSettings => 'إعدادات التطبيق';

  @override
  String get chooseLanguage => 'اختر اللغة';

  @override
  String get chooseLoginMethod => 'اختر طريقة تسجيل الدخول';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get welcomeToSham => 'مرحباً بك في مواصلات الشام';

  @override
  String get loginWithApple => 'تسجيل الدخول عبر Apple';

  @override
  String get loginWithGoogle => 'تسجيل الدخول عبر Google';

  @override
  String get loginWithFacebook => 'تسجيل الدخول عبر Facebook';

  @override
  String get loginWithPhone => 'تسجيل الدخول عبر الهاتف';

  @override
  String get createNewAccount => 'إنشاء حساب جديد';

  @override
  String get or => 'أو';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get create => 'إنشاء';

  @override
  String get tripDetails => 'تفاصيل الرحلة';

  @override
  String get transportType => 'نوع النقل';

  @override
  String get bus => 'باص';

  @override
  String get train => 'قطار';

  @override
  String get flight => 'طيران';

  @override
  String get from => 'من أين';

  @override
  String get to => 'إلى أين';

  @override
  String get selectDate => 'اختر التاريخ';

  @override
  String get showTrainTrips => 'عرض رحلات القطار';

  @override
  String get showFlightTrips => 'عرض رحلات الطيران';

  @override
  String get busCompanies => 'شركات الباص';

  @override
  String get selectSeat => 'اختيار المقعد';

  @override
  String get chooseGender => 'اختر الجنس';

  @override
  String get busLayout => 'هيكل الباص';

  @override
  String get selectedSeats => 'المقاعد المختارة';

  @override
  String get totalPrice => 'السعر الإجمالي';

  @override
  String get confirmSeats => 'تأكيد المقاعد';

  @override
  String get accountInfo => 'معلومات الحساب';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اللقب';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get passport => 'جواز السفر';

  @override
  String get idNumber => 'رقم الهوية';

  @override
  String get paymentMethod => 'طريقة الدفع';

  @override
  String get payOnBoard => 'عند الصعود';

  @override
  String get visa => 'فيزا';

  @override
  String get confirmBooking => 'تأكيد الحجز';

  @override
  String get verificationCode => 'رمز التحقق';

  @override
  String get ticket => 'التذكرة';

  @override
  String get downloadTicket => 'تنزيل التذكرة';

  @override
  String get sendByEmail => 'إرسال بالإيميل';

  @override
  String get backToHome => 'العودة للصفحة الرئيسية';

  @override
  String get male => 'ذكر';

  @override
  String get female => 'أنثى';

  @override
  String get chooseIdType => 'اختر نوع الهوية';

  @override
  String get id => 'هوية';

  @override
  String get myBookings => 'حجزاتي';

  @override
  String get viewAllBookings => 'عرض جميع رحلاتك المحجوزة';

  @override
  String get createAccountTitle => 'إنشاء حساب جديد';

  @override
  String get createAccountButton => 'إنشاء الحساب';

  @override
  String get cancelButton => 'إلغاء';

  @override
  String get sendCodeButton => 'إرسال الرمز';

  @override
  String get enterPhone => 'أدخل رقم هاتفك لاستلام رمز التحقق';

  @override
  String get enterFirstName => 'أدخل الاسم الأول';

  @override
  String get enterLastName => 'أدخل اللقب';

  @override
  String get enterEmail => 'أدخل البريد الإلكتروني';

  @override
  String get enterPassword => 'أدخل كلمة المرور';

  @override
  String get enterConfirmPassword => 'أدخل تأكيد كلمة المرور';

  @override
  String get enterIdNumber => 'أدخل رقم الهوية';

  @override
  String get enterPassport => 'أدخل رقم جواز السفر';

  @override
  String get enterVerificationCode => 'أدخل رمز التحقق';

  @override
  String get choosePaymentMethod => 'اختر طريقة الدفع';

  @override
  String get chooseSeat => 'اختر المقعد';

  @override
  String get chooseDate => 'اختر التاريخ';

  @override
  String get chooseFrom => 'اختر نقطة الانطلاق';

  @override
  String get chooseTo => 'اختر نقطة الوصول';

  @override
  String get chooseTransportType => 'اختر نوع النقل';

  @override
  String get chooseGovernorate => 'اختر المحافظة';

  @override
  String get chooseAccountType => 'اختر نوع الحساب';

  @override
  String get chooseBookingType => 'اختر نوع الحجز';

  @override
  String get chooseTrip => 'اختر الرحلة';

  @override
  String get chooseCompany => 'اختر الشركة';

  @override
  String get chooseClass => 'اختر الدرجة';

  @override
  String get chooseTime => 'اختر الوقت';

  @override
  String get chooseGenderTitle => 'اختر الجنس';

  @override
  String get chooseIdTypeTitle => 'اختر نوع الهوية';

  @override
  String get choosePaymentTitle => 'اختر طريقة الدفع';

  @override
  String get chooseSeatTitle => 'اختر المقعد';

  @override
  String get chooseBookingTitle => 'اختر نوع الحجز';

  @override
  String get chooseTripTitle => 'اختر الرحلة';

  @override
  String get chooseCompanyTitle => 'اختر الشركة';

  @override
  String get chooseClassTitle => 'اختر الدرجة';

  @override
  String get chooseTimeTitle => 'اختر الوقت';

  @override
  String get chooseGovernorateTitle => 'اختر المحافظة';

  @override
  String get chooseLanguageTitle => 'اختر اللغة';
}
