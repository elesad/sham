import '../models/bus_models.dart';

// بيانات المحافظات السورية الـ 14
class BusData {
  static final List<Province> provinces = [
    Province(id: 'damascus', name: 'دمشق', nameEn: 'Damascus'),
    Province(id: 'aleppo', name: 'حلب', nameEn: 'Aleppo'),
    Province(id: 'homs', name: 'حمص', nameEn: 'Homs'),
    Province(id: 'latakia', name: 'اللاذقية', nameEn: 'Latakia'),
    Province(id: 'tartus', name: 'طرطوس', nameEn: 'Tartus'),
    Province(id: 'deir_ez_zor', name: 'دير الزور', nameEn: 'Deir ez-Zor'),
    Province(id: 'hama', name: 'حماة', nameEn: 'Hama'),
    Province(id: 'daraa', name: 'درعا', nameEn: 'Daraa'),
    Province(id: 'as_suwayda', name: 'السويداء', nameEn: 'As-Suwayda'),
    Province(id: 'raqqa', name: 'الرقة', nameEn: 'Raqqa'),
    Province(id: 'idlib', name: 'إدلب', nameEn: 'Idlib'),
    Province(id: 'al_hasakah', name: 'الحسكة', nameEn: 'Al-Hasakah'),
    Province(id: 'quneitra', name: 'القنيطرة', nameEn: 'Quneitra'),
    Province(id: 'damascus_countryside', name: 'ريف دمشق', nameEn: 'Damascus Countryside'),
  ];

  // بيانات شركات الباصات السورية الـ 8
  static final List<BusCompany> companies = [
    BusCompany(
      id: 'company_1',
      name: 'شركة النقل السريع',
      logo: '🚌',
      description: 'خدمة نقل مريحة وآمنة بين جميع المحافظات',
      rating: 4.8,
      reviewCount: 1250,
    ),
    BusCompany(
      id: 'company_2',
      name: 'شركة الشام للنقل',
      logo: '🚌',
      description: 'رحلات يومية منتظمة مع أعلى معايير الجودة',
      rating: 4.6,
      reviewCount: 980,
    ),
    BusCompany(
      id: 'company_3',
      name: 'شركة النقل الوطني',
      logo: '🚌',
      description: 'خدمة نقل شاملة مع مركبات حديثة ومريحة',
      rating: 4.7,
      reviewCount: 1100,
    ),
    BusCompany(
      id: 'company_4',
      name: 'شركة الأمانة للنقل',
      logo: '🚌',
      description: 'نقل آمن ومريح مع سائقين محترفين',
      rating: 4.5,
      reviewCount: 850,
    ),
    BusCompany(
      id: 'company_5',
      name: 'شركة النقل الموحد',
      logo: '🚌',
      description: 'خدمة نقل موحدة مع أسعار منافسة',
      rating: 4.4,
      reviewCount: 720,
    ),
    BusCompany(
      id: 'company_6',
      name: 'شركة الشرق للنقل',
      logo: '🚌',
      description: 'رحلات مريحة مع خدمة عملاء متميزة',
      rating: 4.6,
      reviewCount: 650,
    ),
    BusCompany(
      id: 'company_7',
      name: 'شركة النقل الحديث',
      logo: '🚌',
      description: 'مركبات حديثة مع أحدث التقنيات',
      rating: 4.3,
      reviewCount: 580,
    ),
    BusCompany(
      id: 'company_8',
      name: 'شركة النقل السوري',
      logo: '🚌',
      description: 'خدمة نقل تقليدية مع جودة عالية',
      rating: 4.5,
      reviewCount: 920,
    ),
  ];

  // إنشاء مقاعد الباص بنظام 2+1
  static List<BusSeat> generateBusSeats() {
    List<BusSeat> seats = [];
    int seatId = 1;
    
    // 12 صف من المقاعد
    for (int row = 1; row <= 12; row++) {
      // المقعد الأول (نافذة)
      seats.add(BusSeat(
        id: 'seat_${seatId++}',
        rowNumber: row,
        seatNumber: 1,
        type: SeatType.window,
      ));
      
      // المقعد الثاني (وسط)
      seats.add(BusSeat(
        id: 'seat_${seatId++}',
        rowNumber: row,
        seatNumber: 2,
        type: SeatType.middle,
      ));
      
      // المقعد الثالث (ممر)
      seats.add(BusSeat(
        id: 'seat_${seatId++}',
        rowNumber: row,
        seatNumber: 3,
        type: SeatType.aisle,
      ));
    }
    
    return seats;
  }

  // إنشاء رحلة تجريبية
  static BusTrip createSampleTrip({
    required String fromProvince,
    required String toProvince,
    required DateTime date,
    required String companyId,
  }) {
    final departureTime = DateTime(date.year, date.month, date.day, 8, 0);
    final arrivalTime = departureTime.add(Duration(hours: 3));
    
    return BusTrip(
      id: 'trip_${DateTime.now().millisecondsSinceEpoch}',
      companyId: companyId,
      fromProvince: fromProvince,
      toProvince: toProvince,
      departureTime: departureTime,
      arrivalTime: arrivalTime,
      price: 2500.0, // 2500 ليرة سورية
      seats: generateBusSeats(),
      busNumber: 'SY-${companyId.split('_')[1]}-001',
    );
  }
} 