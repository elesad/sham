import 'package:flutter/material.dart';

enum PaymentMethod { visa, onBoard }

class TicketScreen extends StatelessWidget {
  final Map<String, dynamic> bookingData;
  const TicketScreen({super.key, required this.bookingData});

  final int progressStep = 5;

  @override
  Widget build(BuildContext context) {
    final isHotel = bookingData.containsKey('hotel');
    if (isHotel) {
      final hotel = bookingData['hotel'];
      final nights = bookingData['nights'];
      final rooms = bookingData['rooms'];
      final checkInDate = bookingData['checkInDate'] as DateTime;
      final totalPrice = bookingData['totalPrice'];
      final email = bookingData['email'];
      final phone = bookingData['phone'];
      final firstName = bookingData['firstName'];
      final lastName = bookingData['lastName'];
      final idNumber = bookingData['idNumber'];
      final paymentMethod = bookingData['paymentMethod'];
      final passengerName = '$firstName $lastName';
      final ticketNumber = 'HTL${checkInDate.millisecondsSinceEpoch % 1000000}';
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
          title: const Text('تذكرتك', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF127C8A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
                _buildProgressBar(),
                const SizedBox(height: 10),
                _hotelTicketCard(
                  hotel: hotel,
                  nights: nights,
                  rooms: rooms,
                  checkInDate: checkInDate,
                  totalPrice: totalPrice,
                  passengerName: passengerName,
                  idNumber: idNumber,
                  email: email,
                  phone: phone,
                  paymentMethod: paymentMethod,
                  ticketNumber: ticketNumber,
                ),
                const SizedBox(height: 32),
                const Text('نتمنى لك إقامة سعيدة!', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF127C8A))),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF127C8A),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تمت مشاركة التذكرة!'), backgroundColor: Color(0xFF127C8A)),
                        );
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('مشاركة', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      icon: const Icon(Icons.home),
                      label: const Text('الرئيسية', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                    ),
                  ],
                  ),
                ],
              ),
            ),
        ),
      );
    } else {
      final company = bookingData['company'];
      final fromCity = bookingData['fromCity'];
      final toCity = bookingData['toCity'];
      final date = bookingData['date'] as DateTime;
      final seat = bookingData['seat'];
      final email = bookingData['email'];
      final phone = bookingData['phone'];
      final firstName = bookingData['firstName'];
      final lastName = bookingData['lastName'];
      final idNumber = bookingData['idNumber'];
      final paymentMethod = bookingData['paymentMethod'];
      final passengerName = '$firstName $lastName';
      final seatLabel = 'صف ${seat.row + 1} - عمود ${seat.col + 1}';
      final ticketNumber = 'TKT${date.millisecondsSinceEpoch % 1000000}';

      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          title: const Text('تذكرتك', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF127C8A),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildProgressBar(),
                const SizedBox(height: 10),
                _ticketCard(
                  company: company,
                  fromCity: fromCity,
                  toCity: toCity,
                  date: date,
                  seatLabel: seatLabel,
                  passengerName: passengerName,
                  idNumber: idNumber,
                  paymentMethod: paymentMethod,
                  ticketNumber: ticketNumber,
                ),
                const SizedBox(height: 32),
                const Text('نتمنى لك رحلة سعيدة!', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF127C8A))),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF127C8A),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تمت مشاركة التذكرة!'), backgroundColor: Color(0xFF127C8A)),
                        );
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('مشاركة', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      icon: const Icon(Icons.home),
                      label: const Text('الرئيسية', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                    ),
                          ],
                        ),
                      ],
                    ),
                  ),
        ),
      );
    }
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: List.generate(5, (i) {
          final isActive = i < progressStep;
          return Expanded(
            child: Container(
              height: 6,
              margin: EdgeInsets.only(left: i == 4 ? 0 : 4),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF127C8A) : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _ticketCard({
    required dynamic company,
    required String fromCity,
    required String toCity,
    required DateTime date,
    required String seatLabel,
    required String passengerName,
    required String idNumber,
    required dynamic paymentMethod,
    required String ticketNumber,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 8,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xFF127C8A).withOpacity(0.12),
                  child: Text(company.logo, style: const TextStyle(fontSize: 32)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(company.name, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF127C8A))),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF127C8A),
                        borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(ticketNumber, style: const TextStyle(fontFamily: 'Cairo', color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const Divider(height: 32, thickness: 1.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoColumn('من', fromCity),
                const Icon(Icons.arrow_forward, color: Color(0xFF127C8A)),
                _infoColumn('إلى', toCity),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoColumn('التاريخ', '${date.day}/${date.month}/${date.year}'),
                _infoColumn('المقعد', seatLabel),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoColumn('الاسم', passengerName),
                _infoColumn('الهوية', idNumber),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoColumn('الدفع', paymentMethod == PaymentMethod.visa ? 'فيزا' : 'عند الصعود'),
                // رمز QR وهمي
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.qr_code, size: 38, color: Color(0xFF127C8A)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _hotelTicketCard({
    required dynamic hotel,
    required int nights,
    required int rooms,
    required DateTime checkInDate,
    required int totalPrice,
    required String passengerName,
    required String idNumber,
    required String email,
    required String phone,
    required dynamic paymentMethod,
    required String ticketNumber,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 8,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xFF127C8A).withOpacity(0.12),
                  child: Text(hotel.image, style: const TextStyle(fontSize: 32)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(hotel.name, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF127C8A))),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF127C8A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(ticketNumber, style: const TextStyle(fontFamily: 'Cairo', color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const Divider(height: 32, thickness: 1.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoColumn('المحافظة', hotel.province),
                _infoColumn('تاريخ الدخول', '${checkInDate.day}/${checkInDate.month}/${checkInDate.year}'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoColumn('عدد الليالي', '$nights'),
                _infoColumn('عدد الغرف', '$rooms'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoColumn('الاسم', passengerName),
                _infoColumn('الهوية', idNumber),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoColumn('الإيميل', email),
                _infoColumn('الهاتف', phone),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
                _infoColumn('الدفع', paymentMethod == PaymentMethod.visa ? 'فيزا' : 'عند الوصول'),
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.qr_code, size: 38, color: Color(0xFF127C8A)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('السعر الإجمالي: $totalPrice ل.س', style: const TextStyle(fontFamily: 'Cairo', color: Color(0xFF127C8A), fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _infoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontFamily: 'Cairo', color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1F2937))),
      ],
    );
  }
} 
