import 'package:flutter/material.dart';
import 'bus_ticket_search_card_modern.dart';

// ويدجت رئيسية للصفحة الرئيسية: تحتوي على اسم البرنامج، زر الإشعارات، Tabs، وواجهة البحث
class HomePage extends StatefulWidget {
  final VoidCallback? onToggleDarkMode;
  final bool? isDarkMode;
  const HomePage({super.key, this.onToggleDarkMode, this.isDarkMode});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTab = 0; // 0: باص، 1: قطار، 2: طيارة، 3: فندق
  final List<String> tabs = ['باص', 'قطار', 'طيارة', 'فندق'];
  final List<Color> tabColors = [
    Color(0xFF10B981), // أخضر
    Color(0xFF6366F1), // بنفسجي
    Color(0xFFF59E42), // برتقالي
    Color(0xFF1E3A8A), // أزرق
  ];

  // بيانات المدن الافتراضية
  final List<String> cities = [
    'دمشق', 'حلب', 'حمص', 'اللاذقية', 'طرطوس', 'دير الزور', 'حماة', 'درعا', 'السويداء', 'الرقة'
  ];
  String? fromCity;
  String? toCity;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    fromCity = cities[0];
    toCity = cities[1];
    selectedDate = DateTime.now().add(Duration(days: 1));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFFECFDF5), Color(0xFFE0F2FE), Color(0xFFF8FAFC)],
          ),
        ),
        child: Column(
          children: [
            // شريط علوي مع زر الإشعارات في الزاوية
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications_none_rounded, color: Color(0xFF10B981), size: 32),
                    onPressed: () {
                      // TODO: منطق الإشعارات لاحقاً
                    },
                    tooltip: 'الإشعارات',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // اسم البرنامج بشكل جمالي وكبير في الأعلى
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    child: Text(
                      'ش͠ام͠',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 38,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF127C8A),
                        letterSpacing: 2,
                        shadows: [
                          Shadow(color: Colors.black12, blurRadius: 6, offset: Offset(1,2)),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tabs لاختيار نوع الرحلة (بشكل جمالي ومرتب)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(tabs.length, (index) {
                          final isSelected = selectedTab == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() => selectedTab = index);
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? tabColors[index].withOpacity(0.18) : Colors.transparent,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected ? tabColors[index] : Colors.transparent,
                                  width: 2.2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    index == 0
                                        ? Icons.directions_bus
                                        : index == 1
                                            ? Icons.train
                                            : index == 2
                                                ? Icons.flight
                                                : Icons.hotel,
                                    color: isSelected ? tabColors[index] : Color(0xFF6B7280),
                                    size: 24,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    tabs[index],
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: isSelected ? tabColors[index] : Color(0xFF6B7280),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  // كرت البحث العصري الجديد
                  BusTicketSearchCardModern(),
                  // يمكن إضافة عناصر أخرى للصفحة الرئيسية هنا
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 