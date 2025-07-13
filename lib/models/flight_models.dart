import '../models/bus_models.dart';

// نماذج البيانات لحجز الطائرات
class FlightCompany {
  final String id;
  final String name;
  final String logo;
  final String description;
  final double rating;
  final int reviewCount;

  FlightCompany({
    required this.id,
    required this.name,
    required this.logo,
    required this.description,
    required this.rating,
    required this.reviewCount,
  });
}

class Flight {
  final String id;
  final String companyId;
  final String fromCity;
  final String toCity;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final double price;
  final String flightNumber;
  final String aircraftType;
  final int availableSeats;

  Flight({
    required this.id,
    required this.companyId,
    required this.fromCity,
    required this.toCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.flightNumber,
    required this.aircraftType,
    required this.availableSeats,
  });
}

class FlightBooking {
  final String id;
  final String flightId;
  final String companyId;
  final PassengerInfo passengerInfo;
  final String nationality;
  final String passportNumber;
  final PaymentMethod paymentMethod;
  final DateTime bookingDate;
  final double totalPrice;
  BookingStatus status;

  FlightBooking({
    required this.id,
    required this.flightId,
    required this.companyId,
    required this.passengerInfo,
    required this.nationality,
    required this.passportNumber,
    required this.paymentMethod,
    required this.bookingDate,
    required this.totalPrice,
    this.status = BookingStatus.pending,
  });
}

class VisaInfo {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;

  VisaInfo({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
  });
} 