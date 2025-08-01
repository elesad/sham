import 'package:flutter/material.dart';
import '../data/train_data.dart';
import '../models/train_models.dart';

class TrainCompanySelectionScreen extends StatelessWidget {
  const TrainCompanySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('شركات القطارات', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF127C8A),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF8FAFC),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: TrainData.companies.length,
        itemBuilder: (context, index) {
          final company = TrainData.companies[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: Text(company.logo, style: const TextStyle(fontSize: 32)),
              title: Text(company.name, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              subtitle: Row(
                children: [
                  Icon(Icons.star, color: Colors.amber[700], size: 18),
                  Text(company.rating.toString(), style: const TextStyle(fontFamily: 'Cairo')),
                  const SizedBox(width: 8),
                  Text('(${company.reviewCount})', style: const TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.grey),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('تمت إضافة ${company.name} إلى المفضلة'), 
                      backgroundColor: const Color(0xFF127C8A)
                    ),
                  );
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrainTripsScreen(company: company),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
} 

class TrainTripsScreen extends StatelessWidget {
  final TrainCompany company;
  const TrainTripsScreen({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final trips = TrainData.trips.where((t) => t.companyId == company.id).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('رحلات ${company.name}', style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF127C8A),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF8FAFC),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: trips.length,
        itemBuilder: (context, index) {
          final trip = trips[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const Icon(Icons.train, color: Color(0xFF127C8A), size: 32),
              title: Text('${trip.fromCity} → ${trip.toCity}', style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              subtitle: Text('المغادرة: ${trip.departureTime.hour.toString().padLeft(2, '0')}:${trip.departureTime.minute.toString().padLeft(2, '0')} - السعر: ${trip.price.toInt()} ل.س', style: const TextStyle(fontFamily: 'Cairo')),
              trailing: Text(trip.trainNumber, style: const TextStyle(fontFamily: 'Cairo', fontSize: 12)),
              onTap: () {
                // هنا يمكن إضافة منطق الحجز لاحقاً
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('اخترت رحلة من ${trip.fromCity} إلى ${trip.toCity}'), 
                    backgroundColor: const Color(0xFF127C8A)
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
} 
