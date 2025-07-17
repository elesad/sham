import 'package:flutter/material.dart';
import 'bus_company_selection_screen.dart';

class BusBookingScreen extends StatefulWidget {
  const BusBookingScreen({super.key});

  @override
  State<BusBookingScreen> createState() => _BusBookingScreenState();
}

class _BusBookingScreenState extends State<BusBookingScreen> {
  final List<String> provinces = const [
    'ريف دمشق', 'حمص', 'حماه', 'حلب', 'الرقة', 'ادلب', 'اللاذقية',
  ];
  String? fromProvince;
  String? toProvince;
  String selectedDay = 'اليوم';
  DateTime? selectedDate;

  void _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      locale: const Locale('ar', 'SA'),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
        selectedDay = '${date.day}/${date.month}/${date.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حجز باص', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF127C8A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF8FAFC),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            _buildDropdown('من أين', fromProvince, (val) => setState(() => fromProvince = val)),
            const SizedBox(height: 16),
            _buildDropdown('إلى أين', toProvince, (val) => setState(() => toProvince = val)),
            const SizedBox(height: 24),
            Row(
              children: [
                _buildDayChip('اليوم'),
                const SizedBox(width: 8),
                _buildDayChip('غدًا'),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.date_range, color: Color(0xFF127C8A)),
                  label: const Text('اختر التاريخ', style: TextStyle(fontFamily: 'Cairo', color: Color(0xFF127C8A))),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF127C8A)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: (fromProvince != null && toProvince != null)
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusCompanySelectionScreen(
                            fromCity: fromProvince!,
                            toCity: toProvince!,
                            date: selectedDate ?? DateTime.now(),
                          ),
                        ),
                      );
                    }
                  : null,
              icon: const Icon(Icons.search),
              label: const Text('ابحث عن رحلة', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF127C8A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18, fontFamily: 'Cairo'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const Spacer(),
            Center(
              child: Text(
                'رحلات آمنة ومريحة مع شام',
                style: TextStyle(fontFamily: 'Cairo', color: Colors.grey[500]),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String? value, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            hint: Text('اختر المحافظة', style: TextStyle(fontFamily: 'Cairo', color: Colors.grey[500])),
            items: provinces.map((p) => DropdownMenuItem(value: p, child: Text(p, style: const TextStyle(fontFamily: 'Cairo')))).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildDayChip(String day) {
    final isSelected = selectedDay == day;
    return ChoiceChip(
      label: Text(day, style: const TextStyle(fontFamily: 'Cairo')),
      selected: isSelected,
      selectedColor: const Color(0xFF127C8A),
      backgroundColor: Colors.grey[200],
      labelStyle: TextStyle(color: isSelected ? Colors.white : const Color(0xFF127C8A), fontFamily: 'Cairo'),
      onSelected: (_) {
        setState(() {
          selectedDay = day;
          if (day == 'اليوم') {
            selectedDate = DateTime.now();
          } else if (day == 'غدًا') {
            selectedDate = DateTime.now().add(const Duration(days: 1));
          }
        });
      },
    );
  }
} 