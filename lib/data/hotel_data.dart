import '../models/hotel_models.dart';

class HotelData {
  static final List<Hotel> hotels = [
    // دمشق
    Hotel(
      id: 'hotel_1',
      name: 'فندق الشام الكبير',
      province: 'دمشق',
      address: 'شارع الحمراء، دمشق',
      description: 'فندق فاخر في قلب العاصمة مع إطلالة رائعة على المدينة',
      rating: 4.8,
      reviewCount: 1250,
      amenities: ['واي فاي مجاني', 'مطعم', 'صالة رياضية', 'مسبح', 'موقف سيارات'],
      images: ['🏨'],
      pricePerNight: 150000,
      currency: 'ل.س',
      stars: 5,
    ),
    Hotel(
      id: 'hotel_2',
      name: 'فندق الأموي',
      province: 'دمشق',
      address: 'حي القيمرية، دمشق',
      description: 'فندق تقليدي مع تصميم عربي أصيل',
      rating: 4.5,
      reviewCount: 890,
      amenities: ['واي فاي مجاني', 'مطعم', 'حديقة', 'موقف سيارات'],
      images: ['🏨'],
      pricePerNight: 120000,
      currency: 'ل.س',
      stars: 4,
    ),
    Hotel(
      id: 'hotel_3',
      name: 'فندق دمشق الدولي',
      province: 'دمشق',
      address: 'شارع بغداد، دمشق',
      description: 'فندق حديث مع جميع الخدمات العصرية',
      rating: 4.6,
      reviewCount: 1100,
      amenities: ['واي فاي مجاني', 'مطعم', 'صالة رياضية', 'مسبح', 'ساونا'],
      images: ['🏨'],
      pricePerNight: 180000,
      currency: 'ل.س',
      stars: 5,
    ),
    
    // حلب
    Hotel(
      id: 'hotel_4',
      name: 'فندق حلب القديمة',
      province: 'حلب',
      address: 'حي الجديدة، حلب',
      description: 'فندق في قلب المدينة القديمة مع إطلالة على القلعة',
      rating: 4.7,
      reviewCount: 950,
      amenities: ['واي فاي مجاني', 'مطعم', 'حديقة', 'موقف سيارات'],
      images: ['🏨'],
      pricePerNight: 100000,
      currency: 'ل.س',
      stars: 4,
    ),
    Hotel(
      id: 'hotel_5',
      name: 'فندق الشرق',
      province: 'حلب',
      address: 'شارع بارون، حلب',
      description: 'فندق تاريخي مع خدمة عصرية',
      rating: 4.4,
      reviewCount: 720,
      amenities: ['واي فاي مجاني', 'مطعم', 'موقف سيارات'],
      images: ['🏨'],
      pricePerNight: 80000,
      currency: 'ل.س',
      stars: 3,
    ),
    Hotel(
      id: 'hotel_6',
      name: 'فندق حلب الحديث',
      province: 'حلب',
      address: 'حي الشهباء، حلب',
      description: 'فندق حديث مع جميع وسائل الراحة',
      rating: 4.3,
      reviewCount: 650,
      amenities: ['واي فاي مجاني', 'مطعم', 'صالة رياضية', 'موقف سيارات'],
      images: ['🏨'],
      pricePerNight: 90000,
      currency: 'ل.س',
      stars: 4,
    ),
    
    // اللاذقية
    Hotel(
      id: 'hotel_7',
      name: 'فندق البحر الأبيض',
      province: 'اللاذقية',
      address: 'كورنيش اللاذقية',
      description: 'فندق على شاطئ البحر مع إطلالة رائعة',
      rating: 4.6,
      reviewCount: 880,
      amenities: ['واي فاي مجاني', 'مطعم', 'مسبح', 'شاطئ خاص', 'موقف سيارات'],
      images: ['🏨'],
      pricePerNight: 140000,
      currency: 'ل.س',
      stars: 4,
    ),
    Hotel(
      id: 'hotel_8',
      name: 'فندق اللاذقية السياحي',
      province: 'اللاذقية',
      address: 'شارع 8 آذار، اللاذقية',
      description: 'فندق مريح في وسط المدينة',
      rating: 4.2,
      reviewCount: 540,
      amenities: ['واي فاي مجاني', 'مطعم', 'موقف سيارات'],
      images: ['🏨'],
      pricePerNight: 70000,
      currency: 'ل.س',
      stars: 3,
    ),
    
    // الحسكة
    Hotel(
      id: 'hotel_9',
      name: 'فندق الجزيرة',
      province: 'الحسكة',
      address: 'وسط مدينة الحسكة',
      description: 'فندق حديث في قلب الجزيرة',
      rating: 4.1,
      reviewCount: 420,
      amenities: ['واي فاي مجاني', 'مطعم', 'موقف سيارات'],
      images: ['🏨'],
      pricePerNight: 60000,
      currency: 'ل.س',
      stars: 3,
    ),
    Hotel(
      id: 'hotel_10',
      name: 'فندق الحسكة الدولي',
      province: 'الحسكة',
      address: 'شارع الكورنيش، الحسكة',
      description: 'أفضل فندق في المنطقة مع خدمة متميزة',
      rating: 4.4,
      reviewCount: 380,
      amenities: ['واي فاي مجاني', 'مطعم', 'صالة رياضية', 'موقف سيارات'],
      images: ['🏨'],
      pricePerNight: 85000,
      currency: 'ل.س',
      stars: 4,
    ),
  ];

  static List<Hotel> getHotelsByProvince(String province) {
    return hotels.where((hotel) => hotel.province == province).toList();
  }
} 