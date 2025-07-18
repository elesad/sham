import 'package:flutter/material.dart';
import 'hotel_selection_screen.dart';
import 'bus_company_selection_screen.dart';
import 'flight_company_selection_screen.dart';
import 'train_company_selection_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedTransport = 'bus';
  String fromLocation = '';
  String toLocation = '';
  DateTime? selectedDate;
  String selectedDateLabel = 'اليوم';

  final List<String> allProvinces = [
    'دمشق', 'ريف دمشق', 'حلب', 'حمص', 'حماة', 'اللاذقية', 'طرطوس', 'إدلب',
    'درعا', 'السويداء', 'القنيطرة', 'دير الزور', 'الحسكة', 'الرقة',
  ];
  final List<String> planeProvinces = ['دمشق', 'حلب', 'الحسكة'];
  final List<String> trainProvinces = [
    'ريف دمشق', 'حمص', 'حماة', 'حلب', 'الرقة', 'إدلب', 'اللاذقية',
  ];

  void _swapLocations() {
    setState(() {
      final temp = fromLocation;
      fromLocation = toLocation;
      toLocation = temp;
    });
  }

  void _showProvincePicker(bool isFrom) {
    List<String> provinces = allProvinces;
    if (selectedTransport == 'plane') provinces = planeProvinces;
    if (selectedTransport == 'train') provinces = trainProvinces;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                isFrom ? 'اختر نقطة البداية' : 'اختر الوجهة',
                style: const TextStyle(
                  fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provinces.length,
                itemBuilder: (context, index) {
                  final province = provinces[index];
                  return ListTile(
                    title: Text(province, style: const TextStyle(fontFamily: 'Cairo')),
                    onTap: () {
                      setState(() {
                        if (isFrom) {
                          fromLocation = province;
                        } else {
                          toLocation = province;
                        }
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      locale: const Locale('ar', 'SA'),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedDateLabel = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  void _search() {
    if (selectedTransport == 'hotel') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HotelSelectionScreen(),
        ),
      );
      return;
    }
    if (selectedTransport == 'bus') {
      if (fromLocation.isEmpty || toLocation.isEmpty || selectedDateLabel.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يرجى اختيار جميع الحقول')));
        return;
      }
      DateTime date = selectedDate ?? DateTime.now();
      if (selectedDateLabel == 'اليوم') {
        date = DateTime.now();
      } else if (selectedDateLabel == 'غداً') {
        date = DateTime.now().add(const Duration(days: 1));
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BusCompanySelectionScreen(
            fromCity: fromLocation,
            toCity: toLocation,
            date: date,
          ),
        ),
      );
      return;
    }
    if (selectedTransport == 'plane') {
      if (fromLocation.isEmpty || toLocation.isEmpty || selectedDateLabel.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يرجى اختيار جميع الحقول')));
        return;
      }
      DateTime date = selectedDate ?? DateTime.now();
      if (selectedDateLabel == 'اليوم') {
        date = DateTime.now();
      } else if (selectedDateLabel == 'غداً') {
        date = DateTime.now().add(const Duration(days: 1));
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FlightCompanySelectionScreen(
            fromProvince: fromLocation,
            toProvince: toLocation,
            date: date,
          ),
        ),
      );
      return;
    }
    if (selectedTransport == 'train') {
      if (fromLocation.isEmpty || toLocation.isEmpty || selectedDateLabel.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يرجى اختيار جميع الحقول')));
        return;
      }
      DateTime date = selectedDate ?? DateTime.now();
      if (selectedDateLabel == 'اليوم') {
        date = DateTime.now();
      } else if (selectedDateLabel == 'غداً') {
        date = DateTime.now().add(const Duration(days: 1));
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrainCompanySelectionScreen(
            fromProvince: fromLocation,
            toProvince: toLocation,
            date: date,
          ),
        ),
      );
      return;
    }
    // باقي التدفقات (الطيارة، القطار) تضاف هنا
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // شريط علوي: زر إشعارات واسم البرنامج
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none, color: Color(0xFF127C8A), size: 30),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('الإشعارات')),
                      );
                    },
                  ),
                  const Text(
                    'شام',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Color(0xFF127C8A),
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            // أزرار الخدمات الأربعة بشكل أفقي
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _transportButton('bus', 'باص', Icons.directions_bus, const Color(0xFF127C8A)),
                  _transportButton('plane', 'طيارة', Icons.flight, const Color(0xFFF59E0B)),
                  _transportButton('train', 'قطار', Icons.train, const Color(0xFF10B981)),
                  _transportButton('hotel', 'فندق', Icons.hotel, const Color(0xFF8B5CF6)),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // حقول الإدخال حسب نوع الخدمة
            if (selectedTransport != 'hotel')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _showProvincePicker(true),
                            child: _locationField(fromLocation.isEmpty ? 'من أين' : fromLocation, Icons.location_on),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.swap_horiz, color: Color(0xFF127C8A)),
                          onPressed: _swapLocations,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _showProvincePicker(false),
                            child: _locationField(toLocation.isEmpty ? 'إلى أين' : toLocation, Icons.location_on),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        _dateOption('اليوم'),
                        const SizedBox(width: 10),
                        _dateOption('غداً'),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: _showDatePicker,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: selectedDateLabel != 'اليوم' && selectedDateLabel != 'غداً'
                                    ? const Color(0xFF127C8A)
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: selectedDateLabel != 'اليوم' && selectedDateLabel != 'غداً'
                                      ? const Color(0xFF127C8A)
                                      : Colors.grey[300]!,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.calendar_today, size: 16, color: selectedDateLabel != 'اليوم' && selectedDateLabel != 'غداً' ? Colors.white : Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                    'تاريخ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: selectedDateLabel != 'اليوم' && selectedDateLabel != 'غداً' ? Colors.white : Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: ElevatedButton(
                onPressed: _search,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF127C8A),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  elevation: 3,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.search, size: 22),
                    const SizedBox(width: 10),
                    Text(
                      selectedTransport == 'hotel' ? 'ابحث عن فندق' : 'ابحث عن رحلة',
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _transportButton(String type, String label, IconData icon, Color color) {
    final isSelected = selectedTransport == type;
    return GestureDetector(
      onTap: () => setState(() => selectedTransport = type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? color : Colors.grey[300]!),
          boxShadow: isSelected
              ? [BoxShadow(color: color.withOpacity(0.13), blurRadius: 10, offset: const Offset(0, 2))]
              : [],
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.white : color, size: 26),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _locationField(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF127C8A)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Cairo',
                color: label.contains('من أين') || label.contains('إلى أين') ? Colors.grey[500] : Colors.black,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateOption(String label) {
    final isSelected = selectedDateLabel == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedDateLabel = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF127C8A) : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? const Color(0xFF127C8A) : Colors.grey[300]!),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
} 
