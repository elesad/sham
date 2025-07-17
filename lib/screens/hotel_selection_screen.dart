import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('البحث عن فندق'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // اختيار المدينة
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'المدينة',
                  border: OutlineInputBorder(),
                ),
                value: _selectedCity,
                items: _cities
                    .map((city) => DropdownMenuItem(
                          value: city,
                          child: Text(city),
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
                          decoration: const InputDecoration(
                            labelText: 'تاريخ الدخول',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_today),
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
                          decoration: const InputDecoration(
                            labelText: 'تاريخ المغادرة',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_today),
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
              Row(
                children: [
                  const Text('عدد الغرف:', style: TextStyle(fontSize: 16)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: _decrementRooms,
                  ),
                  Text('$_rooms', style: const TextStyle(fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: _incrementRooms,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // عدد الأشخاص
              Row(
                children: [
                  const Text('عدد الأشخاص:', style: TextStyle(fontSize: 16)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: _decrementGuests,
                  ),
                  Text('$_guests', style: const TextStyle(fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: _incrementGuests,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // زر البحث
              ElevatedButton.icon(
                icon: const Icon(Icons.search),
                label: const Text('بحث عن فنادق'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
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

class _HotelResultsScreenState extends State<HotelResultsScreen> {
  final Set<int> favorites = {};
  late List<Map<String, dynamic>> hotels;

  @override
  void initState() {
    super.initState();
    hotels = List.generate(4, (i) => {
      'name': '${widget.city} هوتيل ${i+1}',
      'image': 'https://source.unsplash.com/400x30${i}/?hotel,${widget.city}',
      'location': widget.city,
      'rating': 4.0 + (i % 2) * 0.5,
      'price': 50000 + i * 8000,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('فنادق ${widget.city}'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: hotels.length,
        separatorBuilder: (_, __) => const SizedBox(height: 18),
        itemBuilder: (context, i) {
          final hotel = hotels[i];
          final isFav = favorites.contains(i);
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(hotel['image'], width: 60, height: 60, fit: BoxFit.cover),
              ),
              title: Text(hotel['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(hotel['rating'].toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 12),
                      Icon(Icons.attach_money, size: 16, color: Colors.green[700]),
                      Text('${hotel['price']} ل.س', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : Colors.grey),
                onPressed: () => setState(() => isFav ? favorites.remove(i) : favorites.add(i)),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HotelBookingScreen(
                      hotelName: hotel['name'],
                      hotelImage: hotel['image'],
                      location: hotel['location'],
                      rating: hotel['rating'],
                      price: hotel['price'],
                      checkInDate: widget.checkInDate,
                      checkOutDate: widget.checkOutDate,
                      rooms: widget.rooms,
                      guests: widget.guests,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
} 
