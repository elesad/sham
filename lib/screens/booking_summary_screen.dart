import 'package:flutter/material.dart';
import '../models/bus_models.dart';
import 'ticket_screen.dart';

class BookingSummaryScreen extends StatefulWidget {
  final BusTrip trip;
  final List<BusSeat> selectedSeats;
  final Map<String, SeatGender> seatGenders;

  const BookingSummaryScreen({
    super.key,
    required this.trip,
    required this.selectedSeats,
    required this.seatGenders,
  });

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _idController = TextEditingController();
  String _paymentMethod = 'cash';
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _idController.dispose();
    super.dispose();
  }

  void _confirmBooking() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // محاكاة عملية الحجز
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);
      
      // الانتقال إلى صفحة التذكرة
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TicketScreen(
            trip: widget.trip,
            selectedSeats: widget.selectedSeats,
            seatGenders: widget.seatGenders,
            passengerName: _nameController.text,
            passengerEmail: _emailController.text,
            passengerPhone: _phoneController.text,
            passengerId: _idController.text,
            paymentMethod: _paymentMethod,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.selectedSeats.length * widget.trip.price;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'تأكيد الحجز',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF127C8A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ملخص الرحلة
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
                      'ملخص الرحلة',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF127C8A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow('من:', widget.trip.fromProvince),
                    _buildInfoRow('إلى:', widget.trip.toProvince),
                    _buildInfoRow('التاريخ:', '${widget.trip.departureTime.day}/${widget.trip.departureTime.month}/${widget.trip.departureTime.year}'),
                    _buildInfoRow('الوقت:', '${widget.trip.departureTime.hour.toString().padLeft(2, '0')}:${widget.trip.departureTime.minute.toString().padLeft(2, '0')}'),
                    _buildInfoRow('المقاعد:', '${widget.selectedSeats.length} مقعد'),
                    _buildInfoRow('السعر الإجمالي:', '${totalPrice.toInt()} ل.س'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // معلومات المسافر
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
                      'معلومات المسافر',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF127C8A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'الاسم واللقب',
                        prefixIcon: Icon(Icons.person, color: Color(0xFF127C8A)),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال الاسم';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'البريد الإلكتروني',
                        prefixIcon: Icon(Icons.email, color: Color(0xFF127C8A)),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال البريد الإلكتروني';
                        }
                        if (!value.contains('@')) {
                          return 'يرجى إدخال بريد إلكتروني صحيح';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'رقم الهاتف',
                        prefixIcon: Icon(Icons.phone, color: Color(0xFF127C8A)),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال رقم الهاتف';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _idController,
                      decoration: const InputDecoration(
                        labelText: 'رقم الهوية أو الجواز',
                        prefixIcon: Icon(Icons.credit_card, color: Color(0xFF127C8A)),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال رقم الهوية أو الجواز';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // طريقة الدفع
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
                      'طريقة الدفع',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF127C8A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RadioListTile<String>(
                      title: const Text('فيزا / ماستركارد', style: TextStyle(fontFamily: 'Cairo')),
                      value: 'card',
                      groupValue: _paymentMethod,
                      onChanged: (value) => setState(() => _paymentMethod = value!),
                      activeColor: const Color(0xFF127C8A),
                    ),
                    RadioListTile<String>(
                      title: const Text('الدفع عند الصعود', style: TextStyle(fontFamily: 'Cairo')),
                      value: 'cash',
                      groupValue: _paymentMethod,
                      onChanged: (value) => setState(() => _paymentMethod = value!),
                      activeColor: const Color(0xFF127C8A),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // زر التأكيد
              ElevatedButton(
                onPressed: _isLoading ? null : _confirmBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF127C8A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'تأكيد الحجز',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
} 
