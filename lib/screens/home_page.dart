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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  String selectedTransport = 'bus';
  String fromLocation = '';
  String toLocation = '';
  DateTime? selectedDate;
  String selectedDateLabel = 'اليوم';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late AnimationController _transportAnimationController;
  late Animation<double> _transportScaleAnimation;

  final List<String> allProvinces = [
    'دمشق', 'ريف دمشق', 'حلب', 'حمص', 'حماة', 'اللاذقية', 'طرطوس', 'إدلب',
    'درعا', 'السويداء', 'القنيطرة', 'دير الزور', 'الحسكة', 'الرقة',
  ];
  final List<String> planeProvinces = ['دمشق', 'حلب', 'الحسكة'];
  final List<String> trainProvinces = [
    'ريف دمشق', 'حمص', 'حماة', 'حلب', 'الرقة', 'إدلب', 'اللاذقية',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _transportAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _transportScaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _transportAnimationController, curve: Curves.easeInOut),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _transportAnimationController.dispose();
    super.dispose();
  }

  void _changeTransportType(String type) {
    setState(() {
      selectedTransport = type;
      // إعادة تعيين المواقع عند تغيير نوع النقل
      fromLocation = '';
      toLocation = '';
    });
    
    // تشغيل تأثير النقر
    _transportAnimationController.forward().then((_) {
      _transportAnimationController.reverse();
    });
    
    // رسالة تأكيد
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_getTransportMessage(type)),
        backgroundColor: _getTransportColor(type),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  String _getTransportMessage(String type) {
    switch (type) {
      case 'bus':
        return 'تم اختيار النقل بالباص';
      case 'plane':
        return 'تم اختيار النقل الجوي';
      case 'train':
        return 'تم اختيار النقل بالقطار';
      case 'hotel':
        return 'تم اختيار البحث عن فندق';
      default:
        return 'تم تغيير نوع النقل';
    }
  }

  Color _getTransportColor(String type) {
    switch (type) {
      case 'bus':
        return const Color(0xFF127C8A);
      case 'plane':
        return const Color(0xFFF59E0B);
      case 'train':
        return const Color(0xFF10B981);
      case 'hotel':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF1E3A8A);
    }
  }

  void _swapLocations() {
    setState(() {
      final temp = fromLocation;
      fromLocation = toLocation;
      toLocation = temp;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('تم تبديل المواقع'),
        backgroundColor: Colors.blue[400],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 1),
      ),
    );
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
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                isFrom ? 'اختر نقطة البداية' : 'اختر الوجهة',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provinces.length,
                itemBuilder: (context, index) {
                  final province = provinces[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E3A8A).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Color(0xFF1E3A8A),
                          size: 20,
                        ),
                      ),
                      title: Text(
                        province,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          if (isFrom) {
                            fromLocation = province;
                          } else {
                            toLocation = province;
                          }
                        });
                        Navigator.pop(context);
                        
                        // رسالة تأكيد
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('تم اختيار: $province'),
                            backgroundColor: Colors.green[400],
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
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
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1E3A8A),
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedDateLabel = '${picked.day}/${picked.month}/${picked.year}';
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم اختيار التاريخ: ${picked.day}/${picked.month}/${picked.year}'),
          backgroundColor: Colors.blue[400],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 1),
        ),
      );
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('يرجى اختيار جميع الحقول'),
            backgroundColor: Colors.red[400],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('يرجى اختيار جميع الحقول'),
            backgroundColor: Colors.red[400],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('يرجى اختيار جميع الحقول'),
            backgroundColor: Colors.red[400],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Section with Gradient
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Top Bar
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.notifications_none,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const Text(
                                'مواصلات الشام',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          
                          // Welcome Text
                          const Text(
                            'أهلاً بك في مواصلات الشام',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'اختر وسيلة النقل المفضلة لديك',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Transport Options
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Transport Buttons Grid
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(child: _transportButton('bus', 'باص', Icons.directions_bus, const Color(0xFF127C8A))),
                                  const SizedBox(width: 12),
                                  Expanded(child: _transportButton('plane', 'طيران', Icons.flight, const Color(0xFFF59E0B))),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(child: _transportButton('train', 'قطار', Icons.train, const Color(0xFF10B981))),
                                  const SizedBox(width: 12),
                                  Expanded(child: _transportButton('hotel', 'فندق', Icons.hotel, const Color(0xFF8B5CF6))),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Search Form
                        if (selectedTransport != 'hotel')
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Location Fields
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => _showProvincePicker(true),
                                        child: _locationField(fromLocation.isEmpty ? 'من أين' : fromLocation, Icons.location_on, const Color(0xFF127C8A)),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1E3A8A).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: GestureDetector(
                                        onTap: _swapLocations,
                                        child: const Icon(
                                          Icons.swap_horiz,
                                          color: Color(0xFF1E3A8A),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => _showProvincePicker(false),
                                        child: _locationField(toLocation.isEmpty ? 'إلى أين' : toLocation, Icons.location_on, const Color(0xFF127C8A)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                
                                // Date Selection
                                Row(
                                  children: [
                                    _dateOption('اليوم'),
                                    const SizedBox(width: 8),
                                    _dateOption('غداً'),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: _showDatePicker,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 14),
                                          decoration: BoxDecoration(
                                            color: selectedDateLabel != 'اليوم' && selectedDateLabel != 'غداً'
                                                ? const Color(0xFF1E3A8A)
                                                : Colors.grey[100],
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: selectedDateLabel != 'اليوم' && selectedDateLabel != 'غداً'
                                                  ? const Color(0xFF1E3A8A)
                                                  : Colors.grey[300]!,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                size: 16,
                                                color: selectedDateLabel != 'اليوم' && selectedDateLabel != 'غداً'
                                                    ? Colors.white
                                                    : Colors.grey[600],
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                'تاريخ مخصص',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: selectedDateLabel != 'اليوم' && selectedDateLabel != 'غداً'
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
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Search Button
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1E3A8A).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _search,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3A8A),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.search, size: 24, color: Colors.white),
                            const SizedBox(width: 12),
                            Text(
                              selectedTransport == 'hotel' ? 'ابحث عن فندق' : 'ابحث عن رحلة',
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                inherit: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _transportButton(String type, String label, IconData icon, Color color) {
    final isSelected = selectedTransport == type;
    return GestureDetector(
      onTap: () => _changeTransportType(type),
      child: AnimatedBuilder(
        animation: _transportScaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: isSelected ? _transportScaleAnimation.value : 1.0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected ? color : Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? color : Colors.grey[200]!,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        )
                      ]
                    : [],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: isSelected ? color : color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? color : Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _locationField(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Cairo',
                color: label.contains('من أين') || label.contains('إلى أين')
                    ? Colors.grey[500]
                    : Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey[300]!,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
} 
