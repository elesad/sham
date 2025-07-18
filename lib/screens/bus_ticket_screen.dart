import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/bus_booking_info.dart';

class BusTicketScreen extends StatelessWidget {
  final BusBookingInfo bookingInfo;
  const BusTicketScreen({Key? key, required this.bookingInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تذكرة الباص'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'تذكرة الحجز',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                  ),
                  const SizedBox(height: 16),
                  Divider(),
                  _ticketDetailRow('الاسم:', bookingInfo.firstName + ' ' + bookingInfo.lastName),
                  _ticketDetailRow('رقم الهاتف:', bookingInfo.phone),
                  _ticketDetailRow('البريد الإلكتروني:', bookingInfo.email),
                  _ticketDetailRow('رقم الهوية/الجواز:', bookingInfo.idNumber),
                  _ticketDetailRow('الشركة:', bookingInfo.companyName),
                  _ticketDetailRow('رقم المقعد:', bookingInfo.seatNumber),
                  _ticketDetailRow('من:', bookingInfo.fromCity),
                  _ticketDetailRow('إلى:', bookingInfo.toCity),
                  _ticketDetailRow('تاريخ الرحلة:', bookingInfo.tripDate),
                  _ticketDetailRow('وقت الرحلة:', bookingInfo.tripTime),
                  _ticketDetailRow('رقم الحجز:', bookingInfo.bookingId),
                  _ticketDetailRow('تاريخ الميلاد:', '${bookingInfo.birthDate.year}/${bookingInfo.birthDate.month}/${bookingInfo.birthDate.day}'),
                  _ticketDetailRow('طريقة الدفع:', bookingInfo.paymentMethod == 'visa' ? 'Visa' : 'الدفع عند الصعود'),
                  const SizedBox(height: 24),
                  QrImageView(
                    data: bookingInfo.bookingId.isNotEmpty ? bookingInfo.bookingId : bookingInfo.idNumber,
                    version: QrVersions.auto,
                    size: 120.0,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('سيتم تنزيل التذكرة قريباً!')),
                          );
                        },
                        icon: const Icon(Icons.download),
                        label: const Text('تنزيل'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('تم إرسال التذكرة إلى ${bookingInfo.email}')),
                          );
                        },
                        icon: const Icon(Icons.email),
                        label: const Text('إرسال للإيميل'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('العودة إلى الصفحة الرئيسية'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                      textStyle: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _ticketDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
} 