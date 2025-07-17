import 'package:flutter/material.dart';

class TrainBookingScreen extends StatefulWidget {
  const TrainBookingScreen({super.key});

  @override
  State<TrainBookingScreen> createState() => _TrainBookingScreenState();
}

class _TrainBookingScreenState extends State<TrainBookingScreen> {
  final List<String> provinces = const [
    'ريف دمشق', 'حمص', 'حماه', 'حلب', 'الرقة', 'ادلب', 'اللاذقية',
  ];
  String? fromProvince;
  String? toProvince;
  String selectedDay = 'اليوم';
  DateTime? selectedDate;
  // إضافة متغير لتحديد هل تم البحث
  bool showResult = false;

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
        title: const Text('حجز قطار', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF8B5CF6),
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
                  icon: const Icon(Icons.date_range, color: Color(0xFF8B5CF6)),
                  label: const Text('اختر التاريخ', style: TextStyle(fontFamily: 'Cairo', color: Color(0xFF8B5CF6))),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF8B5CF6)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: (fromProvince != null && toProvince != null)
                  ? () {
                      setState(() {
                        showResult = true;
                      });
                    }
                  : null,
              icon: const Icon(Icons.search),
              label: const Text('ابحث عن رحلة', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18, fontFamily: 'Cairo'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            if (showResult)
              Container(
                margin: const EdgeInsets.only(top: 32),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Icon(Icons.train, color: Color(0xFF8B5CF6), size: 32),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('رحلة قطار واحدة', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 17, color: Color(0xFF1F2937))),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text('08:00 صباحاً', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey[600])),
                              const SizedBox(width: 16),
                              Icon(Icons.attach_money, size: 16, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text('25000 ل.س', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Color(0xFF8B5CF6), fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const Spacer(),
            Center(
              child: Text(
                'سفر آمن ومريح مع قطارات شام',
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
      selectedColor: const Color(0xFF8B5CF6),
      backgroundColor: Colors.grey[200],
      labelStyle: TextStyle(color: isSelected ? Colors.white : const Color(0xFF8B5CF6), fontFamily: 'Cairo'),
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