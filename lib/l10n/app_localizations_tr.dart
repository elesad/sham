// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Ulaşım Uygulaması';

  @override
  String get welcome => 'Hoş geldiniz';

  @override
  String get busStops => 'Otobüs Durakları';

  @override
  String get fromGovernorate => 'Kalkış ilini seçin';

  @override
  String get toGovernorate => 'Varış ilini seçin';

  @override
  String get showBusLine => 'Otobüs Hattını Göster';

  @override
  String get busLineTitle => 'Otobüs Hattı';

  @override
  String busLineContent(Object from, Object to) {
    return '$from ilinden $to iline';
  }

  @override
  String get ok => 'Tamam';

  @override
  String get governorateDamascus => 'Şam';

  @override
  String get governorateRifDimashq => 'Şam Kırsalı';

  @override
  String get governorateAleppo => 'Halep';

  @override
  String get governorateHoms => 'Humus';

  @override
  String get governorateHama => 'Hama';

  @override
  String get governorateLatakia => 'Lazkiye';

  @override
  String get governorateTartus => 'Tartus';

  @override
  String get governorateIdlib => 'İdlib';

  @override
  String get governorateDeirEzzor => 'Deyrizor';

  @override
  String get governorateHasakah => 'Haseke';

  @override
  String get governorateRaqqa => 'Rakka';

  @override
  String get governorateDaraa => 'Dera';

  @override
  String get governorateSuwayda => 'Süveyda';

  @override
  String get governorateQuneitra => 'Kuneytra';
}
