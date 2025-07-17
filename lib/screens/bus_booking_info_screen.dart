import 'package:flutter/material.dart';
import 'phone_code_screen.dart';
import '../models/bus_booking_info.dart';

class BusBookingInfoScreen extends StatefulWidget {
  final String companyName;
  final String seatNumber;
  final String tripDate;
  final String tripTime;
  final String bookingId;
  final String fromCity;
  final String toCity;

  const BusBookingInfoScreen({
    Key? key,
    required this.companyName,
    required this.seatNumber,
    required this.tripDate,
    required this.tripTime,
    required this.bookingId,
    required this.fromCity,
    required this.toCity,
  }) : super(key: key);

  @override
  State<BusBookingInfoScreen> createState() => _BusBookingInfoScreenState();
}

class _BusBookingInfoScreenState extends State<BusBookingInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  DateTime? _birthDate;
  String? _paymentMethod;

  void _pickBirthDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      locale: const Locale('ar', 'SA'),
    );
    if (date != null) {
      setState(() {
        _birthDate = date;
      });
    }
  }

  void _onConfirm() {
    if (_formKey.currentState!.validate() && _birthDate != null && _paymentMethod != null) {
      final bookingInfo = BusBookingInfo(
        companyName: widget.companyName,
        seatNumber: widget.seatNumber,
        tripDate: widget.tripDate,
        tripTime: widget.tripTime,
        bookingId: widget.bookingId,
        fromCity: widget.fromCity,
        toCity: widget.toCity,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        idNumber: _idController.text,
        birthDate: _birthDate!,
        paymentMethod: _paymentMethod!,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhoneCodeScreen(bookingInfo: bookingInfo),
        ),
      );
    } else if (_birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يرجى اختيار تاريخ الميلاد')));
    } else if (_paymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يرجى اختيار طريقة الدفع')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('معلومات الحجز'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(_emailController, 'البريد الإلكتروني', TextInputType.emailAddress, validator: (v) {
                if (v == null || v.isEmpty) return 'يرجى إدخال البريد الإلكتروني';
                if (!v.contains('@')) return 'البريد الإلكتروني غير صالح';
                return null;
              }),
              const SizedBox(height: 16),
              _buildTextField(_phoneController, 'رقم الهاتف', TextInputType.phone, validator: (v) {
                if (v == null || v.isEmpty) return 'يرجى إدخال رقم الهاتف';
                if (v.length < 7) return 'رقم الهاتف غير صالح';
                return null;
              }),
              const SizedBox(height: 16),
              _buildTextField(_firstNameController, 'الاسم الأول', TextInputType.text, validator: (v) {
                if (v == null || v.isEmpty) return 'يرجى إدخال الاسم الأول';
                return null;
              }),
              const SizedBox(height: 16),
              _buildTextField(_lastNameController, 'اللقب', TextInputType.text, validator: (v) {
                if (v == null || v.isEmpty) return 'يرجى إدخال اللقب';
                return null;
              }),
              const SizedBox(height: 16),
              _buildTextField(_idController, 'رقم الهوية/الجواز', TextInputType.text, validator: (v) {
                if (v == null || v.isEmpty) return 'يرجى إدخال رقم الهوية أو الجواز';
                return null;
              }),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickBirthDate,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'تاريخ الميلاد',
                      border: const OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(
                      text: _birthDate == null ? '' : '${_birthDate!.year}/${_birthDate!.month}/${_birthDate!.day}',
                    ),
                    validator: (_) {
                      if (_birthDate == null) return 'يرجى اختيار تاريخ الميلاد';
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                decoration: const InputDecoration(
                  labelText: 'طريقة الدفع',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'visa', child: Text('Visa')), 
                  DropdownMenuItem(value: 'on_board', child: Text('الدفع عند الصعود')),
                ],
                onChanged: (val) => setState(() => _paymentMethod = val),
                validator: (v) => v == null ? 'يرجى اختيار طريقة الدفع' : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('تأكيد الحجز', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, TextInputType type, {String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
} 