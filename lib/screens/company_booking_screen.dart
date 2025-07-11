import 'package:flutter/material.dart';

class CompanyBookingScreen extends StatelessWidget {
  final String fromCity;
  final String toCity;
  final DateTime date;
  final String tripType; // باص، قطار، طيارة، فندق

  const CompanyBookingScreen({
    super.key,
    required this.fromCity,
    required this.toCity,
    required this.date,
    required this.tripType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حجز الرحلة'),
        backgroundColor: const Color(0xFF127C8A),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xFF10B981), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                tripType == 'باص'
                    ? Icons.directions_bus
                    : tripType == 'قطار'
                        ? Icons.train
                        : tripType == 'طيارة'
                            ? Icons.flight
                            : Icons.hotel,
                color: Color(0xFF127C8A),
                size: 48,
              ),
              const SizedBox(height: 18),
              Text(
                'حجز رحلة $tripType',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF127C8A),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'من: $fromCity',
                style: TextStyle(fontFamily: 'Cairo', fontSize: 18, color: Color(0xFF222222)),
              ),
              Text(
                'إلى: $toCity',
                style: TextStyle(fontFamily: 'Cairo', fontSize: 18, color: Color(0xFF222222)),
              ),
              const SizedBox(height: 10),
              Text(
                'التاريخ: ${date.year}/${date.month}/${date.day}',
                style: TextStyle(fontFamily: 'Cairo', fontSize: 17, color: Color(0xFF6366F1)),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                onPressed: () {
                  // TODO: تنفيذ منطق الحجز الفعلي
                },
                child: const Text('تأكيد الحجز', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 