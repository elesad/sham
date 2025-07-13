import 'package:flutter/material.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Trip> _upcomingTrips = [
    Trip(
      id: '1',
      type: TripType.bus,
      from: 'دمشق',
      to: 'حلب',
      date: DateTime.now().add(const Duration(days: 2)),
      time: '08:00',
      company: 'شركة الشام للنقل',
      status: TripStatus.confirmed,
      price: 1500,
      seatNumber: 'A12',
    ),
    Trip(
      id: '2',
      type: TripType.flight,
      from: 'دمشق',
      to: 'دبي',
      date: DateTime.now().add(const Duration(days: 7)),
      time: '14:30',
      company: 'طيران الإمارات',
      status: TripStatus.confirmed,
      price: 45000,
      seatNumber: '15B',
    ),
  ];

  final List<Trip> _completedTrips = [
    Trip(
      id: '3',
      type: TripType.hotel,
      from: 'حلب',
      to: 'فندق الشام',
      date: DateTime.now().subtract(const Duration(days: 5)),
      time: '15:00',
      company: 'فندق الشام الفاخر',
      status: TripStatus.completed,
      price: 25000,
      seatNumber: 'غرفة 305',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'رحلاتي',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'القادمة'),
            Tab(text: 'المكتملة'),
            Tab(text: 'ملغية'),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF1E3A8A),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Color(0xFF1E3A8A)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'البحث في رحلاتي...',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.filter_list,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTripsList(_upcomingTrips),
                _buildTripsList(_completedTrips),
                _buildTripsList([]), // رحلات ملغية
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripsList(List<Trip> trips) {
    if (trips.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                _getEmptyIcon(),
                size: 60,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _getEmptyMessage(),
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'ابدأ بحجز رحلتك الأولى!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        return _buildTripCard(trips[index]);
      },
    );
  }

  Widget _buildTripCard(Trip trip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _getTripGradient(trip.type),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getTripIcon(trip.type),
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${trip.from} → ${trip.to}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        trip.company,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getStatusText(trip.status),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildInfoItem(Icons.calendar_today, _formatDate(trip.date)),
                    const SizedBox(width: 24),
                    _buildInfoItem(Icons.access_time, trip.time),
                    const SizedBox(width: 24),
                    _buildInfoItem(Icons.event_seat, trip.seatNumber),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${trip.price.toStringAsFixed(0)} ل.س',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                        fontFamily: 'Cairo',
                      ),
                    ),
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: () => _showTripDetails(trip),
                          icon: const Icon(Icons.info_outline, size: 18),
                          label: const Text('التفاصيل'),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF1E3A8A),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () => _downloadTicket(trip),
                          icon: const Icon(Icons.download, size: 18),
                          label: const Text('تحميل التذكرة'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E3A8A),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }

  IconData _getTripIcon(TripType type) {
    switch (type) {
      case TripType.bus:
        return Icons.directions_bus;
      case TripType.flight:
        return Icons.flight;
      case TripType.hotel:
        return Icons.hotel;
    }
  }

  List<Color> _getTripGradient(TripType type) {
    switch (type) {
      case TripType.bus:
        return [const Color(0xFF1E3A8A), const Color(0xFF3B82F6)];
      case TripType.flight:
        return [const Color(0xFF059669), const Color(0xFF10B981)];
      case TripType.hotel:
        return [const Color(0xFFDC2626), const Color(0xFFEF4444)];
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  IconData _getEmptyIcon() {
    switch (_tabController.index) {
      case 0:
        return Icons.flight_takeoff;
      case 1:
        return Icons.check_circle;
      case 2:
        return Icons.cancel;
      default:
        return Icons.flight;
    }
  }

  String _getEmptyMessage() {
    switch (_tabController.index) {
      case 0:
        return 'لا توجد رحلات قادمة';
      case 1:
        return 'لا توجد رحلات مكتملة';
      case 2:
        return 'لا توجد رحلات ملغية';
      default:
        return 'لا توجد رحلات';
    }
  }

  void _showTripDetails(Trip trip) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تفاصيل الرحلة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('من: ${trip.from}'),
            Text('إلى: ${trip.to}'),
            Text('التاريخ: ${_formatDate(trip.date)}'),
            Text('الوقت: ${trip.time}'),
            Text('الشركة: ${trip.company}'),
            Text('رقم المقعد: ${trip.seatNumber}'),
            Text('السعر: ${trip.price.toStringAsFixed(0)} ل.س'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _downloadTicket(Trip trip) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('جاري تحميل تذكرة الرحلة إلى ${trip.to}...'),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
    );
  }
}

enum TripType { bus, flight, hotel }
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
  });
} 
