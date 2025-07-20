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
  String _docType = 'id'; // 'id' or 'passport'
  String _nationality = 'سوريا';
  final List<String> _countries = [
    'سوريا', 'مصر', 'لبنان', 'الأردن', 'العراق', 'تركيا', 'السعودية', 'الإمارات', 'قطر', 'تونس', 'المغرب', 'الجزائر', 'اليمن', 'فلسطين', 'ليبيا', 'السودان', 'دولة أخرى'
  ];

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
              // الجنسية واختيار البلد إذا لم يكن سوري
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _nationality,
                      decoration: const InputDecoration(
                        labelText: 'الجنسية',
                        border: OutlineInputBorder(),
                      ),
                      items: _countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                      onChanged: (val) => setState(() => _nationality = val ?? 'سوريا'),
                    ),
                  ),
                  if (_nationality != 'سوريا')
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Icon(Icons.flag, color: Colors.blue.shade800),
                    ),
                ],
              ),
              const SizedBox(height: 18),
              // الاسم مقابل الرقم
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'الاسم الأول',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v == null || v.isEmpty ? 'يرجى إدخال الاسم الأول' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'اللقب',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v == null || v.isEmpty ? 'يرجى إدخال اللقب' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // البريد مقابل الهاتف
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'البريد الإلكتروني',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'يرجى إدخال البريد الإلكتروني';
                        if (!v.contains('@')) return 'البريد الإلكتروني غير صالح';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'رقم الهاتف',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'يرجى إدخال رقم الهاتف';
                        if (v.length < 7) return 'رقم الهاتف غير صالح';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // اختيار نوع الوثيقة مع الرقم
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      value: _docType,
                      decoration: const InputDecoration(
                        labelText: 'نوع الوثيقة',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'id', child: Text('هوية')),
                        DropdownMenuItem(value: 'passport', child: Text('جواز سفر')),
                      ],
                      onChanged: (val) => setState(() => _docType = val ?? 'id'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _idController,
                      decoration: InputDecoration(
                        labelText: _docType == 'id' ? 'رقم الهوية' : 'رقم الجواز',
                        border: const OutlineInputBorder(),
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                      ),
                      validator: (v) => v == null || v.isEmpty ? 'يرجى إدخال رقم الوثيقة' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // تاريخ الميلاد
              GestureDetector(
                onTap: _pickBirthDate,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'تاريخ الميلاد',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
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
              const SizedBox(height: 18),
              // طريقة الدفع
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
              ElevatedButton(
                onPressed: _onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF127C8A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('تأكيد الحجز', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 16)),
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