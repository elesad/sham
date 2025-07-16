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
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _idController = TextEditingController();
  final _passportController = TextEditingController();
  
  String _selectedNationality = 'سوريا';
  String _selectedCountryCode = '+963';
  DateTime? _birthDate;
  bool _isForeigner = false;
  bool _isLoading = false;
  bool _showVisaForm = false;
  bool _showCodeVerification = false;
  final _codeController = TextEditingController();
  String _sentCode = '';
  
  // معلومات الفيزا
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  final List<Map<String, String>> _countryCodes = [
    {'code': '+963', 'country': 'سوريا'},
    {'code': '+961', 'country': 'لبنان'},
    {'code': '+962', 'country': 'الأردن'},
    {'code': '+20', 'country': 'مصر'},
    {'code': '+966', 'country': 'السعودية'},
    {'code': '+971', 'country': 'الإمارات'},
    {'code': '+965', 'country': 'الكويت'},
    {'code': '+974', 'country': 'قطر'},
    {'code': '+973', 'country': 'البحرين'},
    {'code': '+968', 'country': 'عمان'},
    {'code': '+964', 'country': 'العراق'},
    {'code': '+98', 'country': 'إيران'},
    {'code': '+90', 'country': 'تركيا'},
    {'code': '+49', 'country': 'ألمانيا'},
    {'code': '+33', 'country': 'فرنسا'},
    {'code': '+44', 'country': 'بريطانيا'},
    {'code': '+39', 'country': 'إيطاليا'},
    {'code': '+34', 'country': 'إسبانيا'},
    {'code': '+7', 'country': 'روسيا'},
    {'code': '+86', 'country': 'الصين'},
    {'code': '+81', 'country': 'اليابان'},
    {'code': '+82', 'country': 'كوريا الجنوبية'},
    {'code': '+91', 'country': 'الهند'},
    {'code': '+92', 'country': 'باكستان'},
    {'code': '+93', 'country': 'أفغانستان'},
    {'code': '+1', 'country': 'الولايات المتحدة'},
    {'code': '+1', 'country': 'كندا'},
    {'code': '+61', 'country': 'أستراليا'},
    {'code': '+55', 'country': 'البرازيل'},
    {'code': '+54', 'country': 'الأرجنتين'},
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _idController.dispose();
    _passportController.dispose();
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _selectBirthDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
      firstDate: DateTime.now().subtract(const Duration(days: 36500)), // 100 years ago
      lastDate: DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
    );
    if (picked != null) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  void _sendCode() {
    // محاكاة إرسال كود
    setState(() {
      _sentCode = '1234';
      _showCodeVerification = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم إرسال كود التحقق إلى رقم الهاتف'),
        backgroundColor: Color(0xFF127C8A),
      ),
    );
  }

  void _verifyCodeAndBook() {
    if (_codeController.text == _sentCode) {
      // الانتقال إلى صفحة التذكرة
      VisaInfo? visaInfo;
      if (_showVisaForm) {
        visaInfo = VisaInfo(
          cardNumber: _cardNumberController.text,
          cardHolderName: _cardHolderController.text,
          expiryDate: _expiryController.text,
          cvv: _cvvController.text,
        );
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FlightTicketScreen(
            flight: widget.flight,
            company: widget.company,
            passengerName: '${_firstNameController.text} ${_lastNameController.text}',
            passengerEmail: _emailController.text,
            passengerPhone: '$_selectedCountryCode${_phoneController.text}',
            passengerId: _isForeigner ? _passportController.text : _idController.text,
            nationality: _selectedNationality,
            birthDate: _birthDate!,
            visaInfo: visaInfo,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الكود غير صحيح'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _confirmBooking() async {
    if (!_formKey.currentState!.validate()) return;
    if (_birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى اختيار تاريخ الميلاد'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isLoading = false);
      _sendCode();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showCodeVerification) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          title: const Text('تأكيد رقم الهاتف', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF127C8A),
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.sms, size: 60, color: Color(0xFF127C8A)),
                const SizedBox(height: 24),
                const Text('أدخل الكود المرسل إلى رقم الهاتف', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'الكود',
                    border: OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: 'Cairo', fontSize: 20, letterSpacing: 8),
                  maxLength: 4,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _verifyCodeAndBook,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF127C8A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('تأكيد', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      );
    }
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
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF127C8A).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.flight,
                                  color: Color(0xFF127C8A),
                                  size: 20,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${widget.flight.arrivalTime.difference(widget.flight.departureTime).inHours}h ${widget.flight.arrivalTime.difference(widget.flight.departureTime).inMinutes % 60}m',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 10,
                                  color: Colors.grey[600],
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
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12,
                                  color: Colors.grey[600],
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
                    
                    // الاسم الأول
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'الاسم الأول',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال الاسم الأول';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // اللقب
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'اللقب',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال اللقب';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // البريد الإلكتروني
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'البريد الإلكتروني',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال البريد الإلكتروني';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'يرجى إدخال بريد إلكتروني صحيح';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // رقم الهاتف مع مفتاح الدولة
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: DropdownButtonFormField<String>(
                            value: _selectedCountryCode,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                            ),
                            items: _countryCodes.map((country) {
                              return DropdownMenuItem(
                                value: country['code'],
                                child: Text(
                                  '${country['code']} ${country['country']}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCountryCode = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'رقم الهاتف',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.phone),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال رقم الهاتف';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // تاريخ الميلاد
                    GestureDetector(
                      onTap: _selectBirthDate,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[400]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Color(0xFF127C8A)),
                            const SizedBox(width: 12),
                            Text(
                              _birthDate != null 
                                ? '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}'
                                : 'تاريخ الميلاد',
                              style: TextStyle(
                                color: _birthDate != null ? Colors.black : Colors.grey[600],
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // الجنسية
                    DropdownButtonFormField<String>(
                      value: _selectedNationality,
                      decoration: const InputDecoration(
                        labelText: 'الجنسية',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.flag),
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
                    const SizedBox(height: 16),
                    
                    // رقم الهوية أو الجواز
                    TextFormField(
                      controller: _isForeigner ? _passportController : _idController,
                      decoration: InputDecoration(
                        labelText: _isForeigner ? 'رقم الجواز' : 'رقم الهوية',
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(_isForeigner ? Icons.work : Icons.badge),
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
                    
                    // خيارات الدفع
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<bool>(
                            title: const Text('فيزا / ماستركارد', style: TextStyle(fontFamily: 'Cairo')),
                            value: true,
                            groupValue: _showVisaForm,
                            onChanged: (value) {
                              setState(() {
                                _showVisaForm = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<bool>(
                            title: const Text('كاش عند الوصول', style: TextStyle(fontFamily: 'Cairo')),
                            value: false,
                            groupValue: _showVisaForm,
                            onChanged: (value) {
                              setState(() {
                                _showVisaForm = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    // نموذج الفيزا
                    if (_showVisaForm) ...[
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _cardNumberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'رقم البطاقة',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.credit_card),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال رقم البطاقة';
                          }
                          if (value.length < 16) {
                            return 'رقم البطاقة يجب أن يكون 16 رقم';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _cardHolderController,
                        decoration: const InputDecoration(
                          labelText: 'اسم حامل البطاقة',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال اسم حامل البطاقة';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _expiryController,
                              decoration: const InputDecoration(
                                labelText: 'تاريخ الانتهاء (MM/YY)',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.calendar_today),
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
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'CVV',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.security),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى إدخال CVV';
                                }
                                if (value.length < 3) {
                                  return 'CVV يجب أن يكون 3 أرقام';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // زر تأكيد الحجز
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
