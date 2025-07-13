import 'package:flutter/material.dart';
import '../models/flight_models.dart';
import '../data/flight_data.dart';
import 'flight_ticket_screen.dart';

class FlightBookingScreen extends StatefulWidget {
  final Flight flight;
  final FlightCompany company;

  const FlightBookingScreen({
    super.key,
    required this.flight,
    required this.company,
  });

  @override
  State<FlightBookingScreen> createState() => _FlightBookingScreenState();
}

class _FlightBookingScreenState extends State<FlightBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _idController = TextEditingController();
  final _passportController = TextEditingController();
  
  String _selectedNationality = 'سوريا';
  bool _isForeigner = false;
  bool _isLoading = false;
  bool _showVisaForm = false;
  
  // معلومات الفيزا
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _idController.dispose();
    _passportController.dispose();
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _confirmBooking() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // محاكاة عملية الحجز
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);
      
      // إنشاء معلومات الفيزا إذا تم اختيار الدفع بالفيزا
      VisaInfo? visaInfo;
      if (_showVisaForm) {
        visaInfo = VisaInfo(
          cardNumber: _cardNumberController.text,
          cardHolderName: _cardHolderController.text,
          expiryDate: _expiryController.text,
          cvv: _cvvController.text,
        );
      }

      // الانتقال إلى صفحة التذكرة
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FlightTicketScreen(
            flight: widget.flight,
            company: widget.company,
            passengerName: _nameController.text,
            passengerEmail: _emailController.text,
            passengerPhone: _phoneController.text,
            passengerId: _isForeigner ? _passportController.text : _idController.text,
            nationality: _selectedNationality,
            visaInfo: visaInfo,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'حجز الطائرة',
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
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF127C8A).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              widget.company.logo,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.company.name,
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                              Text(
                                widget.flight.flightNumber,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${widget.flight.price.toInt()} ل.س',
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF127C8A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${widget.flight.departureTime.hour.toString().padLeft(2, '0')}:${widget.flight.departureTime.minute.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.flight.fromCity,
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: Colors.grey[300],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF127C8A),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.flight,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${widget.flight.arrivalTime.hour.toString().padLeft(2, '0')}:${widget.flight.arrivalTime.minute.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.flight.toCity,
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
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
                    
                    // اختيار الجنسية
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedNationality,
                            decoration: const InputDecoration(
                              labelText: 'الجنسية',
                              prefixIcon: Icon(Icons.flag, color: Color(0xFF127C8A)),
                              border: OutlineInputBorder(),
                            ),
                            items: FlightData.countries.map((country) {
                              return DropdownMenuItem(
                                value: country,
                                child: Text(country, style: const TextStyle(fontFamily: 'Cairo')),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedNationality = value!;
                                _isForeigner = value != 'سوريا';
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    // رقم الهوية أو الجواز
                    TextFormField(
                      controller: _isForeigner ? _passportController : _idController,
                      decoration: InputDecoration(
                        labelText: _isForeigner ? 'رقم الجواز' : 'رقم الهوية',
                        prefixIcon: const Icon(Icons.credit_card, color: Color(0xFF127C8A)),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return _isForeigner ? 'يرجى إدخال رقم الجواز' : 'يرجى إدخال رقم الهوية';
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
                      title: const Text('فيزا', style: TextStyle(fontFamily: 'Cairo')),
                      value: 'visa',
                      groupValue: _showVisaForm ? 'visa' : 'cash',
                      onChanged: (value) {
                        setState(() {
                          _showVisaForm = true;
                        });
                      },
                      activeColor: const Color(0xFF127C8A),
                    ),
                    RadioListTile<String>(
                      title: const Text('كاش عند الصعود', style: TextStyle(fontFamily: 'Cairo')),
                      value: 'cash',
                      groupValue: _showVisaForm ? 'visa' : 'cash',
                      onChanged: (value) {
                        setState(() {
                          _showVisaForm = false;
                        });
                      },
                      activeColor: const Color(0xFF127C8A),
                    ),
                  ],
                ),
              ),
              
              // نموذج الفيزا
              if (_showVisaForm) ...[
                const SizedBox(height: 20),
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
                        'معلومات الفيزا',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF127C8A),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _cardNumberController,
                        decoration: const InputDecoration(
                          labelText: 'رقم البطاقة',
                          prefixIcon: Icon(Icons.credit_card, color: Color(0xFF127C8A)),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال رقم البطاقة';
                          }
                          if (value.length < 16) {
                            return 'رقم البطاقة غير صحيح';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _cardHolderController,
                        decoration: const InputDecoration(
                          labelText: 'اسم حامل البطاقة',
                          prefixIcon: Icon(Icons.person, color: Color(0xFF127C8A)),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال اسم حامل البطاقة';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _expiryController,
                              decoration: const InputDecoration(
                                labelText: 'تاريخ الانتهاء (MM/YY)',
                                prefixIcon: Icon(Icons.calendar_today, color: Color(0xFF127C8A)),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى إدخال تاريخ الانتهاء';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _cvvController,
                              decoration: const InputDecoration(
                                labelText: 'CVV',
                                prefixIcon: Icon(Icons.security, color: Color(0xFF127C8A)),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى إدخال CVV';
                                }
                                if (value.length < 3) {
                                  return 'CVV غير صحيح';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
              
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
                    ? const CircularProgressIndicator(color: Colors.white)
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
} 
