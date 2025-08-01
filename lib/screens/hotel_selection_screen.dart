import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/favorites_provider.dart';
import 'hotel_booking_screen.dart';

class HotelSelectionScreen extends StatefulWidget {
  const HotelSelectionScreen({Key? key}) : super(key: key);

  @override
  State<HotelSelectionScreen> createState() => _HotelSelectionScreenState();
}

class _HotelSelectionScreenState extends State<HotelSelectionScreen> {
  final List<String> _cities = [
    'دمشق',
    'حلب',
    'حمص',
    'اللاذقية',
    'طرطوس',
    'حماة',
    'دير الزور',
  ];
  String? _selectedCity;
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _rooms = 1;
  int _guests = 2;

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn
          ? (_checkInDate ?? DateTime.now())
          : (_checkOutDate ?? DateTime.now().add(const Duration(days: 1))),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      locale: const Locale('ar'),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
          if (_checkOutDate != null && _checkOutDate!.isBefore(picked)) {
            _checkOutDate = picked.add(const Duration(days: 1));
          }
        } else {
          _checkOutDate = picked;
        }
      });
    }
  }

  void _incrementRooms() {
    setState(() {
      _rooms++;
    });
  }

  void _decrementRooms() {
    if (_rooms > 1) {
      setState(() {
        _rooms--;
      });
    }
  }

  void _incrementGuests() {
    setState(() {
      _guests++;
    });
  }

  void _decrementGuests() {
    if (_guests > 1) {
      setState(() {
        _guests--;
      });
    }
  }

  void _onSearch() {
    if (_selectedCity == null || _checkInDate == null || _checkOutDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار المدينة وتواريخ الدخول والمغادرة')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HotelResultsScreen(
          city: _selectedCity!,
          checkInDate: _checkInDate!,
          checkOutDate: _checkOutDate!,
          rooms: _rooms,
          guests: _guests,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'البحث عن فندق',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark ? const Color(0xFF2D2D2D) : const Color(0xFF8B5CF6),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // اختيار المدينة
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'المدينة',
                  labelStyle: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDark ? Colors.white30 : Colors.grey,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF8B5CF6)),
                  ),
                ),
                dropdownColor: isDark ? const Color(0xFF2D2D2D) : Colors.white,
                value: _selectedCity,
                items: _cities
                    .map((city) => DropdownMenuItem(
                          value: city,
                          child: Text(
                            city,
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              // تواريخ الدخول والمغادرة
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, true),
                      child: AbsorbPointer(
                        child: TextFormField(
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          decoration: InputDecoration(
                            labelText: 'تاريخ الدخول',
                            labelStyle: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black87,
                            ),
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isDark ? Colors.white30 : Colors.grey,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF8B5CF6)),
                            ),
                            prefixIcon: Icon(
                              Icons.calendar_today,
                              color: isDark ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          controller: TextEditingController(
                            text: _checkInDate == null
                                ? ''
                                : DateFormat('yyyy/MM/dd').format(_checkInDate!),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, false),
                      child: AbsorbPointer(
                        child: TextFormField(
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          decoration: InputDecoration(
                            labelText: 'تاريخ المغادرة',
                            labelStyle: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black87,
                            ),
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isDark ? Colors.white30 : Colors.grey,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF8B5CF6)),
                            ),
                            prefixIcon: Icon(
                              Icons.calendar_today,
                              color: isDark ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          controller: TextEditingController(
                            text: _checkOutDate == null
                                ? ''
                                : DateFormat('yyyy/MM/dd').format(_checkOutDate!),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // عدد الغرف
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? Colors.white30 : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.bed,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'عدد الغرف:',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white : Colors.black87,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                      onPressed: _decrementRooms,
                    ),
                    Text(
                      '$_rooms',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                      onPressed: _incrementRooms,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // عدد الأشخاص
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? Colors.white30 : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'عدد الأشخاص:',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white : Colors.black87,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                      onPressed: _decrementGuests,
                    ),
                    Text(
                      '$_guests',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                      onPressed: _incrementGuests,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // زر البحث
              ElevatedButton.icon(
                icon: const Icon(Icons.search),
                label: const Text(
                  'بحث عن فنادق',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _onSearch,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// شاشة نتائج الفنادق
class HotelResultsScreen extends StatefulWidget {
  final String city;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int rooms;
  final int guests;
  const HotelResultsScreen({Key? key, required this.city, required this.checkInDate, required this.checkOutDate, required this.rooms, required this.guests}) : super(key: key);

  @override
  State<HotelResultsScreen> createState() => _HotelResultsScreenState();
}

class _HotelResultsScreenState extends State<HotelResultsScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late List<Map<String, dynamic>> hotels;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
    
    hotels = List.generate(4, (i) => {
      'id': 'hotel_${i+1}',
      'name': '${widget.city} هوتيل ${i+1}',
      'image': 'https://source.unsplash.com/400x30${i}/?hotel,${widget.city}',
      'location': widget.city,
      'rating': 4.0 + (i % 2) * 0.5,
      'price': 50000 + i * 8000,
      'description': 'فندق فاخر في قلب ${widget.city}',
      'features': 'مكيف • WiFi • مطعم • صالة رياضية',
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFavorite(Map<String, dynamic> hotel) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
    final isFavorite = favoritesProvider.isFavorite(hotel['id']);
    
    if (isFavorite) {
      // إزالة من المفضلة
      favoritesProvider.removeFromFavorites(hotel['id']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم إزالة ${hotel['name']} من المفضلة'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } else {
      // إضافة إلى المفضلة
      final favoriteItem = FavoriteItem(
        id: hotel['id'],
        name: hotel['name'],
        type: 'hotel',
        fromLocation: widget.city,
        toLocation: widget.city,
        date: '${widget.checkInDate.day}/${widget.checkInDate.month}/${widget.checkInDate.year}',
        price: '${hotel['price']} ل.س',
        time: '${widget.rooms} غرفة • ${widget.guests} شخص',
        description: hotel['description'],
        features: hotel['features'],
        addedAt: DateTime.now(),
      );
      favoritesProvider.addToFavorites(favoriteItem);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم إضافة ${hotel['name']} إلى المفضلة'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          action: SnackBarAction(
            label: 'تراجع',
            textColor: Colors.white,
            onPressed: () {
              favoritesProvider.removeFromFavorites(hotel['id']);
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'فنادق ${widget.city}',
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark ? const Color(0xFF2D2D2D) : const Color(0xFF8B5CF6),
        foregroundColor: Colors.white,
        actions: [
          Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              final hotelFavoritesCount = favoritesProvider.getFavoritesCountByType('hotel');
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.white),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('لديك $hotelFavoritesCount عنصر في المفضلة'),
                          backgroundColor: Colors.pink[400],
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    },
                  ),
                  if (hotelFavoritesCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$hotelFavoritesCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: hotels.length,
          separatorBuilder: (_, __) => const SizedBox(height: 18),
          itemBuilder: (context, i) {
            final hotel = hotels[i];
            return Consumer<FavoritesProvider>(
              builder: (context, favoritesProvider, child) {
                final isFavorite = favoritesProvider.isFavorite(hotel['id']);
                
                return Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: isDark 
                          ? Colors.black.withOpacity(0.3)
                          : Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // صورة الفندق
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            hotel['image'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF404040) : Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.hotel,
                                size: 40,
                                color: isDark ? Colors.white70 : Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // معلومات الفندق
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hotel['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: isDark ? Colors.white : Colors.black87,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  Text(
                                    hotel['rating'].toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Icon(
                                    Icons.attach_money,
                                    size: 16,
                                    color: const Color(0xFF8B5CF6),
                                  ),
                                  Text(
                                    '${hotel['price']} ل.س',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color(0xFF8B5CF6),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                hotel['features'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark ? Colors.white70 : Colors.grey[600],
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          ),
                        ),
                        // زر القلب
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                            size: 28,
                          ),
                          onPressed: () => _toggleFavorite(hotel),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
} 
