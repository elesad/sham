import 'package:flutter/material.dart';
import 'bus_booking_info_screen.dart';

enum SeatGender { male, female }

class BusSeat {
  final int row;
  final int col;
  SeatGender? gender;
  bool reserved;
  BusSeat({required this.row, required this.col, this.gender, this.reserved = false});
}

class BusSeatSelectionScreen extends StatefulWidget {
  final dynamic company;
  final String fromCity;
  final String toCity;
  final DateTime date;

  const BusSeatSelectionScreen({super.key, required this.company, required this.fromCity, required this.toCity, required this.date});

  @override
  State<BusSeatSelectionScreen> createState() => _BusSeatSelectionScreenState();
}

class _BusSeatSelectionScreenState extends State<BusSeatSelectionScreen> {
  static const int rows = 10;
  static const int cols = 4; // صفين يمين وصفين يسار
  late List<List<BusSeat>> seats;
  BusSeat? selectedSeat;

  @override
  void initState() {
    super.initState();
    seats = List.generate(rows, (row) =>
      List.generate(cols, (col) => BusSeat(row: row, col: col))
    );
    // مثال: بعض المقاعد محجوزة
    seats[2][1].reserved = true;
    seats[5][2].reserved = true;
  }

  Color _seatColor(BusSeat seat) {
    if (seat.reserved) return Colors.green;
    if (seat.gender == SeatGender.male) return Colors.blue[400]!;
    if (seat.gender == SeatGender.female) return Colors.pink[300]!;
    return Colors.grey[200]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text('اختيار المقعد - ${widget.company.name}'),
        backgroundColor: const Color(0xFF127C8A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          _legend(),
          const SizedBox(height: 10),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(rows, (row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(cols, (col) => _buildSeat(row, col)),
                    ],
                  );
                }),
              ),
            ),
          ),
          if (selectedSeat != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF127C8A),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusBookingInfoScreen(
                        companyName: widget.company.name,
                        seatNumber: '${selectedSeat!.row + 1}${String.fromCharCode(65 + selectedSeat!.col)}',
                        tripDate: '${widget.date.year}/${widget.date.month}/${widget.date.day}',
                        tripTime: widget.company.time ?? '',
                        bookingId: '', // يمكن توليده لاحقاً
                        fromCity: widget.fromCity,
                        toCity: widget.toCity,
                      ),
                    ),
                  );
                },
                child: const Text('تأكيد الحجز', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSeat(int row, int col) {
    final seat = seats[row][col];
    final isSelected = selectedSeat == seat;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          if (seat.reserved) return;
          _showGenderDialog(row, col);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: _seatColor(seat),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isSelected ? Colors.green : Colors.grey[400]!),
            boxShadow: isSelected
                ? [BoxShadow(color: Colors.green.withOpacity(0.18), blurRadius: 8, offset: const Offset(0, 2))]
                : [],
          ),
          child: seat.reserved
              ? const Icon(Icons.event_seat, color: Colors.white)
              : seat.gender == null
                  ? const Icon(Icons.event_seat, color: Color(0xFF127C8A))
                  : Icon(
                      seat.gender == SeatGender.male ? Icons.male : Icons.female,
                      color: Colors.white,
                    ),
        ),
      ),
    );
  }

  Widget _legend() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _legendItem('متاح', Colors.grey[200]!, Colors.black),
          const SizedBox(width: 10),
          _legendItem('رجل', Colors.blue[400]!, Colors.white),
          const SizedBox(width: 10),
          _legendItem('امرأة', Colors.pink[300]!, Colors.white),
          const SizedBox(width: 10),
          _legendItem('محجوز', Colors.green, Colors.white),
        ],
      ),
    );
  }

  Widget _legendItem(String label, Color color, Color textColor) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey[400]!),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: textColor)),
      ],
    );
  }

  void _showGenderDialog(int row, int col) async {
    final gender = await showDialog<SeatGender>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('اختر الجنس', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.male, color: Colors.blue, size: 36),
                  onPressed: () => Navigator.pop(context, SeatGender.male),
                ),
                const Text('رجل', style: TextStyle(fontFamily: 'Cairo')),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.female, color: Colors.pink, size: 36),
                  onPressed: () => Navigator.pop(context, SeatGender.female),
                ),
                const Text('امرأة', style: TextStyle(fontFamily: 'Cairo')),
              ],
            ),
          ],
        ),
      ),
    );
    if (gender != null) {
      setState(() {
        seats[row][col].gender = gender;
        selectedSeat = seats[row][col];
      });
    }
  }
} 
