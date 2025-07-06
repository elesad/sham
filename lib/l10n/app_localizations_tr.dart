// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Şam Ulaşım';

  @override
  String get welcome => 'Ana Sayfa';

  @override
  String get busStops => 'Otobüs Durakları';

  @override
  String get fromGovernorate => 'Kalkış valiliğini seçin';

  @override
  String get toGovernorate => 'Varış valiliğini seçin';

  @override
  String get showBusLine => 'Otobüs Hattını Göster';

  @override
  String get busLineTitle => 'Otobüs Hattı';

  @override
  String busLineContent(Object from, Object to) {
    return '$from\'den $to\'ya';
  }

  @override
  String get ok => 'Tamam';

  @override
  String get governorateDamascus => 'Şam';

  @override
  String get governorateRifDimashq => 'Rif Dimashq';

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

  // إضافة نصوص جديدة
  String get chatBot => 'Sohbet Botu';
  String get myTrips => 'Yolculuklarım';
  String get myProfile => 'Profilim';
  String get welcomeBack => 'Hoş Geldiniz';
  String get hello => 'Merhaba';
  String get enjoyServices => 'Gelişmiş hizmetlerimizin tadını çıkarın';
  String get loginToAccess => 'Tüm hizmetlere erişmek için giriş yapın';
  String get login => 'Giriş Yap';
  String get appSettings => 'Uygulama Ayarları';
  String get language => 'Dil';
  String get chooseLanguage => 'Dil Seçin';
  String get darkMode => 'Karanlık Mod';
  String get notifications => 'Bildirimler';
  String get aboutAndHelp => 'Hakkında & Yardım';
  String get aboutApp => 'Uygulama Hakkında';
  String get help => 'Yardım';
  String get privacyPolicy => 'Gizlilik Politikası';
  String get version => 'Sürüm 1.0.0 - Şam Ulaşım';
  String get helpGuide => 'Kullanım kılavuzu ve SSS';
  String get privacyInfo => 'Kişisel verilerinizi nasıl koruyoruz';
  
  // نصوص تسجيل الدخول
  String get welcomeToSham => 'Şam Ulaşım\'a Hoş Geldiniz';
  String get chooseLoginMethod => 'Tercih ettiğiniz giriş yöntemini seçin';
  String get loginWithApple => 'Apple ile Giriş Yap';
  String get loginWithGoogle => 'Google ile Giriş Yap';
  String get loginWithFacebook => 'Facebook ile Giriş Yap';
  String get loginWithPhone => 'Telefon Numarası ile Giriş Yap';
  String get or => 'veya';
  String get createNewAccount => 'Yeni Hesap Oluştur';
  String get cancel => 'İptal';
  
  // نصوص إضافية
  String get termsOfService => 'Kullanım Şartları';
  String get termsAndConditions => 'Şartlar ve Koşullar';
  String get close => 'Kapat';
  String get appDescription => 'Suriye\'de toplu taşıma seyahatlerini rezerve etmek için kapsamlı bir uygulama, otobüs, tren ve uçak seyahatlerini kolayca ve güvenle rezerve etmenizi sağlar.';
  String get howToUse => 'Uygulamayı nasıl kullanacağınız:';
  String get step1 => '1. Ulaşım türünü seçin (otobüs, tren, uçak)';
  String get step2 => '2. Kalkış ve varış noktalarını belirleyin';
  String get step3 => '3. Gerekli tarihi seçin';
  String get step4 => '4. Şirket ve koltuk seçin';
  String get step5 => '5. Rezervasyon verilerini ve ödemeyi tamamlayın';
  String get step6 => '6. Biletinizi alın';
  String get privacyDescription => 'Kişisel verilerinizi koruyoruz ve herhangi bir üçüncü tarafla paylaşmıyoruz. Tüm işlemler şifrelenmiş ve güvenlidir.';
  String get termsDescription => 'Bu uygulamayı kullanarak kullanım şartları ve gizlilik politikasını kabul etmiş olursunuz.';
  String get darkModeTitle => 'Karanlık Mod';
  String get darkModeSubtitle => 'Karanlık görünümü etkinleştir';
  String get notificationsTitle => 'Bildirimler';
  String get notificationsSubtitle => 'Uygulama bildirimlerini etkinleştir';
  String get enterPhoneForCode => 'Doğrulama kodu almak için telefon numaranızı girin';
  String get phoneNumber => 'Telefon Numarası';
  String get sendCode => 'Kodu Gönder';
  String get fullName => 'Tam Ad';
  String get email => 'E-posta';
  String get password => 'Şifre';
  String get confirmPassword => 'Şifreyi Onayla';
  String get createAccount => 'Hesap Oluştur';
  String get accountInfo => 'Hesap Bilgileri';
  String get name => 'Ad';
  String get logout => 'Çıkış Yap';
  String get myTripsTitle => 'Yolculuklarım';
  String get noTripsMessage => 'Tüm rezerve edilmiş yolculuklarınız burada görünecek';
  String get transportType => 'Ulaşım Türü';
  String get bus => 'Otobüs';
  String get train => 'Tren';
  String get flight => 'Uçak';
  String get tripDetails => 'Yolculuk Detayları';
}
