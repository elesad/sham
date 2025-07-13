// نماذج البيانات لحجز تذاكر الباص
class Province {
  final String id;
  final String name;
  final String nameEn;

  Province({
    required this.id,
    required this.name,
    required this.nameEn,
  });
}

class BusCompany {
  final String id;
  final String name;
  final String logo;
  final String description;
  final double rating;
  final int reviewCount;

  BusCompany({
    required this.id,
    required this.name,
    required this.logo,
    required this.description,
    required this.rating,
    required this.reviewCount,
  });
}

class BusSeat {
  final String id;
  final int rowNumber;
  final int seatNumber;
  final SeatType type;
  SeatStatus status;
  SeatGender? gender;
  String? passengerName;

  BusSeat({
    required this.id,
    required this.rowNumber,
    required this.seatNumber,
    required this.type,
    this.status = SeatStatus.available,
    this.gender,
    this.passengerName,
  });
}

enum SeatType {
  window,    // مقعد نافذة
  aisle,     // مقعد ممر
  middle,    // مقعد وسط
}

enum SeatStatus {
  available,   // متاح
  occupied,    // محجوز
  selected,    // مختار
}

enum SeatGender {
  male,    // ذكر
  female,  // أنثى
}

enum Gender {
  male,    // ذكر
  female,  // أنثى
}

class BusTrip {
  final String id;
  final String companyId;
  final String fromProvince;
  final String toProvince;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final double price;
  final List<BusSeat> seats;
  final String busNumber;

  BusTrip({
    required this.id,
    required this.companyId,
    required this.fromProvince,
    required this.toProvince,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.seats,
    required this.busNumber,
  });
}

class Booking {
  final String id;
  final String tripId;
  final String companyId;
  final List<SeatBooking> seats;
  final PassengerInfo passengerInfo;
  final PaymentMethod paymentMethod;
  final DateTime bookingDate;
  final double totalPrice;
  BookingStatus status;

  Booking({
    required this.id,
    required this.tripId,
    required this.companyId,
    required this.seats,
    required this.passengerInfo,
    required this.paymentMethod,
    required this.bookingDate,
    required this.totalPrice,
    this.status = BookingStatus.pending,
  });
}

class SeatBooking {
  final String seatId;
  final SeatGender gender;
  final String passengerName;

  SeatBooking({
    required this.seatId,
    required this.gender,
    required this.passengerName,
  });
}

class PassengerInfo {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String idNumber;

  PassengerInfo({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.idNumber,
  });
}

enum PaymentMethod {
  visa,
  cashOnBoarding,
}

enum BookingStatus {
  pending,
  confirmed,
  cancelled,
} 