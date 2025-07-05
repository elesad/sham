// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Transport App';

  @override
  String get welcome => 'Welcome';

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
  String get governorateDeirEzzor => 'Deir ez-Zor';

  @override
  String get governorateHasakah => 'Hasakah';

  @override
  String get governorateRaqqa => 'Raqqa';

  @override
  String get governorateDaraa => 'Daraa';

  @override
  String get governorateSuwayda => 'As-Suwayda';

  @override
  String get governorateQuneitra => 'Quneitra';
}
