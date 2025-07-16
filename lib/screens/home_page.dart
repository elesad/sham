import 'package:flutter/material.dart';
import '../data/bus_data.dart';
import '../models/bus_models.dart';
import 'bus_company_selection_screen.dart';
import 'flight_search_screen.dart';
import 'hotel_selection_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedTransport = 'bus';
  String fromLocation = '';
  String toLocation = '';
  String selectedDate = 'اليوم';
  DateTime? selectedDateTime;
  
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  
  // قوائم المحافظات
  List<Province> provinces = BusData.provinces;

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      locale: const Locale('ar', 'SA'),
    ).then((date) {
      if (date != null) {
        setState(() {
          selectedDateTime = date;
          selectedDate = '${date.day}/${date.month}/${date.year}';
        });
      }
    });
  }

  void _showProvincePicker(BuildContext context, bool isFrom) {
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
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provinces.length,
                itemBuilder: (context, index) {
                  final province = provinces[index];
                  return ListTile(
                    title: Text(
                      province.name,
                      style: const TextStyle(fontFamily: 'Cairo'),
                    ),
                    onTap: () {
                      setState(() {
                        if (isFrom) {
                          fromLocation = province.name;
                        } else {
                          toLocation = province.name;
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

  void _searchTrip() {
    if (selectedTransport == 'hotel') {
      // الانتقال إلى صفحة الفنادق
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HotelSelectionScreen(),
        ),
      );
      return;
    }
    
    if (fromLocation.isEmpty || toLocation.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إدخال نقطة البداية والوجهة'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    if (selectedTransport == 'bus') {
      // الانتقال إلى صفحة شركات الباصات
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BusCompanySelectionScreen(
            fromProvince: fromLocation,
            toProvince: toLocation,
            date: selectedDateTime ?? DateTime.now(),
          ),
        ),
      );
    } else if (selectedTransport == 'plane') {
      // الانتقال إلى صفحة اختيار المدن والتاريخ للطائرات
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FlightSearchScreen(),
        ),
      );
    } else if (selectedTransport == 'train') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('خدمة القطارات قيد التطوير'),
          backgroundColor: Color(0xFF127C8A),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // الشريط العلوي مع الإشعارات
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFF127C8A),
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'شام',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF127C8A),
                          ),
                        ),
                        Text(
                          'حجز تذاكر السفر',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('الإشعارات')),
                          );
                        },
                        icon: const Icon(Icons.notifications_outlined, size: 28),
                        color: const Color(0xFF127C8A),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // المحتوى الرئيسي
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    
                    // خيارات النقل
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTransportOption(
                                  'bus',
                                  'الباص',
                                  Icons.directions_bus,
                                  const Color(0xFF127C8A),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildTransportOption(
                                  'train',
                                  'القطار',
                                  Icons.train,
                                  const Color(0xFF10B981),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildTransportOption(
                                  'plane',
                                  'الطائرة',
                                  Icons.flight,
                                  const Color(0xFFF59E0B),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildTransportOption(
                                  'hotel',
                                  'الفنادق',
                                  Icons.hotel,
                                  const Color(0xFF8B5CF6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // من أين إلى أين
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () => _showProvincePicker(context, true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[50],
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on, color: Color(0xFF127C8A)),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      fromLocation.isEmpty ? 'من أين' : fromLocation,
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        color: fromLocation.isEmpty ? Colors.grey[500] : Colors.black,
                                      ),
                                    ),
                                  ),
                                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () => _showProvincePicker(context, false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[50],
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on, color: Color(0xFF10B981)),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      toLocation.isEmpty ? 'إلى أين' : toLocation,
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        color: toLocation.isEmpty ? Colors.grey[500] : Colors.black,
                                      ),
                                    ),
                                  ),
                                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // اختيار التاريخ
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'اختر التاريخ',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDateOption('اليوم', 'اليوم'),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildDateOption('غداً', 'غداً'),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: GestureDetector(
                                  onTap: _showDatePicker,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                      color: selectedDate != 'اليوم' && selectedDate != 'غداً' 
                                          ? const Color(0xFF127C8A) 
                                          : Colors.grey[100],
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: selectedDate != 'اليوم' && selectedDate != 'غداً' 
                                            ? const Color(0xFF127C8A) 
                                            : Colors.grey[300]!,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: 16,
                                          color: selectedDate != 'اليوم' && selectedDate != 'غداً' 
                                              ? Colors.white 
                                              : Colors.grey[600],
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'تاريخ',
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: selectedDate != 'اليوم' && selectedDate != 'غداً' 
                                                ? Colors.white 
                                                : Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (selectedDate != 'اليوم' && selectedDate != 'غداً') ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF127C8A).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today, color: Color(0xFF127C8A), size: 16),
                                  const SizedBox(width: 8),
                                  Text(
                                    'التاريخ المختار: $selectedDate',
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12,
                                      color: Color(0xFF127C8A),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // زر البحث
                    ElevatedButton(
                      onPressed: _searchTrip,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF127C8A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.search, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'ابحث عن رحلة',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransportOption(String type, String title, IconData icon, Color color) {
    final isSelected = selectedTransport == type;
    return GestureDetector(
      onTap: () => setState(() => selectedTransport = type),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? Colors.white : color,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateOption(String date, String title) {
    final isSelected = selectedDate == date;
    return GestureDetector(
      onTap: () => setState(() => selectedDate = date),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF127C8A) : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF127C8A) : Colors.grey[300]!,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
} 
