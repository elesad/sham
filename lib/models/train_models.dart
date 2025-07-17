// نموذج شركة قطار
class TrainCompany {
  final String id;
  final String name;
  final String logo;
  final String description;
  final double rating;
  final int reviewCount;

  TrainCompany({
    required this.id,
    required this.name,
    required this.logo,
    required this.description,
    required this.rating,
    required this.reviewCount,
  });
}

// نموذج رحلة قطار
class TrainTrip {
  final String id;
  final String companyId;
  final String fromCity;
  final String toCity;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final double price;
  final String trainNumber;

  TrainTrip({
    required this.id,
    required this.companyId,
    required this.fromCity,
    required this.toCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.trainNumber,
  });
} 