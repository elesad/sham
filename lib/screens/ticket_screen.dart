import 'package:flutter/material.dart';
import '../models/bus_models.dart';

class TicketScreen extends StatelessWidget {
  final BusTrip trip;
  final List<BusSeat> selectedSeats;
  final Map<String, SeatGender> seatGenders;
  final String passengerName;
  final String passengerEmail;
  final String passengerPhone;
  final String passengerId;
  final String paymentMethod;

  const TicketScreen({
    super.key,
    required this.trip,
    required this.selectedSeats,
    required this.seatGenders,
    required this.passengerName,
    required this.passengerEmail,
    required this.passengerPhone,
    required this.passengerId,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    final totalPrice = selectedSeats.length * trip.price;
    final ticketNumber = 'TKT-${DateTime.now().millisecondsSinceEpoch}';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'التذكرة',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF127C8A),
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // رسالة النجاح
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF10B981), Color(0xFF059669)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 60,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'تم الحجز بنجاح!',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'رقم التذكرة: $ticketNumber',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // التذكرة الرئيسية
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // رأس التذكرة
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF127C8A), Color(0xFF0F5F6B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'من',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  trip.fromProvince,
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'إلى',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  trip.toProvince,
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildTicketInfo('التاريخ', '${trip.departureTime.day}/${trip.departureTime.month}/${trip.departureTime.year}'),
                            _buildTicketInfo('الوقت', '${trip.departureTime.hour.toString().padLeft(2, '0')}:${trip.departureTime.minute.toString().padLeft(2, '0')}'),
                            _buildTicketInfo('رقم الباص', trip.busNumber),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // تفاصيل التذكرة
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // معلومات المسافر
                        _buildDetailSection(
                          'معلومات المسافر',
                          [
                            _buildDetailRow('الاسم', passengerName),
                            _buildDetailRow('البريد الإلكتروني', passengerEmail),
                            _buildDetailRow('رقم الهاتف', passengerPhone),
                            _buildDetailRow('رقم الهوية', passengerId),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // المقاعد المختارة
                        _buildDetailSection(
                          'المقاعد المختارة',
                          selectedSeats.map((seat) {
                            final gender = seatGenders[seat.id];
                            final genderText = gender == SeatGender.male ? 'رجل' : 'امرأة';
                            return _buildDetailRow(
                              'مقعد ${seat.rowNumber}-${seat.seatNumber}',
                              genderText,
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),

                        // معلومات الدفع
                        _buildDetailSection(
                          'معلومات الدفع',
                          [
                            _buildDetailRow('طريقة الدفع', paymentMethod == 'card' ? 'فيزا / ماستركارد' : 'الدفع عند الصعود'),
                            _buildDetailRow('السعر الإجمالي', '${totalPrice.toInt()} ل.س'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // أزرار الإجراءات
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // مشاركة التذكرة
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم مشاركة التذكرة')),
                      );
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('مشاركة', style: TextStyle(fontFamily: 'Cairo')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // العودة للصفحة الرئيسية
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('الرئيسية', style: TextStyle(fontFamily: 'Cairo')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF127C8A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketInfo(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Cairo',
            color: Colors.white70,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Cairo',
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF127C8A),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
} 
