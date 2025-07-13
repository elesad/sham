import '../models/flight_models.dart';

class FlightData {
  static final List<FlightCompany> companies = [
    FlightCompany(
      id: 'company_1',
      name: 'سورية للطيران',
      logo: '✈️',
      description: 'الناقل الوطني السوري مع رحلات داخلية ودولية',
      rating: 4.5,
      reviewCount: 1200,
    ),
    FlightCompany(
      id: 'company_2',
      name: 'طيران الشرق',
      logo: '✈️',
      description: 'شركة طيران خاصة مع أسعار منافسة',
      rating: 4.3,
      reviewCount: 850,
    ),
    FlightCompany(
      id: 'company_3',
      name: 'طيران الشام',
      logo: '✈️',
      description: 'خدمة طيران محلية متميزة',
      rating: 4.6,
      reviewCount: 680,
    ),
  ];

  static final List<String> flightCities = ['حلب', 'دمشق', 'الحسكة'];

  static List<Flight> getFlights({
    required String fromCity,
    required String toCity,
    required DateTime date,
  }) {
    final flights = <Flight>[];
    final baseTime = DateTime(date.year, date.month, date.day, 8, 0);
    
    for (int i = 0; i < companies.length; i++) {
      final company = companies[i];
      final departureTime = baseTime.add(Duration(hours: i * 2));
      final arrivalTime = departureTime.add(const Duration(hours: 1, minutes: 30));
      
      flights.add(Flight(
        id: 'flight_${i + 1}',
        companyId: company.id,
        fromCity: fromCity,
        toCity: toCity,
        departureTime: departureTime,
        arrivalTime: arrivalTime,
        price: 50000 + (i * 10000), // أسعار مختلفة لكل شركة
        flightNumber: 'SY${100 + i}',
        aircraftType: 'Airbus A320',
        availableSeats: 150 - (i * 20),
      ));
    }
    
    return flights;
  }

  static final List<String> countries = [
    'سوريا',
    'لبنان',
    'الأردن',
    'مصر',
    'السعودية',
    'الإمارات',
    'الكويت',
    'قطر',
    'البحرين',
    'عمان',
    'العراق',
    'إيران',
    'تركيا',
    'ألمانيا',
    'فرنسا',
    'بريطانيا',
    'إيطاليا',
    'إسبانيا',
    'روسيا',
    'الصين',
    'اليابان',
    'كوريا الجنوبية',
    'الهند',
    'باكستان',
    'أفغانستان',
    'الولايات المتحدة',
    'كندا',
    'أستراليا',
    'البرازيل',
    'الأرجنتين',
  ];
} 