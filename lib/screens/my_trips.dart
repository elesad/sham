import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../models/favorites_provider.dart';
import '../models/bus_booking_info.dart';
import '../models/train_models.dart';
import '../models/flight_models.dart';
import '../models/hotel_models.dart';
import 'bus_ticket_screen.dart';
import 'train_ticket_screen.dart';
import 'flight_ticket_screen.dart';
import 'hotel_ticket_screen.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  TripType? selectedType;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final myTripsProvider = Provider.of<MyTripsProvider>(context);
    final trips = _getFilteredTrips(myTripsProvider);
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'رحلاتي',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: isDark ? const Color(0xFF2D2D2D) : const Color(0xFF127C8A),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
        ],
      ),
      body: Column(
                  children: [
          // شريط الفلترة العلوي
            Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2D2D2D) : const Color(0xFF127C8A),
            ),
              child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                  _buildFilterChip('الكل', null, isDark),
                  const SizedBox(width: 8),
                  _buildFilterChip('باص', TripType.bus, isDark),
                            const SizedBox(width: 8),
                  _buildFilterChip('قطار', TripType.train, isDark),
                const SizedBox(width: 8),
                  _buildFilterChip('فندق', TripType.hotel, isDark),
                                        const SizedBox(width: 8),
                  _buildFilterChip('طائرة', TripType.flight, isDark),
                                      ],
                                    ),
            ),
          ),
          // قائمة الرحلات
              Expanded(
            child: trips.isEmpty
                ? _buildEmptyState(isDark)
                : ListView.builder(
      padding: const EdgeInsets.all(16),
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      final trip = trips[index];
                      return _buildTripCard(trip, isDark);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, TripType? type, bool isDark) {
    final isSelected = selectedType == type;
    Color chipColor = Colors.white;
    
    if (type != null) {
      chipColor = _tripTypeColor(type);
    }
    
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected 
            ? Colors.white 
            : (isDark ? Colors.white70 : Colors.white),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedColor: chipColor,
      backgroundColor: isDark ? const Color(0xFF404040) : Colors.white.withOpacity(0.2),
      onSelected: (_) => setState(() => selectedType = type),
    );
  }

  Widget _buildTripCard(Trip trip, bool isDark) {
    return Container(
                        margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
                          borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isDark 
              ? Colors.black.withOpacity(0.3)
              : Colors.black.withOpacity(0.07),
                              blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                              // أيقونة نوع الرحلة
                                  Container(
                                width: 50,
                                height: 50,
                                    decoration: BoxDecoration(
                                  color: _tripTypeColor(trip.type).withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Center(
                    child: Icon(
                      _tripTypeIcon(trip.type),
                      color: _tripTypeColor(trip.type),
                      size: 26,
                    ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                              // معلومات الرحلة
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                      trip.company,
                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                        fontSize: 17,
                                            fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : const Color(0xFF1F2937),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                      _tripTypeLabel(trip.type),
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 12,
                                        color: _tripTypeColor(trip.type),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: isDark ? Colors.white70 : Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${trip.from} → ${trip.to}',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              color: isDark ? Colors.white70 : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                                        const SizedBox(height: 4),
                                    Row(
                                children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: isDark ? Colors.white70 : Colors.grey[600],
                          ),
                                        const SizedBox(width: 4),
                                  Text(
                            trip.time,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              color: isDark ? Colors.white70 : Colors.grey[600],
                            ),
                    ),
                    const SizedBox(width: 12),
                          Icon(
                            Icons.attach_money,
                            size: 14,
                            color: isDark ? Colors.white70 : Colors.grey[600],
                          ),
                                        const SizedBox(width: 4),
                          Text(
                            '${trip.price.toInt()} ل.س',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              color: const Color(0xFF127C8A),
                              fontWeight: FontWeight.bold,
                            ),
                                        ),
                                      ],
                    ),
                  ],
                ),
              ),
                              // زر القلب
                  IconButton(
                    onPressed: () {
                    // إضافة للمفضلة
                    _addToFavorites(trip);
                  },
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                    size: 26,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // شريط الحالة
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(trip.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getStatusIcon(trip.status),
                    size: 16,
                    color: _getStatusColor(trip.status),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _getStatusText(trip.status),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(trip.status),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // أزرار الإجراءات
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _viewTicket(trip),
                    icon: const Icon(Icons.receipt, size: 18),
                    label: const Text(
                      'عرض التذكرة',
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _tripTypeColor(trip.type),
                      side: BorderSide(color: _tripTypeColor(trip.type)),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _downloadTicket(trip),
                    icon: const Icon(Icons.download, size: 18),
                    label: const Text(
                      'تنزيل',
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _tripTypeColor(trip.type),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
                              ),
                            ],
                              ),
                            ),
                          );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF404040) : Colors.grey[100],
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.flight_takeoff,
              size: 60,
              color: isDark ? Colors.white54 : Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد رحلات بعد',
            style: TextStyle(
              fontSize: 18,
              color: isDark ? Colors.white70 : const Color(0xFF6B7280),
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'احجز رحلة جديدة لتظهر هنا',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white54 : const Color(0xFF9CA3AF),
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // العودة للصفحة الرئيسية
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            icon: const Icon(Icons.add),
            label: const Text(
              'احجز رحلة جديدة',
              style: TextStyle(fontFamily: 'Cairo'),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF127C8A),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Trip> _getFilteredTrips(MyTripsProvider provider) {
    var trips = provider.trips;
    
    // فلترة حسب النوع
    if (selectedType != null) {
      trips = trips.where((t) => t.type == selectedType).toList();
    }
    
    // فلترة حسب البحث
    if (searchQuery.isNotEmpty) {
      trips = trips.where((t) => 
        t.company.toLowerCase().contains(searchQuery.toLowerCase()) ||
        t.from.toLowerCase().contains(searchQuery.toLowerCase()) ||
        t.to.toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return trips;
  }

  Color _tripTypeColor(TripType type) {
    switch (type) {
      case TripType.bus:
        return const Color(0xFF127C8A);
      case TripType.train:
        return const Color(0xFF10B981);
      case TripType.hotel:
        return const Color(0xFF8B5CF6);
      case TripType.flight:
        return const Color(0xFFF59E0B);
    }
  }

  IconData _tripTypeIcon(TripType type) {
    switch (type) {
      case TripType.bus:
        return Icons.directions_bus;
      case TripType.train:
        return Icons.train;
      case TripType.hotel:
        return Icons.hotel;
      case TripType.flight:
        return Icons.flight;
    }
  }

  String _tripTypeLabel(TripType type) {
    switch (type) {
      case TripType.bus:
        return 'رحلة باص';
      case TripType.train:
        return 'رحلة قطار';
      case TripType.hotel:
        return 'حجز فندق';
      case TripType.flight:
        return 'رحلة طيران';
    }
  }

  Color _getStatusColor(TripStatus status) {
    switch (status) {
      case TripStatus.confirmed:
        return Colors.green;
      case TripStatus.completed:
        return Colors.blue;
      case TripStatus.cancelled:
        return Colors.red;
    }
  }

  IconData _getStatusIcon(TripStatus status) {
    switch (status) {
      case TripStatus.confirmed:
        return Icons.check_circle;
      case TripStatus.completed:
        return Icons.done_all;
      case TripStatus.cancelled:
        return Icons.cancel;
    }
  }

  String _getStatusText(TripStatus status) {
    switch (status) {
      case TripStatus.confirmed:
        return 'مؤكدة';
      case TripStatus.completed:
        return 'مكتملة';
      case TripStatus.cancelled:
        return 'ملغية';
    }
  }

  void _addToFavorites(Trip trip) {
    // إضافة الرحلة للمفضلة
    final favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
    
    final favoriteItem = FavoriteItem(
      id: trip.id,
      name: trip.company,
      type: _getTripTypeString(trip.type),
      fromLocation: trip.from,
      toLocation: trip.to,
      date: '${trip.date.day}/${trip.date.month}/${trip.date.year}',
      price: trip.price.toString(),
      time: trip.time,
      description: 'رحلة ${_tripTypeLabel(trip.type)}',
      features: 'مقعد: ${trip.seatNumber}',
      addedAt: DateTime.now(),
    );
    
    favoritesProvider.addToFavorites(favoriteItem);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تمت إضافة ${trip.company} إلى المفضلة'),
        backgroundColor: const Color(0xFF127C8A),
      ),
    );
  }

  String _getTripTypeString(TripType type) {
    switch (type) {
      case TripType.bus:
        return 'bus';
      case TripType.train:
        return 'train';
      case TripType.hotel:
        return 'hotel';
      case TripType.flight:
        return 'flight';
    }
  }

  void _viewTicket(Trip trip) {
    switch (trip.type) {
      case TripType.bus:
        _showBusTicket(trip);
        break;
      case TripType.train:
        _showTrainTicket(trip);
        break;
      case TripType.flight:
        _showFlightTicket(trip);
        break;
      case TripType.hotel:
        _showHotelTicket(trip);
        break;
    }
  }

  void _showBusTicket(Trip trip) {
    final bookingInfo = BusBookingInfo(
      email: 'passenger@example.com',
      phone: '09xxxxxxxx',
      firstName: 'اسم',
      lastName: 'المسافر',
      idNumber: '123456789',
      birthDate: DateTime(1990),
      paymentMethod: 'بطاقة ائتمان',
      companyName: trip.company,
      seatNumber: trip.seatNumber,
      tripDate: '${trip.date.day}/${trip.date.month}/${trip.date.year}',
      tripTime: trip.time,
      bookingId: trip.ticketNumber,
      fromCity: trip.from,
      toCity: trip.to,
    );
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusTicketScreen(bookingInfo: bookingInfo),
      ),
    );
  }

  void _showTrainTicket(Trip trip) {
    // إنشاء بيانات بسيطة للقطار
    final bookingData = {
      'from': trip.from,
      'to': trip.to,
      'date': trip.date,
      'time': trip.time,
      'company': trip.company,
      'seatNumber': trip.seatNumber,
      'ticketNumber': trip.ticketNumber,
      'price': trip.price,
    };
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrainTicketScreen(bookingInfo: bookingData),
      ),
    );
  }

  void _showFlightTicket(Trip trip) {
    // إنشاء بيانات بسيطة للطائرة
    final bookingData = {
      'from': trip.from,
      'to': trip.to,
      'date': trip.date,
      'time': trip.time,
      'company': trip.company,
      'seatNumber': trip.seatNumber,
      'ticketNumber': trip.ticketNumber,
      'price': trip.price,
    };
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlightTicketScreen(bookingInfo: bookingData),
      ),
    );
  }

  void _showHotelTicket(Trip trip) {
    final bookingData = {
      'hotelName': trip.company,
      'hotelImage': 'https://source.unsplash.com/400x300/?hotel,${trip.to}',
      'location': trip.to,
      'rating': 4.5,
      'price': trip.price.toInt(),
      'checkInDate': trip.date,
      'checkOutDate': trip.date.add(const Duration(days: 1)),
      'rooms': 1,
      'guests': 2,
      'name': 'اسم المسافر',
      'email': 'email@example.com',
      'phone': '09xxxxxxxx',
      'id': '123456789',
      'birthDate': DateTime(1990),
    };
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HotelTicketScreen(bookingData: bookingData),
      ),
    );
  }

  void _downloadTicket(Trip trip) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تنزيل تذكرة ${trip.company}'),
        backgroundColor: const Color(0xFF127C8A),
      ),
    );
  }

  void _showSearchDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        title: Text(
          'البحث في رحلاتي',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        content: TextField(
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
          ),
          decoration: InputDecoration(
            hintText: 'ابحث عن شركة أو مدينة...',
            hintStyle: TextStyle(
              color: isDark ? Colors.white54 : Colors.grey,
            ),
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('بحث'),
          ),
        ],
      ),
    );
  }
}

enum TripType { bus, flight, hotel, train }
enum TripStatus { confirmed, completed, cancelled }

class Trip {
  final String id;
  final TripType type;
  final String from;
  final String to;
  final DateTime date;
  final String time;
  final String company;
  final TripStatus status;
  final double price;
  final String seatNumber;
  final String ticketNumber;

  Trip({
    required this.id,
    required this.type,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.company,
    required this.status,
    required this.price,
    required this.seatNumber,
    required this.ticketNumber,
  });
} 
