// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'مواصلات الشام';

  @override
  String get welcome => 'الرئيسية';

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

  // إضافة نصوص جديدة
  String get chatBot => 'شات بوت';
  String get myTrips => 'رحلاتي';
  String get myProfile => 'ملفي الشخصي';
  String get welcomeBack => 'أهلاً وسهلاً';
  String get hello => 'مرحباً بك';
  String get enjoyServices => 'استمتع بخدماتنا المتقدمة';
  String get loginToAccess => 'سجل دخولك للوصول إلى جميع الخدمات';
  String get login => 'تسجيل الدخول';
  String get appSettings => 'إعدادات التطبيق';
  String get language => 'اللغة';
  String get chooseLanguage => 'اختر اللغة';
  String get darkMode => 'الوضع المظلم';
  String get notifications => 'الإشعارات';
  String get aboutAndHelp => 'حول التطبيق والمساعدة';
  String get aboutApp => 'حول التطبيق';
  String get help => 'المساعدة';
  String get privacyPolicy => 'سياسة الخصوصية';
  String get version => 'إصدار 1.0.0 - مواصلات الشام';
  String get helpGuide => 'دليل الاستخدام والأسئلة الشائعة';
  String get privacyInfo => 'كيف نحمي بياناتك الشخصية';
  
  // نصوص تسجيل الدخول
  String get welcomeToSham => 'مرحباً بك في مواصلات الشام';
  String get chooseLoginMethod => 'اختر طريقة تسجيل الدخول المفضلة لديك';
  String get loginWithApple => 'تسجيل الدخول بـ Apple';
  String get loginWithGoogle => 'تسجيل الدخول بـ Google';
  String get loginWithFacebook => 'تسجيل الدخول بـ Facebook';
  String get loginWithPhone => 'تسجيل الدخول برقم الهاتف';
  String get or => 'أو';
  String get createNewAccount => 'إنشاء حساب جديد';
  String get cancel => 'إلغاء';
  
  // نصوص إضافية
  String get termsOfService => 'شروط الاستخدام';
  String get termsAndConditions => 'الشروط والأحكام';
  String get close => 'إغلاق';
  String get appDescription => 'تطبيق شامل لحجز رحلات النقل العام في سوريا، يتيح لك حجز رحلات الباص والقطار والطيران بسهولة وأمان.';
  String get howToUse => 'كيفية استخدام التطبيق:';
  String get step1 => '1. اختر نوع النقل (باص، قطار، طيران)';
  String get step2 => '2. حدد نقطة الانطلاق والوجهة';
  String get step3 => '3. اختر التاريخ المطلوب';
  String get step4 => '4. اختر الشركة والمقعد';
  String get step5 => '5. أكمل بيانات الحجز والدفع';
  String get step6 => '6. احصل على التذكرة';
  String get privacyDescription => 'نحن نحمي بياناتك الشخصية ولا نشاركها مع أي طرف ثالث. جميع المعاملات مشفرة وآمنة.';
  String get termsDescription => 'باستخدام هذا التطبيق، فإنك توافق على شروط الاستخدام وسياسة الخصوصية.';
  String get darkModeTitle => 'الوضع الداكن';
  String get darkModeSubtitle => 'تفعيل المظهر الداكن';
  String get notificationsTitle => 'الإشعارات';
  String get notificationsSubtitle => 'تفعيل إشعارات التطبيق';
  String get enterPhoneForCode => 'أدخل رقم هاتفك لاستلام رمز التحقق';
  String get phoneNumber => 'رقم الهاتف';
  String get sendCode => 'إرسال الرمز';
  String get fullName => 'الاسم الكامل';
  String get email => 'البريد الإلكتروني';
  String get password => 'كلمة المرور';
  String get confirmPassword => 'تأكيد كلمة المرور';
  String get createAccount => 'إنشاء الحساب';
  String get accountInfo => 'معلومات الحساب';
  String get name => 'الاسم';
  String get logout => 'تسجيل الخروج';
  String get myTripsTitle => 'رحلاتي';
  String get noTripsMessage => 'ستظهر هنا جميع رحلاتك المحجوزة';
  String get transportType => 'نوع النقل';
  String get bus => 'باص';
  String get train => 'قطار';
  String get flight => 'طيران';
  String get tripDetails => 'تفاصيل الرحلة';
}
