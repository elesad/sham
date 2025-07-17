import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';

class HotelTicketScreen extends StatelessWidget {
  final Map<String, dynamic> bookingData;
  const HotelTicketScreen({Key? key, required this.bookingData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hotelName = bookingData['hotelName'] ?? '';
    final hotelImage = bookingData['hotelImage'] ?? '';
    final location = bookingData['location'] ?? '';
    final rating = bookingData['rating']?.toString() ?? '';
    final price = bookingData['price']?.toString() ?? '';
    final checkInDate = bookingData['checkInDate'] as DateTime?;
    final checkOutDate = bookingData['checkOutDate'] as DateTime?;
    final rooms = bookingData['rooms']?.toString() ?? '';
    final guests = bookingData['guests']?.toString() ?? '';
    final name = bookingData['name'] ?? '';
    final email = bookingData['email'] ?? '';
    final phone = bookingData['phone'] ?? '';
    final id = bookingData['id'] ?? '';
    final birthDate = bookingData['birthDate'] as DateTime?;
    final bookingId = bookingData['bookingId'] ?? 'SHM${DateTime.now().millisecondsSinceEpoch}';
    final nights = checkInDate != null && checkOutDate != null ? checkOutDate.difference(checkInDate).inDays : 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('تذكرة الفندق'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: hotelImage.isNotEmpty
                        ? Image.network(hotelImage, height: 100, width: 100, fit: BoxFit.cover)
                        : const Icon(Icons.hotel, size: 80),
                  ),
                  const SizedBox(height: 12),
                  Text(hotelName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, size: 18, color: Colors.grey[700]),
                      Text(location, style: TextStyle(color: Colors.grey[700])),
                      const SizedBox(width: 12),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Text(rating, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Divider(height: 32, thickness: 1.2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الدخول:', style: TextStyle(color: Colors.grey[700])),
                          Text(checkInDate != null ? DateFormat('yyyy/MM/dd').format(checkInDate) : ''),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الخروج:', style: TextStyle(color: Colors.grey[700])),
                          Text(checkOutDate != null ? DateFormat('yyyy/MM/dd').format(checkOutDate) : ''),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('عدد الليالي:', style: TextStyle(color: Colors.grey[700])),
                          Text('$nights'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الغرف:', style: TextStyle(color: Colors.grey[700])),
                          Text(rooms),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الأشخاص:', style: TextStyle(color: Colors.grey[700])),
                          Text(guests),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('السعر:', style: TextStyle(color: Colors.grey[700])),
                          Text('$price ل.س'),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 32, thickness: 1.2),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 18),
                      const SizedBox(width: 4),
                      Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.email, size: 18),
                      const SizedBox(width: 4),
                      Text(email),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 18),
                      const SizedBox(width: 4),
                      Text(phone),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.badge, size: 18),
                      const SizedBox(width: 4),
                      Text(id),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.cake, size: 18),
                      const SizedBox(width: 4),
                      Text(birthDate != null ? DateFormat('yyyy/MM/dd').format(birthDate) : ''),
                    ],
                  ),
                  const Divider(height: 32, thickness: 1.2),
                  QrImageView(
                    data: bookingId,
                    version: QrVersions.auto,
                    size: 120,
                  ),
                  const SizedBox(height: 8),
                  Text('رقم الحجز: $bookingId', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // TODO: تحميل التذكرة كصورة
                        },
                        icon: const Icon(Icons.download),
                        label: const Text('تحميل'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // TODO: إرسال التذكرة بالبريد
                        },
                        icon: const Icon(Icons.email),
                        label: const Text('إرسال'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 
