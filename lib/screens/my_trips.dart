import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  TripType? selectedType;

  @override
  Widget build(BuildContext context) {
    final myTripsProvider = Provider.of<MyTripsProvider>(context);
    final trips = selectedType == null
        ? myTripsProvider.trips
        : myTripsProvider.trips.where((t) => t.type == selectedType).toList();
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('رحلاتي', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF127C8A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
                  children: [
          // شريط الفلترة العلوي
            Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                  ChoiceChip(
                    label: const Text('الكل', style: TextStyle(fontFamily: 'Cairo')),
                    selected: selectedType == null,
                    selectedColor: const Color(0xFF127C8A),
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(color: selectedType == null ? Colors.white : const Color(0xFF127C8A)),
                    onSelected: (_) => setState(() => selectedType = null),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('باص', style: TextStyle(fontFamily: 'Cairo')),
                    selected: selectedType == TripType.bus,
                    selectedColor: const Color(0xFF127C8A),
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(color: selectedType == TripType.bus ? Colors.white : const Color(0xFF127C8A)),
                    onSelected: (_) => setState(() => selectedType = TripType.bus),
                            ),
                            const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('قطار', style: TextStyle(fontFamily: 'Cairo')),
                    selected: selectedType == TripType.train,
                    selectedColor: const Color(0xFF10B981),
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(color: selectedType == TripType.train ? Colors.white : const Color(0xFF10B981)),
                    onSelected: (_) => setState(() => selectedType = TripType.train),
                ),
                const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('فندق', style: TextStyle(fontFamily: 'Cairo')),
                    selected: selectedType == TripType.hotel,
                    selectedColor: const Color(0xFF8B5CF6),
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(color: selectedType == TripType.hotel ? Colors.white : const Color(0xFF8B5CF6)),
                    onSelected: (_) => setState(() => selectedType = TripType.hotel),
                                        ),
                                        const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('طيارة', style: TextStyle(fontFamily: 'Cairo')),
                    selected: selectedType == TripType.flight,
                    selectedColor: const Color(0xFFF59E0B),
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(color: selectedType == TripType.flight ? Colors.white : const Color(0xFFF59E0B)),
                    onSelected: (_) => setState(() => selectedType = TripType.flight),
                                        ),
                                      ],
                                    ),
            ),
          ),
          // قائمة الرحلات
              Expanded(
            child: trips.isEmpty
                ? const Center(child: Text('لا يوجد رحلات بعد', style: TextStyle(fontFamily: 'Cairo')))
                : ListView.builder(
      padding: const EdgeInsets.all(16),
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      final trip = trips[index];
    return Container(
                        margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
                              color: Colors.black.withOpacity(0.07),
                              blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
              child: Row(
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
                                  child: Icon(_tripTypeIcon(trip.type), color: _tripTypeColor(trip.type), size: 26),
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
                                          style: const TextStyle(
                                            fontFamily: 'Cairo',
                                        fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                        color: Color(0xFF1F2937),
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
                                        const SizedBox(height: 4),
                                    Row(
                                children: [
                                        Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                                        const SizedBox(width: 4),
                                  Text(
                                          trip.time ?? '',
                                          style: const TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(width: 12),
                                        Icon(Icons.attach_money, size: 14, color: Colors.grey[600]),
                                        const SizedBox(width: 4),
                          Text(
                                          trip.price != null ? '${trip.price!.toInt()} ل.س' : '',
                                          style: const TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Color(0xFF127C8A), fontWeight: FontWeight.bold),
                                        ),
                                      ],
                    ),
                  ],
                ),
              ),
                              // زر القلب
                  IconButton(
                    onPressed: () {
                                  // إضافة للمفضلة (نفس منطق الشاشات الأخرى)
                                },
                                icon: const Icon(Icons.favorite_border, color: Colors.grey, size: 26),
                              ),
                            ],
                              ),
                            ),
                          );
                    },
            ),
          ),
        ],
      ),
    );
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
