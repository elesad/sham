import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const ShamApp());
}

class ShamApp extends StatefulWidget {
  const ShamApp({Key? key}) : super(key: key);

  @override
  State<ShamApp> createState() => _ShamAppState();
}

class _ShamAppState extends State<ShamApp> {
  Locale _locale = const Locale('ar');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'مواصلات الشام',
      locale: _locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        fontFamily: 'Cairo',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E3A8A),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E3A8A),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF1E3A8A), width: 2),
          ),
          labelStyle: const TextStyle(
            fontFamily: 'Cairo',
            color: Color(0xFF6B7280),
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
      home: SearchScreen(onLocaleChange: setLocale),
    );
  }
}

class SearchScreen extends StatefulWidget {
  final void Function(Locale) onLocaleChange;
  const SearchScreen({Key? key, required this.onLocaleChange}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> cities = [
    'دمشق', 'ريف دمشق', 'حلب', 'حمص', 'حماة', 'اللاذقية', 'طرطوس', 'دير الزور', 'الرقة', 'الحسكة', 'درعا', 'السويداء', 'إدلب', 'القنيطرة'
  ];
  String? fromCity;
  String? toCity;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);
    return Directionality(
      textDirection: currentLocale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.directions_bus, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Text(AppLocalizations.of(context)?.appTitle ?? 'مواصلات الشام'),
            ],
          ),
          actions: [
            _buildActionButton(
              icon: Icons.favorite_border,
              tooltip: 'المفضلة',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('قائمة المفضلة (قريباً)'),
                    backgroundColor: const Color(0xFF1E3A8A),
                  ),
                );
              },
            ),
            _buildActionButton(
              icon: Icons.notifications_none,
              tooltip: 'التنبيهات',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('قائمة التنبيهات (قريباً)'),
                    backgroundColor: const Color(0xFF1E3A8A),
                  ),
                );
              },
            ),
            _buildActionButton(
              icon: Icons.confirmation_number,
              tooltip: 'تذاكري',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const TicketsScreen()),
                );
              },
            ),
            PopupMenuButton<Locale>(
              icon: const Icon(Icons.language, color: Colors.white),
              onSelected: widget.onLocaleChange,
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: const Locale('ar'),
                  child: const Text('العربية'),
                ),
                PopupMenuItem(
                  value: const Locale('tr'),
                  child: const Text('Türkçe'),
                ),
                PopupMenuItem(
                  value: const Locale('en'),
                  child: const Text('English'),
                ),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Section
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E3A8A).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'ابحث عن رحلتك',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'اختر وجهتك وابحث عن أفضل الرحلات',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                          fontFamily: 'Cairo',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Search Form
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // From City
                      _buildSearchField(
                        label: 'من أين',
                        icon: Icons.location_on_outlined,
                        value: fromCity,
                        items: cities,
                        onChanged: (value) {
                          setState(() {
                            fromCity = value;
                          });
                        },
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // To City
                      _buildSearchField(
                        label: 'إلى أين',
                        icon: Icons.location_on,
                        value: toCity,
                        items: cities,
                        onChanged: (value) {
                          setState(() {
                            toCity = value;
                          });
                        },
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Date Selection
                      InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                            locale: const Locale('ar'),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color(0xFF1E3A8A),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (date != null) {
                            setState(() {
                              selectedDate = date;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: Color(0xFF6B7280),
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  selectedDate == null
                                      ? 'اختر التاريخ'
                                      : '${selectedDate!.year}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.day.toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    color: selectedDate == null ? const Color(0xFF6B7280) : Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Search Button
                      ElevatedButton(
                        onPressed: (fromCity != null && toCity != null && selectedDate != null)
                            ? () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ResultsScreen(
                                      from: fromCity!,
                                      to: toCity!,
                                      date: selectedDate!,
                                    ),
                                  ),
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (fromCity != null && toCity != null && selectedDate != null)
                              ? const Color(0xFF1E3A8A)
                              : const Color(0xFFE5E7EB),
                          foregroundColor: (fromCity != null && toCity != null && selectedDate != null)
                              ? Colors.white
                              : const Color(0xFF9CA3AF),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.search),
                            const SizedBox(width: 8),
                            Text(
                              AppLocalizations.of(context)?.showBusLine ?? 'بحث عن الرحلات',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Quick Actions
                Text(
                  'خدمات سريعة',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F2937),
                    fontFamily: 'Cairo',
                  ),
                ),
                
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildQuickActionCard(
                        icon: Icons.history,
                        title: 'آخر الرحلات',
                        subtitle: 'عرض الرحلات الأخيرة',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('آخر الرحلات (قريباً)'),
                              backgroundColor: const Color(0xFF1E3A8A),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildQuickActionCard(
                        icon: Icons.star,
                        title: 'المفضلة',
                        subtitle: 'الوجهات المفضلة',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('المفضلة (قريباً)'),
                              backgroundColor: const Color(0xFF1E3A8A),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        tooltip: tooltip,
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF6B7280)),
      ),
      value: value,
      items: items.map((city) => DropdownMenuItem(
        value: city,
        child: Text(
          city,
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
      )).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF1E3A8A),
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
                fontFamily: 'Cairo',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class TripResult {
  final String company;
  final String time;
  final double price;
  TripResult({required this.company, required this.time, required this.price});
}

class ResultsScreen extends StatelessWidget {
  final String from;
  final String to;
  final DateTime date;
  const ResultsScreen({Key? key, required this.from, required this.to, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trips = [
      TripResult(company: 'شركة الشام', time: '08:00', price: 15000),
      TripResult(company: 'شركة الاتحاد', time: '10:30', price: 17000),
      TripResult(company: 'شركة النور', time: '13:00', price: 16000),
      TripResult(company: 'شركة السلام', time: '15:30', price: 14500),
      TripResult(company: 'شركة الأمانة', time: '18:00', price: 15500),
    ];
    final locale = Localizations.localeOf(context);
    return Directionality(
      textDirection: locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.directions_bus, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Text(AppLocalizations.of(context)?.appTitle ?? 'مواصلات الشام'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Trip Summary Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E3A8A).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildTripInfo(
                              icon: Icons.location_on_outlined,
                              label: 'من',
                              value: from,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          Expanded(
                            child: _buildTripInfo(
                              icon: Icons.location_on,
                              label: 'إلى',
                              value: to,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Results Count
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3A8A).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Color(0xFF1E3A8A),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${trips.length} رحلة متاحة',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Trips List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: trips.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final trip = trips[index];
                    return _buildTripCard(context, trip, index);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTripInfo({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontFamily: 'Cairo',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTripCard(BuildContext context, TripResult trip, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Company Info
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E3A8A).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.directions_bus,
                          color: Color(0xFF1E3A8A),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          trip.company,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Color(0xFF6B7280),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        trip.time,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Price
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${trip.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const Text(
                    'ل.س',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Book Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => TripDetailsScreen(
                      trip: trip,
                      from: from,
                      to: to,
                      date: date,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'حجز',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TripDetailsScreen extends StatelessWidget {
  final TripResult trip;
  final String from;
  final String to;
  final DateTime date;
  const TripDetailsScreen({Key? key, required this.trip, required this.from, required this.to, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return Directionality(
      textDirection: locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.directions_bus, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Text(AppLocalizations.of(context)?.busLineTitle ?? 'تفاصيل الرحلة'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Trip Header Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E3A8A).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.directions_bus,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        trip.company,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'رحلة مريحة وآمنة',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Trip Details Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'تفاصيل الرحلة',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1F2937),
                          fontFamily: 'Cairo',
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Route Info
                      _buildDetailRow(
                        icon: Icons.route,
                        label: 'المسار',
                        value: '$from → $to',
                        isRoute: true,
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Date Info
                      _buildDetailRow(
                        icon: Icons.calendar_today,
                        label: 'التاريخ',
                        value: '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}',
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Time Info
                      _buildDetailRow(
                        icon: Icons.access_time,
                        label: 'وقت الانطلاق',
                        value: trip.time,
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Price Info
                      _buildDetailRow(
                        icon: Icons.attach_money,
                        label: 'السعر',
                        value: '${trip.price.toStringAsFixed(0)} ل.س',
                        isPrice: true,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Seat Selection Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E3A8A).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.event_seat,
                              color: Color(0xFF1E3A8A),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'اختيار المقعد',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1F2937),
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      Text(
                        'اختر مقعدك المفضل للحصول على رحلة مريحة',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                          fontFamily: 'Cairo',
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => SeatSelectionScreen(
                                trip: trip,
                                from: from,
                                to: to,
                                date: date,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.event_seat),
                        label: const Text(
                          'اختيار المقعد',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3A8A),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Additional Info Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'معلومات إضافية',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1F2937),
                          fontFamily: 'Cairo',
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      _buildInfoItem(
                        icon: Icons.check_circle,
                        text: 'تأكيد فوري للحجز',
                        color: Colors.green,
                      ),
                      
                      const SizedBox(height: 12),
                      
                      _buildInfoItem(
                        icon: Icons.security,
                        text: 'سفر آمن ومضمون',
                        color: Colors.blue,
                      ),
                      
                      const SizedBox(height: 12),
                      
                      _buildInfoItem(
                        icon: Icons.support_agent,
                        text: 'دعم فني على مدار الساعة',
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF1E3A8A)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'إلغاء',
                          style: TextStyle(
                            color: Color(0xFF1E3A8A),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: تنفيذ الحجز
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('تم الحجز بنجاح!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3A8A),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'تأكيد الحجز',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    bool isRoute = false,
    bool isPrice = false,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isPrice 
                ? Colors.green.withOpacity(0.1)
                : const Color(0xFF1E3A8A).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isPrice ? Colors.green : const Color(0xFF1E3A8A),
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: isRoute ? 18 : 16,
                  fontWeight: isPrice ? FontWeight.bold : FontWeight.w500,
                  color: isPrice ? Colors.green : const Color(0xFF1F2937),
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
              fontFamily: 'Cairo',
            ),
          ),
        ),
      ],
    );
  }
}

class Ticket {
  final String from;
  final String to;
  final String company;
  final String time;
  final double price;
  final DateTime date;
  Ticket({required this.from, required this.to, required this.company, required this.time, required this.price, required this.date});
}

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    // بيانات تذاكر وهمية
    final tickets = [
      Ticket(from: 'دمشق', to: 'حلب', company: 'شركة الشام', time: '08:00', price: 15000, date: DateTime.now()),
      Ticket(from: 'حمص', to: 'اللاذقية', company: 'شركة الاتحاد', time: '10:30', price: 17000, date: DateTime.now().add(const Duration(days: 1))),
      Ticket(from: 'حماة', to: 'طرطوس', company: 'شركة النور', time: '13:00', price: 16000, date: DateTime.now().add(const Duration(days: 2))),
    ];
    return Directionality(
      textDirection: locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.confirmation_number, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Text(AppLocalizations.of(context)?.busStops ?? 'تذاكري'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E3A8A).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.confirmation_number,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'تذاكري',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${tickets.length} تذكرة محجوزة',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Tickets List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tickets.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final ticket = tickets[index];
                    return _buildTicketCard(context, ticket, index);
                  },
                ),
                
                const SizedBox(height: 24),
                
                // Empty State (if no tickets)
                if (tickets.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E3A8A).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.confirmation_number_outlined,
                            color: Color(0xFF1E3A8A),
                            size: 48,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'لا توجد تذاكر محجوزة',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                            fontFamily: 'Cairo',
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'احجز رحلتك الأولى الآن',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTicketCard(BuildContext context, Ticket ticket, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.directions_bus,
                    color: Color(0xFF1E3A8A),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    ticket.company,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'مؤكدة',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Route Info
            Row(
              children: [
                Expanded(
                  child: _buildTicketInfo(
                    icon: Icons.location_on_outlined,
                    label: 'من',
                    value: ticket.from,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF1E3A8A),
                    size: 16,
                  ),
                ),
                Expanded(
                  child: _buildTicketInfo(
                    icon: Icons.location_on,
                    label: 'إلى',
                    value: ticket.to,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Date and Time
            Row(
              children: [
                Expanded(
                  child: _buildTicketInfo(
                    icon: Icons.calendar_today,
                    label: 'التاريخ',
                    value: '${ticket.date.year}/${ticket.date.month.toString().padLeft(2, '0')}/${ticket.date.day.toString().padLeft(2, '0')}',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTicketInfo(
                    icon: Icons.access_time,
                    label: 'الوقت',
                    value: ticket.time,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Price and Actions
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'السعر',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${ticket.price.toStringAsFixed(0)} ل.س',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A),
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        // TODO: عرض تفاصيل التذكرة
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('عرض تفاصيل التذكرة'),
                            backgroundColor: const Color(0xFF1E3A8A),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF1E3A8A)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'تفاصيل',
                        style: TextStyle(
                          color: Color(0xFF1E3A8A),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: إلغاء التذكرة
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('إلغاء التذكرة'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'إلغاء',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketInfo({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF6B7280),
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1F2937),
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }
}

// Seat Selection Screen
class SeatSelectionScreen extends StatefulWidget {
  final TripResult trip;
  final String from;
  final String to;
  final DateTime date;
  
  const SeatSelectionScreen({
    Key? key,
    required this.trip,
    required this.from,
    required this.to,
    required this.date,
  }) : super(key: key);

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  Set<int> selectedSeats = {};
  Set<int> occupiedSeats = {2, 5, 8, 12, 15, 18, 22, 25, 28, 32, 35, 38};
  
  // Bus layout configuration
  final int totalRows = 10;
  final int seatsPerRow = 4;
  final int totalSeats = 40;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return Directionality(
      textDirection: locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.event_seat, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Text('اختيار المقعد'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Trip Info Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E3A8A).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${widget.from} → ${widget.to}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${widget.trip.company} - ${widget.trip.time}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${widget.date.year}/${widget.date.month.toString().padLeft(2, '0')}/${widget.date.day.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Bus Layout
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Driver Area
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E3A8A).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.drive_eta,
                              color: Color(0xFF1E3A8A),
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'السائق',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E3A8A),
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Seats Grid
                      Column(
                        children: List.generate(totalRows, (rowIndex) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                // Row number
                                SizedBox(
                                  width: 30,
                                  child: Text(
                                    '${rowIndex + 1}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6B7280),
                                      fontFamily: 'Cairo',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                
                                // Seats in this row
                                Expanded(
                                  child: Row(
                                    children: List.generate(seatsPerRow, (seatIndex) {
                                      final seatNumber = rowIndex * seatsPerRow + seatIndex + 1;
                                      final isSelected = selectedSeats.contains(seatNumber);
                                      final isOccupied = occupiedSeats.contains(seatNumber);
                                      
                                      return Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                          child: _buildSeat(
                                            seatNumber: seatNumber,
                                            isSelected: isSelected,
                                            isOccupied: isOccupied,
                                            onTap: () {
                                              if (!isOccupied) {
                                                setState(() {
                                                  if (isSelected) {
                                                    selectedSeats.remove(seatNumber);
                                                  } else {
                                                    selectedSeats.add(seatNumber);
                                                  }
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Legend
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildLegendItem(
                            color: Colors.white,
                            borderColor: const Color(0xFF1E3A8A),
                            text: 'متاح',
                          ),
                          _buildLegendItem(
                            color: const Color(0xFF1E3A8A),
                            borderColor: const Color(0xFF1E3A8A),
                            text: 'مختار',
                          ),
                          _buildLegendItem(
                            color: const Color(0xFFE5E7EB),
                            borderColor: const Color(0xFF9CA3AF),
                            text: 'محجوز',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Selected Seats Summary
                if (selectedSeats.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF1E3A8A)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'المقاعد المختارة:',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                            fontFamily: 'Cairo',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: selectedSeats.map((seat) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E3A8A),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'مقعد $seat',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          )).toList(),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'السعر الإجمالي: ${(widget.trip.price * selectedSeats.length).toStringAsFixed(0)} ل.س',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A8A),
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  ),
                
                const SizedBox(height: 24),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF1E3A8A)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'إلغاء',
                          style: TextStyle(
                            color: Color(0xFF1E3A8A),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: selectedSeats.isNotEmpty ? () {
                          // TODO: تأكيد اختيار المقاعد
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('تم اختيار المقاعد: ${selectedSeats.join(', ')}'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        } : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedSeats.isNotEmpty 
                              ? const Color(0xFF1E3A8A)
                              : const Color(0xFFE5E7EB),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          selectedSeats.isNotEmpty ? 'تأكيد المقاعد' : 'اختر مقعداً',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            color: selectedSeats.isNotEmpty ? Colors.white : const Color(0xFF9CA3AF),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeat({
    required int seatNumber,
    required bool isSelected,
    required bool isOccupied,
    required VoidCallback onTap,
  }) {
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    
    if (isOccupied) {
      backgroundColor = const Color(0xFFE5E7EB);
      borderColor = const Color(0xFF9CA3AF);
      textColor = const Color(0xFF9CA3AF);
    } else if (isSelected) {
      backgroundColor = const Color(0xFF1E3A8A);
      borderColor = const Color(0xFF1E3A8A);
      textColor = Colors.white;
    } else {
      backgroundColor = Colors.white;
      borderColor = const Color(0xFF1E3A8A);
      textColor = const Color(0xFF1E3A8A);
    }
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            '$seatNumber',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
              fontFamily: 'Cairo',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required Color borderColor,
    required String text,
  }) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF6B7280),
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }
}
