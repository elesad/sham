import 'package:flutter/material.dart';

class BookingSummaryScreen extends StatefulWidget {
  final String companyName;
  final String route;
  final String date;
  final String time;
  final String seatNumber;
  final String busType;
  final String duration;
  final String price;
  final String currency;
  final String gender;

  const BookingSummaryScreen({
    super.key,
    required this.companyName,
    required this.route,
    required this.date,
    required this.time,
    required this.seatNumber,
    required this.busType,
    required this.duration,
    required this.price,
    required this.currency,
    required this.gender,
  });

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  bool supportService = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isTurkish = true;

  @override
  Widget build(BuildContext context) {
    double total = double.tryParse(widget.price) ?? 0;
    if (supportService) total += 16;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ملخص الحجز'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // معلومات الرحلة
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.companyName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text(widget.busType, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(widget.route, style: const TextStyle(fontSize: 15)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.date_range, size: 18, color: Colors.blueGrey),
                        const SizedBox(width: 4),
                        Text(widget.date),
                        const SizedBox(width: 12),
                        Icon(Icons.access_time, size: 18, color: Colors.blueGrey),
                        const SizedBox(width: 4),
                        Text(widget.time),
                        const SizedBox(width: 12),
                        Icon(Icons.event_seat, size: 18, color: Colors.blueGrey),
                        const SizedBox(width: 4),
                        Text('مقعد ${widget.seatNumber} (${widget.gender})'),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('المدة التقريبية: ${widget.duration}'),
                  ],
                ),
              ),
            ),
            // معلومات الاتصال
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('معلومات الاتصال', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'هاتف المحمول',
                        prefixText: '+90 ',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'عنوان بريدك الإلكتروني',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // معلومات الراكب
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('معلومات راكب المغادرة', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('معلومات ركاب المقعد (${widget.gender}) ${widget.seatNumber}', style: const TextStyle(fontSize: 13)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'اسم العائلة',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: idController,
                      decoration: const InputDecoration(
                        labelText: 'رقم الهوية التركية',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                          value: isTurkish,
                          onChanged: (v) => setState(() => isTurkish = v ?? true),
                        ),
                        const Text('ليس مواطناً تركياً'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // دعم خدمة العملاء
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('دعم كبار الشخصيات', style: TextStyle(fontSize: 12)),
                        ),
                        const SizedBox(width: 8),
                        const Text('دعم خدمة العملاء ذو الأولوية', style: TextStyle(fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Switch(
                          value: supportService,
                          onChanged: (v) => setState(() => supportService = v),
                        ),
                        Text('16.00 ليرة تركية', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('اختر امتياز الدعم ذو الأولوية واحصل على دعم مباشر على مدار الساعة طوال أيام الأسبوع من مركز الاتصال الخاص بنا في تركيا.'),
                    const SizedBox(height: 6),
                    const Text('✓ دعم مباشر على مدار الساعة طوال أيام الأسبوع'),
                    const Text('✓ امتياز المعالجة الأولية لإلغاء التذاكر والتغييرات'),
                    const Text('✓ خدمة مركز الاتصال المباشر دون انتظار في الطابور'),
                    const Text('✓ دعم أولوية لمدة 10 أيام بعد رحلتك'),
                  ],
                ),
              ),
            ),
            // ملخص السعر
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('المبلغ الإجمالي', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('${total.toStringAsFixed(2)} ${widget.currency}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
                  ],
                ),
              ),
            ),
            // زر الدفع
            ElevatedButton(
              onPressed: () {
                // منطق الانتقال إلى الدفع
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم الانتقال إلى الدفع!')));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('انتقل إلى الدفع', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
} 