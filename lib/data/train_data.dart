import '../models/train_models.dart';

class TrainData {
  static final List<TrainCompany> companies = [
    TrainCompany(
      id: 'train_company_1',
      name: 'القطارات السورية',
      logo: '🚆',
      description: 'شبكة القطارات الوطنية بين المحافظات الرئيسية',
      rating: 4.2,
      reviewCount: 400,
    ),
  ];

  static final List<TrainTrip> trips = [
    TrainTrip(
      id: 'train_trip_1',
      companyId: 'train_company_1',
      fromCity: 'دمشق',
      toCity: 'حلب',
      departureTime: DateTime(2024, 7, 1, 9, 0),
      arrivalTime: DateTime(2024, 7, 1, 14, 0),
      price: 20000,
      trainNumber: 'TR-1001',
    ),
  ];
} 