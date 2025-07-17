import 'package:flutter/material.dart';
import '../models/hotel_models.dart';
import '../models/flight_models.dart';
import 'hotel_ticket_screen.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import 'my_trips.dart';

import 'hotel_booking_screen.dart'; // للتأكد من توفر Hotel class
import 'package:intl/intl.dart';
import 'hotel_otp_screen.dart';

class HotelBookingScreen extends StatefulWidget {
  final String hotelName;
  final String hotelImage;
  final String location;
  final double rating;
  final int price;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int rooms;
  final int guests;

  const HotelBookingScreen({
    Key? key,
    required this.hotelName,
    required this.hotelImage,
    required this.location,
    required this.rating,
    required this.price,
    required this.checkInDate,
    required this.checkOutDate,
    required this.rooms,
    required this.guests,
  }) : super(key: key);

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  DateTime? _birthDate;

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      locale: const Locale('ar'),
    );
    if (picked != null) {
    setState(() {
        _birthDate = picked;
      });
    }
  }

  void _onConfirmBooking() {
    if (_formKey.currentState?.validate() ?? false) {
      final bookingData = {
        'hotelName': widget.hotelName,
        'hotelImage': widget.hotelImage,
        'location': widget.location,
        'rating': widget.rating,
        'price': widget.price,
        'checkInDate': widget.checkInDate,
        'checkOutDate': widget.checkOutDate,
        'rooms': widget.rooms,
        'guests': widget.guests,
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'id': _idController.text,
        'birthDate': _birthDate,
      };
      Navigator.push(
                    context,
                    MaterialPageRoute(
          builder: (context) => HotelOtpScreen(bookingData: bookingData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final nights = widget.checkOutDate.difference(widget.checkInDate).inDays;
    return Scaffold(
      appBar: AppBar(
        title: const Text('حجز الفندق'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ملخص بيانات الفندق
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(14)),
                    child: Image.network(
                      widget.hotelImage,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.hotelName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 4),
                    Row(
                            children: [
                            Icon(Icons.location_on, size: 16, color: Colors.grey[700]),
                            Text(widget.location, style: TextStyle(color: Colors.grey[700])),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                                children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Text(widget.rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('ابتداءً من ${widget.price} ل.س', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                        ),
                      ),
                    ],
                  ),
                ),
            const SizedBox(height: 16),
            // ملخص بيانات البحث
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16),
                        const SizedBox(width: 4),
                        Text('الدخول: ${DateFormat('yyyy/MM/dd').format(widget.checkInDate)}'),
                        const SizedBox(width: 12),
                        Text('الخروج: ${DateFormat('yyyy/MM/dd').format(widget.checkOutDate)}'),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.bed, size: 16),
                        const SizedBox(width: 4),
                        Text('عدد الغرف: ${widget.rooms}'),
                        const SizedBox(width: 12),
                        const Icon(Icons.person, size: 16),
                        const SizedBox(width: 4),
                        Text('عدد الأشخاص: ${widget.guests}'),
                    const SizedBox(width: 12),
                        Text('عدد الليالي: $nights'),
                      ],
                    ),
                  ],
                ),
              ),
                    ),
            const SizedBox(height: 24),
            // نموذج بيانات الحجز
            Form(
              key: _formKey,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'الاسم الكامل',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال الاسم' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'البريد الإلكتروني',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال البريد الإلكتروني' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'رقم الهاتف',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال رقم الهاتف' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _idController,
                    decoration: const InputDecoration(
                      labelText: 'رقم الهوية أو جواز السفر',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال رقم الهوية أو الجواز' : null,
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => _selectBirthDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'تاريخ الميلاد',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.cake),
                        ),
                        controller: TextEditingController(
                          text: _birthDate == null ? '' : DateFormat('yyyy/MM/dd').format(_birthDate!),
                        ),
                        validator: (value) => _birthDate == null ? 'الرجاء اختيار تاريخ الميلاد' : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _onConfirmBooking,
                    child: const Text('تأكيد الحجز'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
                                    ),
                                  ],
                                ),
                              ),
    );
  }
}

class HotelResultsScreen extends StatelessWidget {
  final String city;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int rooms;
  final int guests;

  const HotelResultsScreen({
    Key? key,
    required this.city,
    required this.checkInDate,
    required this.checkOutDate,
    required this.rooms,
    required this.guests,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // بيانات وهمية للفنادق
    final hotels = [
      {
        'name': 'فندق الشام الكبير',
        'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
        'rating': 4.5,
        'price': 35000,
        'location': 'وسط المدينة',
        'isFavorite': false,
      },
      {
        'name': 'فندق بردى',
        'image': 'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80',
        'rating': 4.0,
        'price': 25000,
        'location': 'القيمرية',
        'isFavorite': true,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('فنادق في $city'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: hotels.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final hotel = hotels[index];
          return HotelCard(
            name: hotel['name'] as String,
            imageUrl: hotel['image'] as String,
            rating: hotel['rating'] as double,
            price: hotel['price'] as int,
            location: hotel['location'] as String,
            isFavorite: hotel['isFavorite'] as bool,
            onFavoriteToggle: () {},
            onBook: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HotelBookingScreen(
                    hotelName: hotel['name'] as String,
                    hotelImage: hotel['image'] as String,
                    location: hotel['location'] as String,
                    rating: hotel['rating'] as double,
                    price: hotel['price'] as int,
                    checkInDate: checkInDate,
                    checkOutDate: checkOutDate,
                    rooms: rooms,
                    guests: guests,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double rating;
  final int price;
  final String location;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onBook;

  const HotelCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.location,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onBook,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              imageUrl,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: onFavoriteToggle,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 18, color: Colors.grey[700]),
                    const SizedBox(width: 4),
                    Text(location, style: TextStyle(color: Colors.grey[700])),
                    const Spacer(),
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    Text(rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('ابتداءً من ', style: TextStyle(color: Colors.grey[700])),
                    Text('$price ل.س', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Spacer(),
              ElevatedButton(
                      onPressed: onBook,
                      child: const Text('احجز الآن'),
                style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 
