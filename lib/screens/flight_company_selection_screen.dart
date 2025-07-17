import 'package:flutter/material.dart';
import 'flight_booking_info_screen.dart';

class FlightCompanySelectionScreen extends StatefulWidget {
  final String fromProvince;
  final String toProvince;
  final DateTime date;
  const FlightCompanySelectionScreen({Key? key, required this.fromProvince, required this.toProvince, required this.date}) : super(key: key);

  @override
  State<FlightCompanySelectionScreen> createState() => _FlightCompanySelectionScreenState();
}

class _FlightCompanySelectionScreenState extends State<FlightCompanySelectionScreen> {
  bool isFavorite = false;

  final List<Map<String, dynamic>> flights = [
    {
      'time': '10:00 صباحًا',
      'price': 250000,
      'logo': '🛩️',
      'flightNumber': 'SH101',
    },
    {
      'time': '6:00 مساءً',
      'price': 250000,
      'logo': '🛩️',
      'flightNumber': 'SH102',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نتائج الرحلات'),
        centerTitle: true,
        backgroundColor: Colors.orange.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: Color(0xFFFFF3E0),
                      child: Text('🛩️', style: TextStyle(fontSize: 32)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('أجنحة الشام', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 20, color: Colors.orange)),
                          SizedBox(height: 4),
                          Text('شركة الطيران السورية', style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                      onPressed: () => setState(() => isFavorite = !isFavorite),
                      tooltip: 'إضافة إلى المفضلة',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                itemCount: flights.length,
                separatorBuilder: (_, __) => const SizedBox(height: 18),
                itemBuilder: (context, index) {
                  final flight = flights[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange.shade100,
                        child: Text(flight['logo'], style: const TextStyle(fontSize: 22)),
                      ),
                      title: Text('رحلة رقم ${flight['flightNumber']}', style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الوقت: ${flight['time']}', style: const TextStyle(fontFamily: 'Cairo')),
                          Text('السعر: ${flight['price']} ل.س', style: const TextStyle(fontFamily: 'Cairo')),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                        onPressed: () => setState(() => isFavorite = !isFavorite),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FlightBookingInfoScreen(
                              fromProvince: widget.fromProvince,
                              toProvince: widget.toProvince,
                              date: widget.date,
                              flightNumber: flight['flightNumber'],
                              flightTime: flight['time'],
                              price: flight['price'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
