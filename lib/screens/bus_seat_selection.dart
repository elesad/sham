import 'package:flutter/material.dart';

enum SeatStatus { empty, male, female, selected }

class BusSeatSelectionScreen extends StatefulWidget {
  final String companyName;
  final String busType;
  final String departureTime;
  final String duration;
  final String price;
  final String currency;

  const BusSeatSelectionScreen({
    super.key,
    required this.companyName,
    required this.busType,
    required this.departureTime,
    required this.duration,
    required this.price,
    required this.currency,
  });

  @override
  State<BusSeatSelectionScreen> createState() => _BusSeatSelectionScreenState();
}

class _BusSeatSelectionScreenState extends State<BusSeatSelectionScreen> {
  // مثال: 36 مقعد (2+1)
  final int rows = 9;
  final int cols = 4; // 2+1 مع ممر
  late List<List<SeatStatus?>> seatMap;
  int? selectedRow;
  int? selectedCol;

  @override
  void initState() {
    super.initState();
    // إعداد المقاعد: null = ممر، empty = فارغ، male/female = محجوز
    seatMap = List.generate(rows, (r) {
      return List.generate(cols, (c) {
        if (c == 2) return null; // ممر
        // مثال: بعض المقاعد محجوزة
        if ((r == 0 && c == 0) || (r == 1 && c == 1) || (r == 2 && c == 3)) {
          return SeatStatus.male;
        }
        if ((r == 0 && c == 3) || (r == 3 && c == 0) || (r == 4 && c == 1)) {
          return SeatStatus.female;
        }
        return SeatStatus.empty;
      });
    });
  }

  Color seatColor(SeatStatus? status) {
    switch (status) {
      case SeatStatus.empty:
        return Colors.white;
      case SeatStatus.male:
        return Colors.blue[200]!;
      case SeatStatus.female:
        return Colors.purple[200]!;
      case SeatStatus.selected:
        return Colors.green[300]!;
      default:
        return Colors.transparent;
    }
  }

  String seatLabel(int row, int col) {
    // ترقيم المقاعد (مثال)
    return ((row * 3) + (col > 1 ? col - 1 : col) + 1).toString();
  }

  void onSeatTap(int row, int col) async {
    if (seatMap[row][col] != SeatStatus.empty) return;
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('اختر نوع الراكب'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context, 'male'),
              icon: const Icon(Icons.male),
              label: const Text('رجل'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[200]),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context, 'female'),
              icon: const Icon(Icons.female),
              label: const Text('امرأة'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple[200]),
            ),
          ],
        ),
      ),
    );
    if (result == 'male' || result == 'female') {
      setState(() {
        seatMap[row][col] = result == 'male' ? SeatStatus.male : SeatStatus.female;
        selectedRow = row;
        selectedCol = col;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختيار المقعد'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // معلومات الرحلة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.companyName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(widget.busType, style: const TextStyle(fontSize: 16)),
                Text(widget.departureTime, style: const TextStyle(fontSize: 16)),
                Text('${widget.price} ${widget.currency}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 12),
            // مفتاح الألوان
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _legendBox(Colors.blue[200]!, 'ذكر - كامل'),
                _legendBox(Colors.purple[200]!, 'نساء - كامل'),
                _legendBox(Colors.white, 'مقعد فارغ'),
                _legendBox(Colors.green[300]!, 'المقعد المختار'),
              ],
            ),
            const SizedBox(height: 18),
            // مخطط المقاعد
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(rows, (row) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(cols, (col) {
                        if (seatMap[row][col] == null) {
                          return const SizedBox(width: 24, height: 36); // ممر
                        }
                        final isSelected = selectedRow == row && selectedCol == col;
                        return GestureDetector(
                          onTap: () => onSeatTap(row, col),
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: isSelected ? seatColor(SeatStatus.selected) : seatColor(seatMap[row][col]),
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                seatLabel(row, col),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text('الرجاء اختيار مقعدك', textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _legendBox(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
} 