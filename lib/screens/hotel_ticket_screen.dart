import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../screens/my_trips.dart';

class HotelTicketScreen extends StatefulWidget {
  final Map<String, dynamic> bookingData;
  const HotelTicketScreen({Key? key, required this.bookingData}) : super(key: key);

  @override
  State<HotelTicketScreen> createState() => _HotelTicketScreenState();
}

class _HotelTicketScreenState extends State<HotelTicketScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _saveToMyTrips();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hotelName = widget.bookingData['hotelName'] ?? '';
    final hotelImage = widget.bookingData['hotelImage'] ?? '';
    final location = widget.bookingData['location'] ?? '';
    final rating = widget.bookingData['rating']?.toString() ?? '';
    final price = widget.bookingData['price']?.toString() ?? '';
    final checkInDate = widget.bookingData['checkInDate'] as DateTime?;
    final checkOutDate = widget.bookingData['checkOutDate'] as DateTime?;
    final rooms = widget.bookingData['rooms']?.toString() ?? '';
    final guests = widget.bookingData['guests']?.toString() ?? '';
    final name = widget.bookingData['name'] ?? '';
    final email = widget.bookingData['email'] ?? '';
    final phone = widget.bookingData['phone'] ?? '';
    final id = widget.bookingData['id'] ?? '';
    final birthDate = widget.bookingData['birthDate'] as DateTime?;
    final bookingId = widget.bookingData['bookingId'] ?? 'SHM${DateTime.now().millisecondsSinceEpoch}';
    final nights = checkInDate != null && checkOutDate != null ? checkOutDate.difference(checkInDate).inDays : 1;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'تذكرة الفندق',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF8B5CF6),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Hotel Info Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.hotel,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hotelName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.white70,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    location,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    rating,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Booking Details Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B5CF6).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.calendar_today,
                            color: Color(0xFF8B5CF6),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'تفاصيل الحجز',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B5CF6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDetailItem(
                            'الدخول',
                            checkInDate != null ? DateFormat('yyyy/MM/dd').format(checkInDate) : '',
                            Icons.login,
                          ),
                        ),
                        Expanded(
                          child: _buildDetailItem(
                            'الخروج',
                            checkOutDate != null ? DateFormat('yyyy/MM/dd').format(checkOutDate) : '',
                            Icons.logout,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDetailItem(
                            'عدد الليالي',
                            '$nights',
                            Icons.nights_stay,
                          ),
                        ),
                        Expanded(
                          child: _buildDetailItem(
                            'الغرف',
                            rooms,
                            Icons.bed,
                          ),
                        ),
                        Expanded(
                          child: _buildDetailItem(
                            'الأشخاص',
                            guests,
                            Icons.people,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildDetailItem(
                      'السعر',
                      '$price ل.س',
                      Icons.attach_money,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Guest Info Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B5CF6).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Color(0xFF8B5CF6),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'معلومات الضيف',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B5CF6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildGuestInfoItem(Icons.person, 'الاسم', name),
                    const SizedBox(height: 16),
                    _buildGuestInfoItem(Icons.email, 'البريد الإلكتروني', email),
                    const SizedBox(height: 16),
                    _buildGuestInfoItem(Icons.phone, 'رقم الهاتف', phone),
                    const SizedBox(height: 16),
                    _buildGuestInfoItem(Icons.badge, 'رقم الهوية', id),
                    const SizedBox(height: 16),
                    _buildGuestInfoItem(
                      Icons.cake,
                      'تاريخ الميلاد',
                      birthDate != null ? DateFormat('yyyy/MM/dd').format(birthDate) : '',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // QR Code Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: QrImageView(
                        data: bookingId,
                        version: QrVersions.auto,
                        size: 150,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'رقم الحجز: $bookingId',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B5CF6),
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
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('سيتم تنزيل التذكرة قريباً!'),
                            backgroundColor: Color(0xFF8B5CF6),
                          ),
                        );
                      },
                      icon: const Icon(Icons.download, size: 24),
                      label: const Text(
                        'تحميل',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('سيتم إرسال التذكرة بالبريد قريباً!'),
                            backgroundColor: Color(0xFF8B5CF6),
                          ),
                        );
                      },
                      icon: const Icon(Icons.email, size: 24),
                      label: const Text(
                        'إرسال',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Save to My Trips Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _saveToMyTrips();
                  },
                  icon: const Icon(Icons.save, size: 24),
                  label: const Text(
                    'حفظ في رحلاتي',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Home Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  icon: const Icon(Icons.home, size: 24),
                  label: const Text(
                    'العودة إلى الصفحة الرئيسية',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: const Color(0xFF8B5CF6),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B5CF6),
          ),
        ),
      ],
    );
  }

  Widget _buildGuestInfoItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF8B5CF6).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: const Color(0xFF8B5CF6),
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
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B5CF6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _saveToMyTrips() {
    final myTripsProvider = Provider.of<MyTripsProvider>(context, listen: false);
    
    final trip = Trip(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: TripType.hotel,
      from: widget.bookingData['location'] ?? '',
      to: widget.bookingData['location'] ?? '',
      date: DateTime.now(),
      time: '${DateTime.now().hour}:${DateTime.now().minute}',
      company: widget.bookingData['hotelName'] ?? '',
      status: TripStatus.confirmed,
      price: double.tryParse(widget.bookingData['price']?.toString() ?? '0') ?? 0.0,
      seatNumber: widget.bookingData['rooms']?.toString() ?? '',
      ticketNumber: 'HOTEL${DateTime.now().millisecondsSinceEpoch}',
    );
    
    myTripsProvider.addTrip(trip);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('تم حفظ التذكرة في رحلاتي'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
} 
