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
}
