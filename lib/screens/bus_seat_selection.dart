import 'package:flutter/material.dart';
import '../models/bus_models.dart';
import 'booking_summary_screen.dart';

class BusSeatSelectionScreen extends StatefulWidget {
  final BusTrip trip;

  const BusSeatSelectionScreen({
    super.key,
    required this.trip,
  });

  @override
  State<BusSeatSelectionScreen> createState() => _BusSeatSelectionScreenState();
}

class _BusSeatSelectionScreenState extends State<BusSeatSelectionScreen> {
  List<BusSeat> selectedSeats = [];
  Map<String, SeatGender> seatGenders = {};

  void _selectSeat(BusSeat seat) {
    if (seat.status == SeatStatus.occupied) return;

    setState(() {
      if (selectedSeats.contains(seat)) {
        selectedSeats.remove(seat);
        seatGenders.remove(seat.id);
      } else {
        // التحقق من عدم وجود جنس متضارب
        bool canSelect = true;
        for (var selectedSeat in selectedSeats) {
          if (selectedSeat.rowNumber == seat.rowNumber) {
            if (seatGenders[selectedSeat.id] != null) {
              canSelect = false;
              break;
            }
          }
        }
        
        if (canSelect) {
          selectedSeats.add(seat);
          _showGenderDialog(seat);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('لا يمكن حجز مقاعد من جنسين مختلفين في نفس الصف'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    });
  }

  void _showGenderDialog(BusSeat seat) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'اختر الجنس',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.male, color: Colors.blue, size: 30),
              title: const Text('رجل', style: TextStyle(fontFamily: 'Cairo')),
              onTap: () {
                setState(() {
                  seatGenders[seat.id] = SeatGender.male;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.female, color: Colors.pink, size: 30),
              title: const Text('امرأة', style: TextStyle(fontFamily: 'Cairo')),
              onTap: () {
                setState(() {
                  seatGenders[seat.id] = SeatGender.female;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getSeatColor(BusSeat seat) {
    if (seat.status == SeatStatus.occupied) {
      return Colors.grey;
    }
    
    if (selectedSeats.contains(seat)) {
      final gender = seatGenders[seat.id];
      return gender == SeatGender.male ? Colors.blue : Colors.pink;
    }
    
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'اختيار المقاعد',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF127C8A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // معلومات الرحلة
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF127C8A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'من: ${widget.trip.fromProvince}',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'إلى: ${widget.trip.toProvince}',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'رقم الباص: ${widget.trip.busNumber}',
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'السعر: ${widget.trip.price.toInt()} ل.س',
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // دليل الألوان
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLegendItem('متاح', Colors.white, Colors.black),
                _buildLegendItem('محجوز', Colors.grey, Colors.white),
                _buildLegendItem('رجل', Colors.blue, Colors.white),
                _buildLegendItem('امرأة', Colors.pink, Colors.white),
              ],
            ),
          ),
          
          // هيكل الباص
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // السائق
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.drive_eta, color: Colors.orange, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          'السائق',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // المقاعد
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: List.generate(12, (rowIndex) {
                        final row = rowIndex + 1;
                        final seatsInRow = widget.trip.seats.where((seat) => seat.rowNumber == row).toList();
                        
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              // رقم الصف
                              Container(
                                width: 30,
                                alignment: Alignment.center,
                                child: Text(
                                  '$row',
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              
                              // المقاعد
                              Expanded(
                                child: Row(
                                  children: seatsInRow.map((seat) {
                                    return Expanded(
                                      child: GestureDetector(
                                        onTap: () => _selectSeat(seat),
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 2),
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: _getSeatColor(seat),
                                            border: Border.all(
                                              color: selectedSeats.contains(seat) 
                                                  ? Colors.black 
                                                  : Colors.grey[300]!,
                                              width: selectedSeats.contains(seat) ? 2 : 1,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${seat.seatNumber}',
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: selectedSeats.contains(seat) 
                                                    ? Colors.white 
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // زر التأكيد
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'المقاعد المختارة: ${selectedSeats.length}',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'المجموع: ${(selectedSeats.length * widget.trip.price).toInt()} ل.س',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF127C8A),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: selectedSeats.isNotEmpty ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingSummaryScreen(
                          trip: widget.trip,
                          selectedSeats: selectedSeats,
                          seatGenders: seatGenders,
                        ),
                      ),
                    );
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF127C8A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'تأكيد الحجز',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, Color textColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 10,
            color: textColor,
          ),
        ),
      ],
    );
  }
} 
