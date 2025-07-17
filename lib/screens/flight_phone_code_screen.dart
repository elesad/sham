import 'package:flutter/material.dart';
import 'flight_ticket_screen.dart';

class FlightPhoneCodeScreen extends StatefulWidget {
  final Map<String, dynamic> bookingInfo;
  const FlightPhoneCodeScreen({Key? key, required this.bookingInfo}) : super(key: key);

  @override
  State<FlightPhoneCodeScreen> createState() => _FlightPhoneCodeScreenState();
}

class _FlightPhoneCodeScreenState extends State<FlightPhoneCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onConfirm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تأكيد الحجز بنجاح!')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FlightTicketScreen(bookingInfo: widget.bookingInfo),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تأكيد كود الهاتف'),
        centerTitle: true,
        backgroundColor: Colors.orange.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'أدخل الكود المرسل إلى هاتفك',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'الكود',
                        counterText: '',
                      ),
                      validator: (value) {
                        if (value == null || value.length != 4) {
                          return 'يرجى إدخال الكود المكون من 4 أرقام';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _onConfirm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade700,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('تأكيد'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
} 