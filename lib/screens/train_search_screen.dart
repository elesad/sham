import 'package:flutter/material.dart';
import 'train_company_selection_screen.dart';

class TrainSearchScreen extends StatefulWidget {
  const TrainSearchScreen({Key? key}) : super(key: key);

  @override
  State<TrainSearchScreen> createState() => _TrainSearchScreenState();
}

class _TrainSearchScreenState extends State<TrainSearchScreen> {
  final List<String> provinces = const [
    'ريف دمشق', 'حمص', 'حماه', 'حلب', 'الرقة', 'ادلب', 'اللاذقية',
  ];
  String? fromProvince = 'ريف دمشق';
  String? toProvince = 'حلب';
  String selectedDay = 'اليوم';
  DateTime? selectedDate = DateTime.now();
  bool isFavorite = false;

  void _swapProvinces() {
    setState(() {
      final temp = fromProvince;
      fromProvince = toProvince;
      toProvince = temp;
    });
  }

  void _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
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
        title: const Text('حجز قطار'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildDropdown('من', fromProvince, (val) => setState(() => fromProvince = val))),
                IconButton(
                  icon: const Icon(Icons.swap_horiz, size: 28, color: Colors.green),
                  onPressed: _swapProvinces,
                  tooltip: 'تبديل',
                ),
                Expanded(child: _buildDropdown('إلى', toProvince, (val) => setState(() => toProvince = val))),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _buildDayChip('اليوم'),
                const SizedBox(width: 8),
                _buildDayChip('غدًا'),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.date_range, color: Colors.green),
                  label: const Text('اختر التاريخ', style: TextStyle(fontFamily: 'Cairo', color: Colors.green)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.green),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                  onPressed: () => setState(() => isFavorite = !isFavorite),
                  tooltip: 'إضافة إلى المفضلة',
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: (fromProvince != null && toProvince != null && fromProvince != toProvince)
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrainCompanySelectionScreen(
                            fromProvince: fromProvince!,
                            toProvince: toProvince!,
                            date: selectedDate ?? DateTime.now(),
                          ),
                        ),
                      );
                    }
                  : null,
              icon: const Icon(Icons.search),
              label: const Text('ابحث عن رحلة', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18, fontFamily: 'Cairo'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const Spacer(),
            Center(
              child: Text(
                'رحلات قطار آمنة ومريحة مع شام',
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
      selectedColor: Colors.green.shade700,
      backgroundColor: Colors.grey[200],
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.green.shade700, fontFamily: 'Cairo'),
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