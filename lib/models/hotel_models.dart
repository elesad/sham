import '../models/bus_models.dart';

// نماذج البيانات لحجز الفنادق
class Hotel {
  final String id;
  final String name;
  final String province;
  final String address;
  final String description;
  final double rating;
  final int reviewCount;
  final List<String> amenities;
  final List<String> images;
  final double pricePerNight;
  final String currency;
  final int stars;

  Hotel({
    required this.id,
    required this.name,
    required this.province,
    required this.address,
    required this.description,
    required this.rating,
    required this.reviewCount,
    required this.amenities,
    required this.images,
    required this.pricePerNight,
    required this.currency,
    required this.stars,
  });
}

class HotelBooking {
  final String id;
  final String hotelId;
  final String guestName;
  final String guestEmail;
  final String guestPhone;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int numberOfGuests;
  final int numberOfRooms;
  final double totalPrice;
  final PaymentMethod paymentMethod;
  final DateTime bookingDate;
  BookingStatus status;

  HotelBooking({
    required this.id,
    required this.hotelId,
    required this.guestName,
    required this.guestEmail,
    required this.guestPhone,
    required this.checkInDate,
    required this.checkOutDate,
    required this.numberOfGuests,
    required this.numberOfRooms,
    required this.totalPrice,
    required this.paymentMethod,
    required this.bookingDate,
    this.status = BookingStatus.pending,
  });
} 