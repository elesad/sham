import 'package:flutter/material.dart';
import 'flight_phone_code_screen.dart';

class FlightBookingInfoScreen extends StatefulWidget {
  final String fromProvince;
  final String toProvince;
  final DateTime date;
  final String flightNumber;
  final String flightTime;
  final int price;
  const FlightBookingInfoScreen({Key? key, required this.fromProvince, required this.toProvince, required this.date, required this.flightNumber, required this.flightTime, required this.price}) : super(key: key);

  @override
  State<FlightBookingInfoScreen> createState() => _FlightBookingInfoScreenState();
}

class _FlightBookingInfoScreenState extends State<FlightBookingInfoScreen> {
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
      final bookingInfo = {
        'email': _emailController.text,
        'phone': _phoneController.text,
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'idNumber': _idController.text,
        'birthDate': _birthDate != null ? '${_birthDate!.year}/${_birthDate!.month}/${_birthDate!.day}' : '',
        'paymentMethod': _paymentMethod!,
        'fromProvince': widget.fromProvince,
        'toProvince': widget.toProvince,
        'date': widget.date,
        'flightNumber': widget.flightNumber,
        'flightTime': widget.flightTime,
        'price': widget.price,
      };
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FlightPhoneCodeScreen(bookingInfo: bookingInfo),
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
        title: const Text('معلومات الحجز للطيران'),
        centerTitle: true,
        backgroundColor: Colors.orange.shade700,
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
                    backgroundColor: Colors.orange.shade700,
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