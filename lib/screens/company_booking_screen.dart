import 'package:flutter/material.dart';

// صفحة الملف الشخصي مع عرض الشركات المفضلة
class AccountScreen extends StatefulWidget {
  final void Function(Locale)? onLocaleChange;
  final VoidCallback? onToggleDarkMode;
  const AccountScreen({super.key, this.onLocaleChange, this.onToggleDarkMode});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool notificationsMuted = false;
  bool isDark = false;
  String? userName;
  String? userEmail;
  String? userPhone;

  void _showLoginDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('تسجيل الدخول'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'الاسم'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'البريد الإلكتروني'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'رقم الهاتف'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'كلمة المرور'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  userName = nameController.text;
                  userEmail = emailController.text;
                  userPhone = phoneController.text;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('تم تسجيل الدخول بنجاح!')),
                );
              },
              child: Text('دخول'),
            ),
          ],
        );
      },
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('اختر اللغة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('العربية'),
                onTap: () {
                  widget.onLocaleChange?.call(const Locale('ar'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('English'),
                onTap: () {
                  widget.onLocaleChange?.call(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // بيانات وهمية للشركات المفضلة (يمكن استبدالها ببيانات حقيقية لاحقاً)
  final List<Map<String, String>> favoriteCompanies = const [
    {'name': 'شركة الشام للنقل', 'logo': ''},
    {'name': 'شركة الأمانة', 'logo': ''},
    {'name': 'شركة الاتحاد', 'logo': ''},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // عنوان الصفحة
            Text(
              'ملفي الشخصي',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF127C8A),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // بيانات المستخدم (وهمية)
            CircleAvatar(
              radius: 44,
              backgroundColor: Color(0xFF10B981),
              child: Icon(Icons.person, size: 54, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              'مرحباً بك في مواصلات الشام',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'سجّل الدخول للاستفادة من جميع الميزات',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 15,
                color: Color(0xFF6B7280),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            // زر تسجيل الدخول
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF127C8A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              icon: Icon(Icons.login),
              label: Text('تسجيل الدخول'),
              onPressed: _showLoginDialog,
            ),
            const SizedBox(height: 24),
            // إعدادات التطبيق
            Card(
              margin: const EdgeInsets.only(bottom: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // تغيير اللغة
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF7C2D),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: Icon(Icons.language),
                      label: Text('تغيير اللغة'),
                      onPressed: _showLanguageDialog,
                    ),
                    const SizedBox(height: 12),
                    // الوضع الداكن
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6366F1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: Icon(Icons.dark_mode),
                      label: Text('الوضع الداكن'),
                      onPressed: () {
                        widget.onToggleDarkMode?.call();
                        setState(() => isDark = !isDark);
                      },
                    ),
                    const SizedBox(height: 12),
                    // كتم الإشعارات
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: notificationsMuted ? Color(0xFF94A3B8) : Color(0xFF6B7280),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: Icon(notificationsMuted ? Icons.notifications_off : Icons.notifications_active),
                      label: Text(notificationsMuted ? 'الإشعارات مكتومة' : 'كتم الإشعارات'),
                      onPressed: () {
                        setState(() => notificationsMuted = !notificationsMuted);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(notificationsMuted ? 'تم كتم الإشعارات' : 'تم تفعيل الإشعارات')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            // ملخص المستخدم
            Card(
              margin: const EdgeInsets.only(bottom: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('معلومات المستخدم', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('الاسم: ${userName ?? '---'}'),
                    Text('البريد الإلكتروني: ${userEmail ?? '---'}'),
                    Text('رقم الهاتف: ${userPhone ?? '---'}'),
                  ],
                ),
              ),
            ),
            // حول التطبيق
            Card(
              margin: const EdgeInsets.only(bottom: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('حول التطبيق', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('تطبيق مواصلات الشام لحجز الرحلات العامة (باص، قطار، طيارة) بسهولة وأمان.'),
                    const SizedBox(height: 8),
                    Text('الإصدار: 1.0.0'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
