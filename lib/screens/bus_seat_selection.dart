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

  // أرقام المقاعد (1 إلى 40)
  List<int> seatNumbersFlat() {
    List<int> numbers = [];
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        numbers.add(row * cols + col + 1);
      }
    }
    return numbers;
  }

  @override
  Widget build(BuildContext context) {
    // بيانات الرحلة (وهمية أو من widget.company)
    final price = widget.company.price ?? 25000;
    final time = widget.company.time ?? '14:30';
    final duration = '3 ساعات';
    final companyName = widget.company.name ?? 'شركة الباص';
    final wifi = true; // خدمة واي فاي متوفرة

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text('اختيار المقعد - $companyName'),
        backgroundColor: const Color(0xFF127C8A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // وصف الرحلة
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(companyName, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 18, color: Color(0xFF127C8A)),
                            const SizedBox(width: 4),
                            Text(time, style: const TextStyle(fontFamily: 'Cairo', fontSize: 15)),
                            const SizedBox(width: 12),
                            const Icon(Icons.timer, size: 18, color: Color(0xFF127C8A)),
                            const SizedBox(width: 4),
                            Text(duration, style: const TextStyle(fontFamily: 'Cairo', fontSize: 15)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            if (wifi) ...[
                              const Icon(Icons.wifi, size: 18, color: Color(0xFF10B981)),
                              const SizedBox(width: 4),
                              const Text('واي فاي', style: TextStyle(fontFamily: 'Cairo', fontSize: 14)),
                            ],
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('$price ل.س', style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFFF59E0B))),
                        const SizedBox(height: 4),
                        const Text('السعر', style: TextStyle(fontFamily: 'Cairo', fontSize: 13, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
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
    final seatNumber = row * cols + col + 1;
    Color seatColor;
    Color numberColor;
    Widget? genderIcon;
    if (seat.reserved) {
      seatColor = Colors.green;
      numberColor = Colors.white;
      genderIcon = null;
    } else if (seat.gender == SeatGender.male) {
      seatColor = const Color(0xFF2563EB); // أزرق غامق
      numberColor = Colors.white;
      genderIcon = const Icon(Icons.male, color: Colors.white, size: 16);
    } else if (seat.gender == SeatGender.female) {
      seatColor = const Color(0xFFF472B6); // زهري غامق
      numberColor = Colors.white;
      genderIcon = const Icon(Icons.female, color: Colors.white, size: 16);
    } else {
      seatColor = const Color(0xFFF1F5F9); // رمادي فاتح
      numberColor = Colors.black;
      genderIcon = null;
    }
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
            color: seatColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isSelected ? Colors.green : Colors.grey[400]!),
            boxShadow: isSelected
                ? [BoxShadow(color: Colors.green.withOpacity(0.18), blurRadius: 8, offset: const Offset(0, 2))]
                : [],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (genderIcon != null)
                Positioned(
                  top: 4,
                  right: 4,
                  child: genderIcon,
                ),
              Center(
                child: Text(
                  '$seatNumber',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: numberColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // أسطورة الألوان والرموز
  Widget _legend() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _legendItem('فارغ', const Color(0xFFF1F5F9), Colors.black, null),
          const SizedBox(width: 12),
          _legendItem('رجل', const Color(0xFF2563EB), Colors.white, const Icon(Icons.male, color: Colors.white, size: 16)),
          const SizedBox(width: 12),
          _legendItem('امرأة', const Color(0xFFF472B6), Colors.white, const Icon(Icons.female, color: Colors.white, size: 16)),
          const SizedBox(width: 12),
          _legendItem('محجوز', Colors.green, Colors.white, null),
        ],
      ),
    );
  }

  Widget _legendItem(String label, Color color, Color textColor, Widget? icon) {
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
          child: icon != null ? Center(child: icon) : null,
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
