import '../models/hotel_models.dart';

class HotelData {
  static final List<Hotel> hotels = [
    // دمشق
    Hotel(
      id: 'hotel_1',
      name: 'فندق الشام الكبير',
      province: 'دمشق',
      address: 'شارع الحمرا، دمشق',
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
    Hotel(
      id: 'hotel_4',
      name: 'فندق بردى',
      province: 'دمشق',
      address: 'شارع الثورة، دمشق',
      description: 'إقامة مريحة مع إطلالة على نهر بردى',
      rating: 4.3,
      reviewCount: 700,
      amenities: ['واي فاي مجاني', 'مطعم', 'موقف سيارات'],
      images: ['🏨'],
      pricePerNight: 95000,
      currency: 'ل.س',
      stars: 3,
    ),
    Hotel(
      id: 'hotel_5',
      name: 'فندق قاسيون',
      province: 'دمشق',
      address: 'جبل قاسيون، دمشق',
      description: 'إطلالة بانورامية على دمشق من الأعلى',
      rating: 4.7,
      reviewCount: 800,
      amenities: ['واي فاي مجاني', 'مطعم', 'مسبح'],
      images: ['🏨'],
      pricePerNight: 160000,
      currency: 'ل.س',
      stars: 4,
    ),
    
    // حلب
    Hotel(
      id: 'hotel_6',
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
      id: 'hotel_7',
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
      id: 'hotel_8',
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
    Hotel(
      id: 'hotel_9',
      name: 'فندق القلعة',
      province: 'حلب',
      address: 'قرب قلعة حلب، حلب',
      description: 'إقامة فاخرة بجوار القلعة التاريخية',
      rating: 4.8,
      reviewCount: 1200,
      amenities: ['واي فاي مجاني', 'مطعم', 'مسبح'],
      images: ['🏨'],
      pricePerNight: 130000,
      currency: 'ل.س',
      stars: 5,
    ),
    Hotel(
      id: 'hotel_10',
      name: 'فندق السيف',
      province: 'حلب',
      address: 'شارع النيل، حلب',
      description: 'فندق اقتصادي مع خدمة جيدة',
      rating: 4.1,
      reviewCount: 500,
      amenities: ['واي فاي مجاني', 'مطعم'],
      images: ['🏨'],
      pricePerNight: 60000,
      currency: 'ل.س',
      stars: 2,
    ),
    
    // اللاذقية
    Hotel(
      id: 'hotel_11',
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
      id: 'hotel_12',
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
    Hotel(
      id: 'hotel_13',
      name: 'فندق اللاذقية المطلة',
      province: 'اللاذقية',
      address: 'شارع المطلة، اللاذقية',
      description: 'فندق مريح مع إطلالة على البحر',
      rating: 4.5,
      reviewCount: 600,
      amenities: ['واي فاي مجاني', 'مطعم', 'موقف سيارات'],
      images: ['🏨'],
      pricePerNight: 80000,
      currency: 'ل.س',
      stars: 3,
    ),
    Hotel(
      id: 'hotel_14',
      name: 'فندق اللاذقية المركزي',
      province: 'اللاذقية',
      address: 'شارع المركز، اللاذقية',
      description: 'فندق مركزي مع خدمات كاملة',
      rating: 4.4,
      reviewCount: 480,
      amenities: ['واي فاي مجاني', 'مطعم', 'صالة رياضية', 'موقف سيارات'],
      images: ['🏨'],
      pricePerNight: 90000,
      currency: 'ل.س',
      stars: 4,
    ),
    Hotel(
      id: 'hotel_15',
      name: 'فندق اللاذقية المتنوع',
      province: 'اللاذقية',
      address: 'شارع المتنوع، اللاذقية',
      description: 'فندق متنوع مع خدمات متنوعة',
      rating: 4.3,
      reviewCount: 550,
      amenities: ['واي فاي مجاني', 'مطعم', 'موقف سيارات'],
      images: ['🏨'],
      pricePerNight: 75000,
      currency: 'ل.س',
      stars: 3,
    ),
    
    // الحسكة
    Hotel(
      id: 'hotel_16',
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
      id: 'hotel_17',
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
    Hotel(
      id: 'hotel_18',
      name: 'فندق الحسكة المتنوع',
      province: 'الحسكة',
      address: 'شارع المتنوع، الحسكة',
      description: 'فندق متنوع مع خدمات متنوعة',
      rating: 4.2,
      reviewCount: 450,
      amenities: ['واي فاي مجاني', 'مطعم', 'موقف سيارات'],
      images: ['🏨'],
      pricePerNight: 70000,
      currency: 'ل.س',
      stars: 3,
    ),
    Hotel(
      id: 'hotel_19',
      name: 'فندق الحسكة المركزي',
      province: 'الحسكة',
      address: 'شارع المركز، الحسكة',
      description: 'فندق مركزي مع خدمات كاملة',
      rating: 4.3,
      reviewCount: 500,
      amenities: ['واي فاي مجاني', 'مطعم', 'صالة رياضية', 'موقف سيارات'],
      images: ['🏨'],
      pricePerNight: 80000,
      currency: 'ل.س',
      stars: 4,
    ),
    Hotel(
      id: 'hotel_20',
      name: 'فندق الحسكة المطلة',
      province: 'الحسكة',
      address: 'شارع المطلة، الحسكة',
      description: 'فندق مطل على البحر مع خدمات جيدة',
      rating: 4.5,
      reviewCount: 400,
      amenities: ['واي فاي مجاني', 'مطعم', 'موقف سيارات'],
      images: ['🏨'],
      pricePerNight: 95000,
      currency: 'ل.س',
      stars: 4,
    ),
  ];

  static List<Hotel> getHotelsByProvince(String province) {
    return hotels.where((hotel) => hotel.province == province).toList();
  }
} 