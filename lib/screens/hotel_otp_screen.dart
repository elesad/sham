import 'package:flutter/material.dart';
import 'hotel_ticket_screen.dart';

class HotelOtpScreen extends StatefulWidget {
  final Map<String, dynamic> bookingData;
  const HotelOtpScreen({Key? key, required this.bookingData}) : super(key: key);

  @override
  State<HotelOtpScreen> createState() => _HotelOtpScreenState();
}

class _HotelOtpScreenState extends State<HotelOtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _onConfirm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 1)); // محاكاة تحقق
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تأكيد الحجز بنجاح!')),
      );
      // الانتقال إلى شاشة التذكرة النهائية مع بيانات الحجز
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HotelTicketScreen(bookingData: widget.bookingData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('رمز التحقق'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'أدخل رمز التحقق المرسل إلى هاتفك',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, letterSpacing: 16),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                  hintText: '----',
                ),
                validator: (value) => value == null || value.length != 4 ? 'أدخل الرمز المكون من 4 أرقام' : null,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading ? null : _onConfirm,
              child: _isLoading
                  ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('تأكيد'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 