import 'package:flutter/material.dart';
import 'company_booking_screen.dart';

/// كرت بحث عن تذكرة حافلة بتصميم عصري وألوان مميزة
class BusTicketSearchCardModern extends StatefulWidget {
  const BusTicketSearchCardModern({super.key});

  @override
  State<BusTicketSearchCardModern> createState() => _BusTicketSearchCardModernState();
}

class _BusTicketSearchCardModernState extends State<BusTicketSearchCardModern> {
  final List<String> cities = [
    'دمشق', 'حلب', 'حمص', 'اللاذقية', 'طرطوس', 'دير الزور', 'حماة', 'درعا', 'السويداء', 'الرقة'
  ];
  String? fromCity;
  String? toCity;
  int selectedDay = 0; // 0: اليوم، 1: غدًا، 2: من التقويم
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    fromCity = cities[0];
    toCity = cities[1];
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 370,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: const Color(0xFFECFDF5), // خلفية فاتحة عصرية
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // العنوان
            const SizedBox(height: 28),
            // اختيار المدن مع زر تبديل أخضر
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  // من
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: fromCity,
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(12),
                        dropdownColor: Colors.white,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        items: cities.map((city) => DropdownMenuItem(value: city, child: Text(city))).toList(),
                        onChanged: (val) {
                          setState(() => fromCity = val);
                        },
                      ),
                    ),
                  ),
                  // زر تبديل المدن (أخضر)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Material(
                      color: const Color(0xFF10B981),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          setState(() {
                            final temp = fromCity;
                            fromCity = toCity;
                            toCity = temp;
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.swap_horiz, color: Colors.white, size: 28),
                        ),
                      ),
                    ),
                  ),
                  // إلى
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: toCity,
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(12),
                        dropdownColor: Colors.white,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        items: cities.where((city) => city != fromCity).map((city) => DropdownMenuItem(value: city, child: Text(city))).toList(),
                        onChanged: (val) {
                          setState(() => toCity = val);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // التاريخ
            Text(
              'التاريخ:',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            // أزرار اليوم/غدًا/التقويم
            Row(
              children: [
                // اليوم
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedDay == 0 ? Color(0xFFE11D48) : Color(0xFFF9A8D4),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedDay = 0;
                        selectedDate = DateTime.now();
                      });
                    },
                    child: const Text('اليوم', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 10),
                // غدًا
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedDay == 1 ? Color(0xFFE11D48) : Color(0xFFF9A8D4),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedDay = 1;
                        selectedDate = DateTime.now().add(Duration(days: 1));
                      });
                    },
                    child: const Text('غدًا', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // زر اختيار من التقويم
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedDay == 2 ? Color(0xFF4ADE80) : Color(0xFFECFDF5),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.calendar_month),
              label: const Text('اختر من التقويم', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  locale: const Locale('ar'),
                );
                if (picked != null) {
                  setState(() {
                    selectedDay = 2;
                    selectedDate = picked;
                  });
                }
              },
            ),
            const SizedBox(height: 18),
            // زر البحث
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF7C2D), // برتقالي مميز
                side: BorderSide(color: Color(0xFF4ADE80), width: 2), // إطار أخضر فاتح
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                padding: EdgeInsets.symmetric(vertical: 18),
              ),
              onPressed: () {
                if (fromCity != null && toCity != null && selectedDate != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CompanyBookingScreen(
                        fromCity: fromCity!,
                        toCity: toCity!,
                        date: selectedDate!,
                        tripType: _getTripType(),
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                'ابحث عن رحلة',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة مساعدة لإرجاع نوع الرحلة كنص
  String _getTripType() {
    switch (selectedDay) {
      case 0:
      case 1:
      case 2:
        // في هذا السياق، نوع الرحلة يحدد من التاب المختار في الصفحة الرئيسية
        // سنحاول جلبه من الأعلى إذا أمكن
        // إذا لم يكن متاحاً، نعيد "باص" افتراضياً
        return 'باص';
      default:
        return 'باص';
    }
  }
} 