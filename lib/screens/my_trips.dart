import 'package:flutter/material.dart';
import 'bus_seat_selection.dart';

// عنصر بطاقة رحلة باص حديث
class BusTripCard extends StatelessWidget {
  final String companyName;
  final String companyLogoAsset; // يمكن أن يكون مسار صورة أو Network
  final String busType;
  final String departureTime;
  final String duration;
  final String price;
  final String currency;
  final String cityService;
  final String seatsLeft;
  final bool isLastSeats;
  final VoidCallback onSelect;

  const BusTripCard({
    super.key,
    required this.companyName,
    required this.companyLogoAsset,
    required this.busType,
    required this.departureTime,
    required this.duration,
    required this.price,
    required this.currency,
    required this.cityService,
    required this.seatsLeft,
    required this.isLastSeats,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // شعار الشركة
            companyLogoAsset.isNotEmpty
                ? Image.asset(
                    companyLogoAsset,
                    width: 48,
                    height: 48,
                    fit: BoxFit.contain,
                  )
                : Icon(Icons.directions_bus, size: 48, color: Color(0xFF1E3A8A)),
            const SizedBox(width: 12),
            // التفاصيل
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        companyName,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        busType,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 18, color: Color(0xFF6366F1)),
                      const SizedBox(width: 4),
                      Text(
                        departureTime,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.timer, size: 18, color: Color(0xFF10B981)),
                      const SizedBox(width: 4),
                      Text(
                        duration,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.directions_bus, size: 18, color: Color(0xFF1E3A8A)),
                      const SizedBox(width: 4),
                      Text(
                        cityService,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        '$price $currency',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF10B981),
                        ),
                      ),
                      const Spacer(),
                      isLastSeats
                          ? Text(
                              seatsLeft,
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: onSelect,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF22C55E),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('اختر'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// صفحة رحلاتي: تعرض قائمة الرحلات المحجوزة للمستخدم
class MyTripsScreen extends StatelessWidget {
  const MyTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات تجريبية
    final trips = [
      {
        'companyName': 'SEC',
        'companyLogoAsset': '', // ضع مسار صورة إذا توفر
        'busType': '2+1',
        'departureTime': '14:00',
        'duration': 'ساعتان و 30 دقيقة',
        'price': '400',
        'currency': 'ليرة تركية',
        'cityService': 'خدمة المدينة',
        'seatsLeft': '',
        'isLastSeats': false,
      },
      {
        'companyName': 'mar-tur',
        'companyLogoAsset': '',
        'busType': '2+1',
        'departureTime': '14:30',
        'duration': '3 ساعات',
        'price': '339',
        'currency': 'ليرة تركية',
        'cityService': '',
        'seatsLeft': '',
        'isLastSeats': false,
      },
      {
        'companyName': 'Ben turizm',
        'companyLogoAsset': '',
        'busType': '2+1',
        'departureTime': '15:00',
        'duration': 'ساعتان و 30 دقيقة',
        'price': '400',
        'currency': 'ليرة تركية',
        'cityService': 'خدمة المدينة',
        'seatsLeft': 'آخر 5 مقاعد',
        'isLastSeats': true,
      },
      {
        'companyName': 'SEC',
        'companyLogoAsset': '',
        'busType': '2+1',
        'departureTime': '15:15',
        'duration': 'ساعتان و 30 دقيقة',
        'price': '400',
        'currency': 'ليرة تركية',
        'cityService': 'خدمة المدينة',
        'seatsLeft': '',
        'isLastSeats': false,
      },
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: ListView.builder(
          itemCount: trips.length,
          itemBuilder: (context, index) {
            final trip = trips[index];
            return BusTripCard(
              companyName: trip['companyName'] as String,
              companyLogoAsset: trip['companyLogoAsset'] as String,
              busType: trip['busType'] as String,
              departureTime: trip['departureTime'] as String,
              duration: trip['duration'] as String,
              price: trip['price'] as String,
              currency: trip['currency'] as String,
              cityService: trip['cityService'] as String,
              seatsLeft: trip['seatsLeft'] as String,
              isLastSeats: trip['isLastSeats'] as bool,
              onSelect: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BusSeatSelectionScreen(
                      companyName: trip['companyName'] as String,
                      busType: trip['busType'] as String,
                      departureTime: trip['departureTime'] as String,
                      duration: trip['duration'] as String,
                      price: trip['price'] as String,
                      currency: trip['currency'] as String,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
} 