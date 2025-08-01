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
  String _docType = 'id';
  String _nationality = 'سوريا';
  final List<String> _countries = [
    'سوريا', 'مصر', 'لبنان', 'الأردن', 'العراق', 'تركيا', 'السعودية', 'الإمارات', 'قطر', 'تونس', 'المغرب', 'الجزائر', 'اليمن', 'فلسطين', 'ليبيا', 'السودان', 'دولة أخرى'
  ];

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
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'حجز الفندق',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hotel Info Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3A8A).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.hotel,
                        color: Color(0xFF1E3A8A),
                        size: 40,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.hotelName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.location,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.rating.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'ابتداءً من ${widget.price} ل.س',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Color(0xFF1E3A8A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Booking Summary Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ملخص الحجز',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryItem(
                            'الدخول',
                            DateFormat('yyyy/MM/dd').format(widget.checkInDate),
                            Icons.login,
                          ),
                        ),
                        Expanded(
                          child: _buildSummaryItem(
                            'الخروج',
                            DateFormat('yyyy/MM/dd').format(widget.checkOutDate),
                            Icons.logout,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryItem(
                            'الغرف',
                            '${widget.rooms}',
                            Icons.bed,
                          ),
                        ),
                        Expanded(
                          child: _buildSummaryItem(
                            'الأشخاص',
                            '${widget.guests}',
                            Icons.people,
                          ),
                        ),
                        Expanded(
                          child: _buildSummaryItem(
                            'الليالي',
                            '$nights',
                            Icons.nights_stay,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Booking Form Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'معلومات الحجز',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Nationality
                      DropdownButtonFormField<String>(
                        value: _nationality,
                        decoration: const InputDecoration(
                          labelText: 'الجنسية',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: _countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                        onChanged: (val) => setState(() => _nationality = val ?? 'سوريا'),
                      ),
                      const SizedBox(height: 12),

                      // Full Name
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'الاسم الكامل',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال الاسم' : null,
                      ),
                      const SizedBox(height: 12),

                      // Email
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'البريد الإلكتروني',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال البريد الإلكتروني' : null,
                      ),
                      const SizedBox(height: 12),

                      // Document Type and Number
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              value: _docType,
                              decoration: const InputDecoration(
                                labelText: 'نوع الوثيقة',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'id', child: Text('هوية')),
                                DropdownMenuItem(value: 'passport', child: Text('جواز سفر')),
                              ],
                              onChanged: (val) => setState(() => _docType = val ?? 'id'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              controller: _idController,
                              decoration: InputDecoration(
                                labelText: _docType == 'id' ? 'رقم الهوية' : 'رقم الجواز',
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                              validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال رقم الوثيقة' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Phone Number
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'رقم الهاتف',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال رقم الهاتف' : null,
                      ),
                      const SizedBox(height: 12),

                      // Birth Date
                      GestureDetector(
                        onTap: () => _selectBirthDate(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
                              const SizedBox(width: 8),
                              Text(
                                _birthDate != null
                                    ? DateFormat('yyyy/MM/dd').format(_birthDate!)
                                    : 'تاريخ الميلاد',
                                style: TextStyle(
                                  color: _birthDate != null ? Colors.black : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onConfirmBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'تأكيد الحجز',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 14,
              color: const Color(0xFF1E3A8A),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
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
              errorBuilder: (context, error, stackTrace) => Icon(Icons.hotel, size: 80, color: Colors.grey),
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
