import 'package:flutter/material.dart';

enum PaymentMethod { visa, onBoard }

class BookingSummaryScreen extends StatefulWidget {
  final dynamic company;
  final String fromCity;
  final String toCity;
  final DateTime date;
  final dynamic seat;

  const BookingSummaryScreen({
    super.key,
    required this.company,
    required this.fromCity,
    required this.toCity,
    required this.date,
    required this.seat,
  });

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String phone = '';
  String firstName = '';
  String lastName = '';
  String idNumber = '';
  PaymentMethod paymentMethod = PaymentMethod.onBoard;
  int progressStep = 3;
  DateTime? birthDate;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final hotel = args != null ? args['hotel'] : null;
    final isHotel = hotel != null;
    final nights = args != null ? args['nights'] : null;
    final rooms = args != null ? args['rooms'] : null;
    final checkInDate = args != null ? args['checkInDate'] : null;
    final totalPrice = args != null ? args['totalPrice'] : null;
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(isHotel ? 'تأكيد حجز الفندق' : 'تأكيد الحجز', style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF127C8A),
                  foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
                key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
              _buildProgressBar(),
              const SizedBox(height: 10),
              if (isHotel) _hotelSummaryCard(hotel, nights, rooms, checkInDate, totalPrice),
              if (!isHotel) _summaryCard(),
              const SizedBox(height: 18),
              _buildTextField('الإيميل', (v) => email = v!, TextInputType.emailAddress, validator: (v) => v!.isEmpty ? 'أدخل الإيميل' : null),
              const SizedBox(height: 12),
              _buildTextField('رقم الهاتف', (v) => phone = v!, TextInputType.phone, validator: (v) => v!.isEmpty ? 'أدخل رقم الهاتف' : null),
              const SizedBox(height: 12),
              _buildTextField('الاسم', (v) => firstName = v!, TextInputType.text, validator: (v) => v!.isEmpty ? 'أدخل الاسم' : null),
              const SizedBox(height: 12),
              _buildTextField('اللقب', (v) => lastName = v!, TextInputType.text, validator: (v) => v!.isEmpty ? 'أدخل اللقب' : null),
              const SizedBox(height: 12),
              _buildTextField('رقم الهوية أو الجواز', (v) => idNumber = v!, TextInputType.text, validator: (v) => v!.isEmpty ? 'أدخل رقم الهوية أو الجواز' : null),
          const SizedBox(height: 12),
              _buildBirthDateField(),
              const SizedBox(height: 18),
              const Text('طريقة الدفع:', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              Row(
        children: [
                  Radio<PaymentMethod>(
                    value: PaymentMethod.visa,
                    groupValue: paymentMethod,
                    onChanged: (v) => setState(() => paymentMethod = v!),
                  ),
                  const Text('فيزا', style: TextStyle(fontFamily: 'Cairo')),
                  const SizedBox(width: 24),
                  Radio<PaymentMethod>(
                    value: PaymentMethod.onBoard,
                    groupValue: paymentMethod,
                    onChanged: (v) => setState(() => paymentMethod = v!),
                  ),
                  const Text('عند الصعود', style: TextStyle(fontFamily: 'Cairo')),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF127C8A),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate() && birthDate != null) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم إرسال كود التحقق إلى هاتفك'), backgroundColor: Color(0xFF127C8A)),
                    );
                    final bookingData = isHotel
                        ? {
                            'hotel': hotel,
                            'nights': nights,
                            'rooms': rooms,
                            'checkInDate': checkInDate,
                            'totalPrice': totalPrice,
                            'email': email,
                            'phone': phone,
                            'firstName': firstName,
                            'lastName': lastName,
                            'idNumber': idNumber,
                            'birthDate': birthDate,
                            'paymentMethod': paymentMethod,
                          }
                        : {
                            'company': widget.company,
                            'fromCity': widget.fromCity,
                            'toCity': widget.toCity,
                            'date': widget.date,
                            'seat': widget.seat,
                            'email': email,
                            'phone': phone,
                            'firstName': firstName,
                            'lastName': lastName,
                            'idNumber': idNumber,
                            'birthDate': birthDate,
                            'paymentMethod': paymentMethod,
                          };
                    Navigator.pushNamed(context, '/phone_code', arguments: bookingData);
                  } else if (birthDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى اختيار تاريخ الميلاد'), backgroundColor: Colors.red),
                    );
                  }
                },
                child: const Text('تأكيد', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ],
                ),
              ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: List.generate(5, (i) {
          final isActive = i < progressStep;
          return Expanded(
            child: Container(
              height: 6,
              margin: EdgeInsets.only(left: i == 4 ? 0 : 4),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF127C8A) : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSaved, TextInputType type, {String? Function(String?)? validator}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: type,
      validator: validator,
      onSaved: onSaved,
      style: const TextStyle(fontFamily: 'Cairo'),
    );
  }

  Widget _summaryCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الشركة: ${widget.company.name}', style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text('من: ${widget.fromCity}  إلى: ${widget.toCity}', style: const TextStyle(fontFamily: 'Cairo')),
            const SizedBox(height: 6),
            Text('التاريخ: ${widget.date.day}/${widget.date.month}/${widget.date.year}', style: const TextStyle(fontFamily: 'Cairo')),
            const SizedBox(height: 6),
            Text('رقم المقعد: صف ${widget.seat.row + 1} - عمود ${widget.seat.col + 1}', style: const TextStyle(fontFamily: 'Cairo')),
          ],
        ),
      ),
    );
  }

  Widget _hotelSummaryCard(hotel, nights, rooms, checkInDate, totalPrice) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الفندق: ${hotel.name}', style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text('المحافظة: ${hotel.province}', style: const TextStyle(fontFamily: 'Cairo')),
            const SizedBox(height: 6),
            Text('تاريخ الدخول: ${checkInDate.day}/${checkInDate.month}/${checkInDate.year}', style: const TextStyle(fontFamily: 'Cairo')),
            const SizedBox(height: 6),
            Text('عدد الليالي: $nights', style: const TextStyle(fontFamily: 'Cairo')),
            const SizedBox(height: 6),
            Text('عدد الغرف: $rooms', style: const TextStyle(fontFamily: 'Cairo')),
            const SizedBox(height: 6),
            Text('السعر الإجمالي: $totalPrice ل.س', style: const TextStyle(fontFamily: 'Cairo', color: Color(0xFF127C8A), fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildBirthDateField() {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime(2000, 1, 1),
          firstDate: DateTime(1940),
          lastDate: DateTime.now(),
          locale: const Locale('ar'),
        );
        if (picked != null) setState(() => birthDate = picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            const Icon(Icons.cake, color: Color(0xFF127C8A)),
            const SizedBox(width: 8),
          Text(
              birthDate == null
                  ? 'تاريخ الميلاد'
                  : '${birthDate!.day}/${birthDate!.month}/${birthDate!.year}',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: birthDate == null ? Colors.grey[500] : Colors.black,
                fontSize: 15,
              ),
            ),
          ],
          ),
      ),
    );
  }
} 
