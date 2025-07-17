import 'package:flutter/material.dart';
import 'bus_seat_selection.dart';

class BusCompany {
  final String id;
  final String name;
  final String logo;
  final double rating;
  final int price;
  final String time;

  BusCompany({required this.id, required this.name, required this.logo, required this.rating, required this.price, required this.time});
}

final List<BusCompany> busCompanies = [
  BusCompany(id: '1', name: 'النور', logo: '🚌', rating: 4.7, price: 25000, time: '08:00'),
  BusCompany(id: '2', name: 'البركة', logo: '🚍', rating: 4.5, price: 26000, time: '09:30'),
  BusCompany(id: '3', name: 'الهدى', logo: '🚌', rating: 4.3, price: 24000, time: '11:00'),
  BusCompany(id: '4', name: 'الشام', logo: '🚍', rating: 4.6, price: 25500, time: '12:30'),
  BusCompany(id: '5', name: 'الفرات', logo: '🚌', rating: 4.2, price: 24500, time: '14:00'),
  BusCompany(id: '6', name: 'الشرق', logo: '🚍', rating: 4.4, price: 25000, time: '15:30'),
  BusCompany(id: '7', name: 'الكوثر', logo: '🚌', rating: 4.1, price: 23500, time: '17:00'),
  BusCompany(id: '8', name: 'الريان', logo: '🚍', rating: 4.0, price: 23000, time: '18:30'),
];

class BusCompanySelectionScreen extends StatefulWidget {
  final String fromCity;
  final String toCity;
  final DateTime date;

  const BusCompanySelectionScreen({super.key, required this.fromCity, required this.toCity, required this.date});

  @override
  State<BusCompanySelectionScreen> createState() => _BusCompanySelectionScreenState();
}

class _BusCompanySelectionScreenState extends State<BusCompanySelectionScreen> {
  final Set<String> favorites = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('شركات الباصات', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF127C8A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF127C8A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('من: ${widget.fromCity}', style: const TextStyle(fontFamily: 'Cairo', color: Colors.white, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text('إلى: ${widget.toCity}', style: const TextStyle(fontFamily: 'Cairo', color: Colors.white, fontSize: 15)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${widget.date.day}/${widget.date.month}/${widget.date.year}',
                      style: const TextStyle(fontFamily: 'Cairo', color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: GridView.builder(
                itemCount: busCompanies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  final company = busCompanies[index];
                  final isFavorite = favorites.contains(company.id);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusSeatSelectionScreen(
                            company: company,
                            fromCity: widget.fromCity,
                            toCity: widget.toCity,
                            date: widget.date,
                          ),
                        ),
                      );
                    },
                    child: Container(
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
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: const Color(0xFF127C8A).withOpacity(0.12),
                                  child: Text(company.logo, style: const TextStyle(fontSize: 28)),
                                ),
                                IconButton(
                                  icon: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (isFavorite) {
                                        favorites.remove(company.id);
                                      } else {
                                        favorites.add(company.id);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(company.name, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1F2937))),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.access_time, size: 16, color: Color(0xFF127C8A)),
                                const SizedBox(width: 4),
                                Text(company.time, style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, color: Color(0xFF127C8A))),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.attach_money, size: 16, color: Color(0xFF127C8A)),
                                const SizedBox(width: 4),
                                Text('${company.price} ل.س', style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, color: Color(0xFF127C8A), fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
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