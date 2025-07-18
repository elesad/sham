import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class FlightTicketScreen extends StatelessWidget {
  final Map<String, dynamic> bookingInfo;
  const FlightTicketScreen({Key? key, required this.bookingInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تذكرة الطيران'),
        centerTitle: true,
        backgroundColor: Colors.orange.shade700,
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange.shade700),
                  ),
                  const SizedBox(height: 16),
                  Divider(),
                  _ticketDetailRow('الاسم:', bookingInfo['firstName'] + ' ' + bookingInfo['lastName']),
                  _ticketDetailRow('رقم الهاتف:', bookingInfo['phone']),
                  _ticketDetailRow('البريد الإلكتروني:', bookingInfo['email']),
                  _ticketDetailRow('رقم الهوية/الجواز:', bookingInfo['idNumber']),
                  _ticketDetailRow('من:', bookingInfo['fromProvince']),
                  _ticketDetailRow('إلى:', bookingInfo['toProvince']),
                  _ticketDetailRow('تاريخ الرحلة:', '${bookingInfo['date'].day}/${bookingInfo['date'].month}/${bookingInfo['date'].year}'),
                  _ticketDetailRow('رقم الرحلة:', bookingInfo['flightNumber']),
                  _ticketDetailRow('وقت الرحلة:', bookingInfo['flightTime']),
                  _ticketDetailRow('السعر:', '${bookingInfo['price']} ل.س'),
                  _ticketDetailRow('تاريخ الميلاد:', bookingInfo['birthDate'] ?? ''),
                  _ticketDetailRow('طريقة الدفع:', bookingInfo['paymentMethod'] == 'visa' ? 'Visa' : 'الدفع عند الصعود'),
                  const SizedBox(height: 24),
                  QrImageView(
                    data: bookingInfo['flightNumber'] + bookingInfo['firstName'] + bookingInfo['lastName'],
                    version: QrVersions.auto,
                    size: 120.0,
                  ),
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
