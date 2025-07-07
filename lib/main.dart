import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const ShamApp());
}

class ShamApp extends StatefulWidget {
  const ShamApp({super.key});

  @override
  State<ShamApp> createState() => _ShamAppState();
}

class _ShamAppState extends State<ShamApp> {
  Locale _locale = const Locale('ar');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'مواصلات الشام',
      locale: _locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        fontFamily: 'Cairo',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E3A8A),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E3A8A),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF1E3A8A), width: 2),
          ),
          labelStyle: const TextStyle(
            fontFamily: 'Cairo',
            color: Color(0xFF6B7280),
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
      home: MainNavigation(onLocaleChange: setLocale),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final void Function(Locale) onLocaleChange;
  const MainNavigation({super.key, required this.onLocaleChange});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomePage(),
      const ChatBotScreen(),
      const MyTripsScreen(), // إضافة صفحة رحلاتي
      AccountScreen(onLocaleChange: widget.onLocaleChange),
    ];
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF1E3A8A),
        unselectedItemColor: const Color(0xFF6B7280),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)?.welcome ?? 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat),
            label: AppLocalizations.of(context)?.chatBot ?? 'شات بوت',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.confirmation_number),
            label: AppLocalizations.of(context)?.myTrips ?? 'رحلاتي',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppLocalizations.of(context)?.myProfile ?? 'ملفي الشخصي',
          ),
        ],
      ),
    );
  }
}

// الصفحة الرئيسية الجديدة (OOP)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchScreen();
  }
}

// صفحة الملف الشخصي
class AccountScreen extends StatefulWidget {
  final void Function(Locale)? onLocaleChange;
  const AccountScreen({super.key, this.onLocaleChange});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDarkMode = false;
  bool isNotificationsEnabled = true;
  String selectedLanguage = 'العربية';
  bool isLoggedIn = false;
  
  // متغيرات تسجيل الدخول
  bool isLogin = true;
  bool isEmailLogin = true;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return Directionality(
      textDirection: locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  AppLocalizations.of(context)?.myProfile ?? 'ملفي الشخصي',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Card - معلومات المستخدم
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E3A8A).withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          isLoggedIn ? Icons.person : Icons.person_outline,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        isLoggedIn 
                            ? AppLocalizations.of(context)?.welcomeBack ?? 'أهلاً وسهلاً'
                            : AppLocalizations.of(context)?.hello ?? 'مرحباً بك في مواصلات الشام',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isLoggedIn 
                            ? AppLocalizations.of(context)?.enjoyServices ?? 'استمتع بخدماتنا المتقدمة'
                            : AppLocalizations.of(context)?.loginToAccess ?? 'سجل دخولك للوصول إلى جميع الخدمات',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 16,
                          fontFamily: 'Cairo',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // تسجيل الدخول (أولاً)
                if (!isLoggedIn) ...[
                  _buildLoginButton(),
                  const SizedBox(height: 24),
                ],
                
                // إعدادات التطبيق
                _buildAppSettingsSection(),
                
                const SizedBox(height: 24),
                
                // حول التطبيق والمساعدة
                _buildAboutAndHelpSection(),
                
                const SizedBox(height: 24),
                
                // إذا كان مسجل دخول، اعرض معلومات الحساب
                if (isLoggedIn) ...[
                  _buildAccountInfoSection(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // قسم حول التطبيق والمساعدة
  Widget _buildAboutAndHelpSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.info,
                  color: Color(0xFF10B981),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context)?.aboutAndHelp ?? 'حول التطبيق والمساعدة',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // حول التطبيق
          _buildAboutItem(
            icon: Icons.apps,
            title: AppLocalizations.of(context)?.aboutApp ?? 'حول التطبيق',
            subtitle: AppLocalizations.of(context)?.version ?? 'إصدار 1.0.0 - مواصلات الشام',
            onTap: () {
              _showAboutDialog();
            },
          ),
          
          const SizedBox(height: 16),
          
          // المساعدة
          _buildAboutItem(
            icon: Icons.help,
            title: AppLocalizations.of(context)?.help ?? 'المساعدة',
            subtitle: AppLocalizations.of(context)?.helpGuide ?? 'دليل الاستخدام والأسئلة الشائعة',
            onTap: () {
              _showHelpDialog();
            },
          ),
          
          const SizedBox(height: 16),
          
          // سياسة الخصوصية
          _buildAboutItem(
            icon: Icons.privacy_tip,
            title: AppLocalizations.of(context)?.privacyPolicy ?? 'سياسة الخصوصية',
            subtitle: AppLocalizations.of(context)?.privacyInfo ?? 'كيف نحمي بياناتك الشخصية',
            onTap: () {
              _showPrivacyDialog();
            },
          ),
          
          const SizedBox(height: 16),
          
          // شروط الاستخدام
          _buildAboutItem(
            icon: Icons.description,
            title: 'شروط الاستخدام',
            subtitle: 'الشروط والأحكام',
            onTap: () {
              _showTermsDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF1E3A8A),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                      fontFamily: 'Cairo',
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF6B7280),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.aboutApp ?? 'حول التطبيق'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)?.appTitle ?? 'مواصلات الشام',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)?.version ?? 'إصدار 1.0.0',
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)?.appDescription ?? 'تطبيق شامل لحجز رحلات النقل العام في سوريا، يتيح لك حجز رحلات الباص والقطار والطيران بسهولة وأمان.',
              style: const TextStyle(
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)?.close ?? 'إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.help ?? 'المساعدة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)?.howToUse ?? 'كيفية استخدام التطبيق:',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${AppLocalizations.of(context)?.step1 ?? '1. اختر نوع النقل (باص، قطار، طيران)'}\n'
              '${AppLocalizations.of(context)?.step2 ?? '2. حدد نقطة الانطلاق والوجهة'}\n'
              '${AppLocalizations.of(context)?.step3 ?? '3. اختر التاريخ المطلوب'}\n'
              '${AppLocalizations.of(context)?.step4 ?? '4. اختر الشركة والمقعد'}\n'
              '${AppLocalizations.of(context)?.step5 ?? '5. أكمل بيانات الحجز والدفع'}\n'
              '${AppLocalizations.of(context)?.step6 ?? '6. احصل على التذكرة'}',
              style: const TextStyle(
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)?.close ?? 'إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.privacyPolicy ?? 'سياسة الخصوصية'),
        content: Text(
          AppLocalizations.of(context)?.privacyDescription ?? 'نحن نحمي بياناتك الشخصية ولا نشاركها مع أي طرف ثالث. جميع المعاملات مشفرة وآمنة.',
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)?.close ?? 'إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.termsOfService ?? 'شروط الاستخدام'),
        content: Text(
          AppLocalizations.of(context)?.termsDescription ?? 'باستخدام هذا التطبيق، فإنك توافق على شروط الاستخدام وسياسة الخصوصية.',
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)?.close ?? 'إغلاق'),
          ),
        ],
      ),
    );
  }

  // قسم إعدادات التطبيق
  Widget _buildAppSettingsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.settings,
                  color: Color(0xFF1E3A8A),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context)?.appSettings ?? 'إعدادات التطبيق',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // اختيار اللغة
          _buildLanguageSelector(),
          
          const SizedBox(height: 16),
          
          // الوضع الداكن
          _buildSettingItem(
            icon: Icons.dark_mode,
            title: AppLocalizations.of(context)?.darkModeTitle ?? 'الوضع الداكن',
            subtitle: AppLocalizations.of(context)?.darkModeSubtitle ?? 'تفعيل المظهر الداكن',
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
              activeColor: const Color(0xFF1E3A8A),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // الإشعارات
          _buildSettingItem(
            icon: Icons.notifications,
            title: AppLocalizations.of(context)?.notificationsTitle ?? 'الإشعارات',
            subtitle: AppLocalizations.of(context)?.notificationsSubtitle ?? 'تفعيل إشعارات التطبيق',
            trailing: Switch(
              value: isNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  isNotificationsEnabled = value;
                });
              },
              activeColor: const Color(0xFF1E3A8A),
            ),
          ),
        ],
      ),
    );
  }

  // اختيار اللغة مع واجهة جميلة
  Widget _buildLanguageSelector() {
    final languages = [
      {'code': 'ar', 'name': 'العربية', 'flag': '🇸🇾'},
      {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
      {'code': 'tr', 'name': 'Türkçe', 'flag': '🇹🇷'},
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)?.chooseLanguage ?? 'اختر اللغة',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
            fontFamily: 'Cairo',
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: languages.map((lang) {
            final isSelected = selectedLanguage == lang['name'];
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedLanguage = lang['name']!;
                  });
                  // تغيير اللغة فوراً
                  switch (lang['code']) {
                    case 'ar':
                      widget.onLocaleChange?.call(const Locale('ar'));
                      break;
                    case 'en':
                      widget.onLocaleChange?.call(const Locale('en'));
                      break;
                    case 'tr':
                      widget.onLocaleChange?.call(const Locale('tr'));
                      break;
                  }
                  // إعادة بناء الشاشة لتطبيق الترجمة
                  Future.delayed(const Duration(milliseconds: 100), () {
                    if (mounted) {
                      setState(() {});
                    }
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF1E3A8A) : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        lang['flag']!,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lang['name']!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : const Color(0xFF1F2937),
                          fontFamily: 'Cairo',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // عنصر إعداد
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF1E3A8A),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                    fontFamily: 'Cairo',
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  // زر تسجيل الدخول
  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A8A).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          _showBeautifulLoginDialog();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.login, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              AppLocalizations.of(context)?.login ?? 'تسجيل الدخول',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // نافذة تسجيل الدخول الجميلة
  void _showBeautifulLoginDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.person_add,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)?.welcomeToSham ?? 'مرحباً بك في مواصلات الشام',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)?.chooseLoginMethod ?? 'اختر طريقة تسجيل الدخول المفضلة لديك',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14,
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                
                // Social Login Buttons
                _buildSocialLoginButton(
                  icon: Icons.apple,
                  text: AppLocalizations.of(context)?.loginWithApple ?? 'تسجيل الدخول بـ Apple',
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                    // TODO: Implement Apple Sign In
                  },
                ),
                const SizedBox(height: 12),
                _buildSocialLoginButton(
                  icon: Icons.android,
                  text: AppLocalizations.of(context)?.loginWithGoogle ?? 'تسجيل الدخول بـ Google',
                  color: const Color(0xFFDB4437),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // TODO: Implement Google Sign In
                  },
                ),
                const SizedBox(height: 12),
                _buildSocialLoginButton(
                  icon: Icons.facebook,
                  text: AppLocalizations.of(context)?.loginWithFacebook ?? 'تسجيل الدخول بـ Facebook',
                  color: const Color(0xFF4267B2),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // TODO: Implement Facebook Sign In
                  },
                ),
                const SizedBox(height: 12),
                _buildSocialLoginButton(
                  icon: Icons.phone,
                  text: AppLocalizations.of(context)?.loginWithPhone ?? 'تسجيل الدخول برقم الهاتف',
                  color: const Color(0xFF25D366),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showPhoneLoginDialog();
                  },
                ),
                const SizedBox(height: 16),
                
                // Divider
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        AppLocalizations.of(context)?.or ?? 'أو',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Create Account Button
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showCreateAccountDialog();
                    },
                    child: Text(
                      AppLocalizations.of(context)?.createNewAccount ?? 'إنشاء حساب جديد',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Close Button
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    AppLocalizations.of(context)?.cancel ?? 'إلغاء',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 14,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // زر تسجيل الدخول الاجتماعي
  Widget _buildSocialLoginButton({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: 24),
        label: Text(
          text,
          style: TextStyle(
            color: const Color(0xFF1F2937),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
      ),
    );
  }

  // نافذة تسجيل الدخول بالهاتف
  void _showPhoneLoginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.phone,
                    color: Color(0xFF1E3A8A),
                    size: 48,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)?.loginWithPhone ?? 'تسجيل الدخول برقم الهاتف',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'أدخل رقم هاتفك لاستلام رمز التحقق',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'رقم الهاتف',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('إلغاء'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // TODO: Implement phone verification
                        },
                        child: const Text('إرسال الرمز'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // نافذة إنشاء حساب جديد
  void _showCreateAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.person_add,
                    color: Color(0xFF1E3A8A),
                    size: 48,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'إنشاء حساب جديد',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'الاسم الكامل',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: !isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'تأكيد كلمة المرور',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('إلغاء'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // TODO: Implement account creation
                        },
                        child: const Text('إنشاء الحساب'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // قسم معلومات الحساب
  Widget _buildAccountInfoSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.account_circle,
                  color: Color(0xFF1E3A8A),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'معلومات الحساب',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildAccountInfoItem('الاسم', 'أحمد محمد'),
          _buildAccountInfoItem('البريد الإلكتروني', 'ahmed@example.com'),
          _buildAccountInfoItem('رقم الهاتف', '+963 999 123 456'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isLoggedIn = false;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('تسجيل الخروج'),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                fontFamily: 'Cairo',
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}

// صفحة رحلاتي
class MyTripsScreen extends StatelessWidget {
  const MyTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return Directionality(
      textDirection: locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.confirmation_number, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Text('رحلاتي'),
            ],
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.confirmation_number,
                size: 64,
                color: Color(0xFF1E3A8A),
              ),
              SizedBox(height: 16),
              Text(
                'رحلاتي',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(height: 8),
              Text(
                'ستظهر هنا جميع رحلاتك المحجوزة',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// شاشة البحث الرئيسية
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? fromCity;
  String? toCity;
  DateTime? selectedDate;
  String selectedTransportType = 'bus';

  final List<String> cities = [
    'دمشق',
    'حلب',
    'حمص',
    'حماة',
    'اللاذقية',
    'طرطوس',
    'إدلب',
    'ريف دمشق',
    'دير الزور',
    'الحسكة',
    'الرقة',
    'السويداء',
    'درعا',
    'القنيطرة',
  ];

  final List<String> flightCities = [
    'دمشق',
    'حلب',
  ];

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);
    return Directionality(
      textDirection: currentLocale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.search, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  AppLocalizations.of(context)?.appTitle ?? 'مواصلات الشام',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // TODO: Show notifications
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Transport Type Selection
                Container(
                  padding: const EdgeInsets.all(20),
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
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.directions_bus,
                              color: Color(0xFF1E3A8A),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'نوع النقل',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTransportTypeButton(
                              icon: Icons.directions_bus,
                              label: 'باص',
                              type: 'bus',
                              isSelected: selectedTransportType == 'bus',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTransportTypeButton(
                              icon: Icons.train,
                              label: 'قطار',
                              type: 'train',
                              isSelected: selectedTransportType == 'train',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTransportTypeButton(
                              icon: Icons.flight,
                              label: 'طيران',
                              type: 'flight',
                              isSelected: selectedTransportType == 'flight',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Search Form
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: Color(0xFF1E3A8A),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'تفاصيل الرحلة',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // From and To Cities in one row with swap button
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () async {
                                final selected = await Navigator.of(context).push<String>(
                                  MaterialPageRoute(
                                    builder: (_) => GovernoratePickerScreen(
                                      title: 'من أين',
                                      governorates: cities,
                                    ),
                                  ),
                                );
                                if (selected != null) {
                                  setState(() {
                                    fromCity = selected;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: const Color(0xFFE5E7EB)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined, size: 20, color: Color(0xFF1E3A8A)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        fromCity ?? 'من أين',
                                        style: TextStyle(
                                          color: fromCity == null ? const Color(0xFF6B7280) : Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E3A8A),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                              onPressed: () {
                                setState(() {
                                  final temp = fromCity;
                                  fromCity = toCity;
                                  toCity = temp;
                                });
                              },
                              icon: const Icon(
                                Icons.swap_horiz,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () async {
                                final selected = await Navigator.of(context).push<String>(
                                  MaterialPageRoute(
                                    builder: (_) => GovernoratePickerScreen(
                                      title: 'إلى أين',
                                      governorates: cities,
                                    ),
                                  ),
                                );
                                if (selected != null) {
                                  setState(() {
                                    toCity = selected;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: const Color(0xFFE5E7EB)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 20, color: Color(0xFF1E3A8A)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        toCity ?? 'إلى أين',
                                        style: TextStyle(
                                          color: toCity == null ? const Color(0xFF6B7280) : Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Date Selection
                      InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                            locale: const Locale('ar'),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color(0xFF1E3A8A),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (date != null) {
                            setState(() {
                              selectedDate = date;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: Color(0xFF6B7280),
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  selectedDate == null
                                      ? 'اختر التاريخ'
                                      : '${selectedDate!.year}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.day.toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    color: selectedDate == null ? const Color(0xFF6B7280) : Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Search Button
                      ElevatedButton(
                        onPressed: (fromCity != null && toCity != null && selectedDate != null)
                            ? () {
                                if (selectedTransportType == 'bus') {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => BusCompaniesScreen(
                                        from: fromCity!,
                                        to: toCity!,
                                        date: selectedDate!,
                                      ),
                                    ),
                                  );
                                } else if (selectedTransportType == 'flight') {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => FlightResultsScreen(
                                        from: fromCity!,
                                        to: toCity!,
                                        date: selectedDate!,
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => BookingConfirmationScreen(
                                        from: fromCity!,
                                        to: toCity!,
                                        date: selectedDate!,
                                        busCompany: selectedTransportType == 'train' ? 'شركة السكك الحديدية' : 'شركة الطيران السورية',
                                        departureTime: '08:00 ص',
                                        arrivalTime: '12:00 م',
                                        price: selectedTransportType == 'train' ? 1500.0 : 15000.0,
                                        seatNumber: 'A12',
                                      ),
                                    ),
                                  );
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (fromCity != null && toCity != null && selectedDate != null)
                              ? const Color(0xFF1E3A8A)
                              : const Color(0xFFE5E7EB),
                          foregroundColor: (fromCity != null && toCity != null && selectedDate != null)
                              ? Colors.white
                              : const Color(0xFF9CA3AF),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.search),
                            const SizedBox(width: 8),
                            Text(
                              selectedTransportType == 'bus' ? 'عرض خط الباص' :
                              selectedTransportType == 'train' ? 'عرض رحلات القطار' :
                              'عرض رحلات الطيران',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // حجزاتي في الأسفل
                Container(
                  padding: const EdgeInsets.all(20),
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
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const MyTripsScreen()),
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.confirmation_number,
                            color: Color(0xFF1E3A8A),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'حجزاتي',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F2937),
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              const Text(
                                'عرض جميع رحلاتك المحجوزة',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF6B7280),
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF6B7280),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransportTypeButton({
    required IconData icon,
    required String label,
    required String type,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTransportType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3A8A) : Colors.transparent,
          border: Border.all(
            color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFFE5E7EB),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : const Color(0xFF6B7280),
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF6B7280),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        isDense: true,
      ),
      items: items.map((city) => DropdownMenuItem(
        value: city,
        child: Text(
          city,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 13),
        ),
      )).toList(),
      isExpanded: true,
      menuMaxHeight: 200,
      dropdownColor: Colors.white,
      style: const TextStyle(
        fontSize: 13,
        color: Color(0xFF1F2937),
        fontFamily: 'Cairo',
      ),
      icon: const Icon(Icons.arrow_drop_down, size: 20),
    );
  }
}

// شاشة الشات بوت
class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return Directionality(
      textDirection: locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.chat, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Text('شات بوت'),
            ],
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chat_bubble_outline,
                size: 64,
                color: Color(0xFF1E3A8A),
              ),
              SizedBox(height: 16),
              Text(
                'شات بوت',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(height: 8),
              Text(
                'مساعدك الذكي لحجز الرحلات',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// شاشة شركات الباص
class BusCompaniesScreen extends StatelessWidget {
  final String from;
  final String to;
  final DateTime date;
  
  const BusCompaniesScreen({
    super.key,
    required this.from,
    required this.to,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final busCompanies = [
      BusCompany(
        name: 'شركة الشام للنقل',
        rating: 4.5,
        price: 2500.0,
        departureTime: '08:00 ص',
        arrivalTime: '12:00 م',
        duration: '4 ساعات',
        amenities: ['مكيف', 'واي فاي', 'مشروبات مجانية'],
        availableSeats: 15,
      ),
      BusCompany(
        name: 'شركة دمشق للنقل',
        rating: 4.3,
        price: 2200.0,
        departureTime: '09:30 ص',
        arrivalTime: '01:30 م',
        duration: '4 ساعات',
        amenities: ['مكيف', 'مشروبات مجانية'],
        availableSeats: 8,
      ),
      BusCompany(
        name: 'شركة النور للنقل',
        rating: 4.7,
        price: 2800.0,
        departureTime: '07:00 ص',
        arrivalTime: '11:00 ص',
        duration: '4 ساعات',
        amenities: ['مكيف', 'واي فاي', 'وجبة خفيفة', 'مشروبات مجانية'],
        availableSeats: 22,
      ),
      BusCompany(
        name: 'شركة الأمانة للنقل',
        rating: 4.1,
        price: 2000.0,
        departureTime: '10:00 ص',
        arrivalTime: '02:00 م',
        duration: '4 ساعات',
        amenities: ['مكيف'],
        availableSeats: 12,
      ),
    ];

    final locale = Localizations.localeOf(context);
    return Directionality(
      textDirection: locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.directions_bus, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Text('شركات الباص'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Route Info Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E3A8A).withValues(alpha: 0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$from → $to',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${busCompanies.length} شركة متاحة',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Bus Companies List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: busCompanies.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final company = busCompanies[index];
                    return _buildCompanyCard(context, company);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyCard(BuildContext context, BusCompany company) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.directions_bus,
                    color: Color(0xFF1E3A8A),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        company.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                          fontFamily: 'Cairo',
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            company.rating.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B7280),
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${company.availableSeats} مقعد متاح',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Time and Duration
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.departure_board,
                            color: Color(0xFF1E3A8A),
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            company.departureTime,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'إقلاع',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
                
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          company.duration,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF1E3A8A),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            company.arrivalTime,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                              fontFamily: 'Cairo',
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFF1E3A8A),
                            size: 16,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'وصول',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Amenities
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: company.amenities.map((amenity) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  amenity,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF1E3A8A),
                    fontFamily: 'Cairo',
                  ),
                ),
              )).toList(),
            ),
            
            const SizedBox(height: 16),
            
            // Price and Book Button
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${company.price.toStringAsFixed(0)} ل.س',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A),
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const Text(
                        'سعر التذكرة',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SeatSelectionScreen(
                          trip: TripResult(
                            company: company.name,
                            time: company.departureTime,
                            price: company.price,
                          ),
                          from: from,
                          to: to,
                          date: date,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'اختيار المقعد',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// نموذج بيانات شركة الباص
class BusCompany {
  final String name;
  final double rating;
  final double price;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final List<String> amenities;
  final int availableSeats;
  
  BusCompany({
    required this.name,
    required this.rating,
    required this.price,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.amenities,
    required this.availableSeats,
  });
}

// شاشة تأكيد الحجز المحسنة
class BookingConfirmationScreen extends StatelessWidget {
  final String from;
  final String to;
  final DateTime date;
  final String busCompany;
  final String departureTime;
  final String arrivalTime;
  final double price;
  final String seatNumber;
  final String? customerName;
  final String? customerPhone;
  final String? customerId;
  final String? paymentMethod;
  
  const BookingConfirmationScreen({
    super.key,
    required this.from,
    required this.to,
    required this.date,
    required this.busCompany,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.seatNumber,
    this.customerName,
    this.customerPhone,
    this.customerId,
    this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final bookingNumber = 'BK${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';
    
    return Directionality(
      textDirection: locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.confirmation_number, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Text('تأكيد الحجز'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Success Message
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF34D399)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF10B981).withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'تم تأكيد الحجز بنجاح!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'رقم الحجز: $bookingNumber',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 16,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Ticket Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.confirmation_number,
                              color: Color(0xFF1E3A8A),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'التذكرة',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Ticket Content
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF1E3A8A).withValues(alpha: 0.3),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            // Header
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        busCompany,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1E3A8A),
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                      Text(
                                        'رقم الحجز: $bookingNumber',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF6B7280),
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.directions_bus,
                                    color: Color(0xFF1E3A8A),
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 20),
                            
                            // Route Info
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'من',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF6B7280),
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                      Text(
                                        from,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1F2937),
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                      Text(
                                        departureTime,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF6B7280),
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Color(0xFF1E3A8A),
                                    size: 20,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'إلى',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF6B7280),
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                      Text(
                                        to,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1F2937),
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                      Text(
                                        arrivalTime,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF6B7280),
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 20),
                            
                            // Trip Details
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTicketDetail('التاريخ', '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}'),
                                ),
                                Expanded(
                                  child: _buildTicketDetail('المقاعد', seatNumber),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 12),
                            
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTicketDetail('السعر', '${price.toStringAsFixed(0)} ل.س'),
                                ),
                                Expanded(
                                  child: _buildTicketDetail('طريقة الدفع', paymentMethod == 'visa' ? 'فيزا' : 'عند الصعود'),
                                ),
                              ],
                            ),
                            
                            if (customerName != null) ...[
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTicketDetail('الاسم', customerName!),
                                  ),
                                  Expanded(
                                    child: _buildTicketDetail('الهاتف', customerPhone ?? ''),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _sendTicketByEmail(context, bookingNumber);
                        },
                        icon: const Icon(Icons.email),
                        label: const Text('إرسال بالإيميل'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3A8A),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _downloadTicket(context, bookingNumber);
                        },
                        icon: const Icon(Icons.download),
                        label: const Text('تنزيل التذكرة'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B7280),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'العودة للصفحة الرئيسية',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTicketDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF6B7280),
            fontFamily: 'Cairo',
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }

  void _sendTicketByEmail(BuildContext context, String bookingNumber) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إرسال التذكرة'),
        content: const Text(
          'سيتم إرسال التذكرة إلى بريدك الإلكتروني المسجل.',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم إرسال التذكرة إلى بريدك الإلكتروني'),
                  backgroundColor: Color(0xFF10B981),
                ),
              );
            },
            child: const Text('إرسال'),
          ),
        ],
      ),
    );
  }

  void _downloadTicket(BuildContext context, String bookingNumber) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('جاري تنزيل التذكرة...'),
        backgroundColor: const Color(0xFF1E3A8A),
        action: SnackBarAction(
          label: 'إلغاء',
          textColor: Colors.white,
          onPressed: () {
            // Cancel download
          },
        ),
      ),
    );
    
    // Simulate download completion
    Future.delayed(const Duration(seconds: 2), () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم تنزيل التذكرة بنجاح'),
          backgroundColor: Color(0xFF10B981),
        ),
      );
    });
  }
}

// شاشة نتائج الطيران
class FlightResultsScreen extends StatelessWidget {
  final String from;
  final String to;
  final DateTime date;
  const FlightResultsScreen({super.key, required this.from, required this.to, required this.date});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return Directionality(
      textDirection: locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.flight, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Text('رحلات الطيران المتاحة'),
            ],
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.flight,
                size: 64,
                color: Color(0xFF1E3A8A),
              ),
              SizedBox(height: 16),
              Text(
                'رحلات الطيران',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(height: 8),
              Text(
                'اختر رحلة الطيران المفضلة',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// نموذج بيانات رحلة الطيران
class FlightResult {
  final String company;
  final String flightNumber;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final double price;
  final String aircraft;
  final int seatsAvailable;
  final List<String> amenities;
  
  FlightResult({
    required this.company,
    required this.flightNumber,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.price,
    required this.aircraft,
    required this.seatsAvailable,
    required this.amenities,
  });
}

// شاشة اختيار المقاعد المحسنة
class SeatSelectionScreen extends StatefulWidget {
  final TripResult trip;
  final String from;
  final String to;
  final DateTime date;
  
  const SeatSelectionScreen({
    super.key,
    required this.trip,
    required this.from,
    required this.to,
    required this.date,
  });

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  Set<int> selectedSeats = {};
  Set<int> occupiedSeats = {2, 5, 8, 12, 15, 18, 22, 25, 28, 32, 35, 38};
  String? selectedGender; // 'male' or 'female'
  
  // Bus layout configuration - هيكل الباص 2+1
  final int totalSeats = 40;
  final int rows = 13; // 13 صف
  final int seatsPerRow = 3; // 3 مقاعد في كل صف (2+1)

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return Directionality(
      textDirection: locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.event_seat, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Text('اختيار المقعد'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Trip Info Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E3A8A).withValues(alpha: 0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${widget.from} → ${widget.to}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${widget.trip.company} - ${widget.trip.time}',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${widget.date.year}/${widget.date.month.toString().padLeft(2, '0')}/${widget.date.day.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Gender Selection Card
                Container(
                  padding: const EdgeInsets.all(20),
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
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Color(0xFF1E3A8A),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'اختر الجنس',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildGenderButton(
                              gender: 'male',
                              label: 'ذكر',
                              icon: Icons.male,
                              color: const Color(0xFF1E3A8A),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildGenderButton(
                              gender: 'female',
                              label: 'أنثى',
                              icon: Icons.female,
                              color: const Color(0xFFE91E63),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Bus Layout - هيكل الباص 2+1
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Bus Header
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.event_seat,
                              color: Color(0xFF1E3A8A),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'هيكل الباص (2+1)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Bus Layout Grid - 2+1 configuration
                      Column(
                        children: List.generate(rows, (rowIndex) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Row number
                                Container(
                                  width: 30,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${rowIndex + 1}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6B7280),
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                
                                // Left seat (A)
                                _buildSeat(
                                  seatNumber: (rowIndex * 3) + 1,
                                  isSelected: selectedSeats.contains((rowIndex * 3) + 1),
                                  isOccupied: occupiedSeats.contains((rowIndex * 3) + 1),
                                  seatLabel: 'A${rowIndex + 1}',
                                ),
                                
                                const SizedBox(width: 8),
                                
                                // Middle seat (B)
                                _buildSeat(
                                  seatNumber: (rowIndex * 3) + 2,
                                  isSelected: selectedSeats.contains((rowIndex * 3) + 2),
                                  isOccupied: occupiedSeats.contains((rowIndex * 3) + 2),
                                  seatLabel: 'B${rowIndex + 1}',
                                ),
                                
                                const SizedBox(width: 16),
                                
                                // Right seat (C) - single seat
                                _buildSeat(
                                  seatNumber: (rowIndex * 3) + 3,
                                  isSelected: selectedSeats.contains((rowIndex * 3) + 3),
                                  isOccupied: occupiedSeats.contains((rowIndex * 3) + 3),
                                  seatLabel: 'C${rowIndex + 1}',
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Legend
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildLegendItem(
                            color: const Color(0xFF1E3A8A),
                            label: 'متاح',
                          ),
                          _buildLegendItem(
                            color: const Color(0xFFE5E7EB),
                            label: 'محجوز',
                          ),
                          _buildLegendItem(
                            color: const Color(0xFF10B981),
                            label: 'مختار',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Selected Seats Summary
                if (selectedSeats.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF10B981).withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.check_circle,
                                color: Color(0xFF10B981),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'المقاعد المختارة',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF10B981),
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: selectedSeats.map((seat) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'مقعد $seat',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          )).toList(),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'السعر الإجمالي: ${(widget.trip.price * selectedSeats.length).toStringAsFixed(0)} ل.س',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF10B981),
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  ),
                
                const SizedBox(height: 24),
                
                // Confirm Button
                ElevatedButton(
                  onPressed: (selectedSeats.isNotEmpty && selectedGender != null) ? () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('تأكيد المقاعد'),
                        content: Text('تم اختيار المقاعد: ${selectedSeats.join(', ')} (${selectedGender == 'male' ? 'ذكر' : 'أنثى'})'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('إلغاء'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CustomerRegistrationScreen(
                                    trip: widget.trip,
                                    from: widget.from,
                                    to: widget.to,
                                    date: widget.date,
                                    selectedSeats: selectedSeats.toList(),
                                    selectedGender: selectedGender!,
                                  ),
                                ),
                              );
                            },
                            child: const Text('تأكيد'),
                          ),
                        ],
                      ),
                    );
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (selectedSeats.isNotEmpty && selectedGender != null)
                        ? const Color(0xFF1E3A8A)
                        : const Color(0xFFE5E7EB),
                    foregroundColor: (selectedSeats.isNotEmpty && selectedGender != null)
                        ? Colors.white
                        : const Color(0xFF9CA3AF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    (selectedSeats.isNotEmpty && selectedGender != null) ? 'تأكيد المقاعد' : 'اختر الجنس والمقعد',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeat({
    required int seatNumber,
    required bool isSelected,
    required bool isOccupied,
    required String seatLabel,
  }) {
    Color seatColor;
    Color textColor;
    
    if (isOccupied) {
      seatColor = const Color(0xFFE5E7EB);
      textColor = const Color(0xFF9CA3AF);
    } else if (isSelected) {
      seatColor = const Color(0xFF10B981);
      textColor = Colors.white;
    } else {
      seatColor = const Color(0xFF1E3A8A);
      textColor = Colors.white;
    }
    
    return GestureDetector(
      onTap: isOccupied ? null : () {
        setState(() {
          if (isSelected) {
            selectedSeats.remove(seatNumber);
          } else {
            selectedSeats.add(seatNumber);
          }
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF10B981) : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color(0xFF10B981).withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_seat,
              color: textColor,
              size: 20,
            ),
            Text(
              seatLabel,
              style: TextStyle(
                color: textColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderButton({
    required String gender,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          border: Border.all(
            color: isSelected ? color : const Color(0xFFE5E7EB),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : color,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : color,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF6B7280),
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }
}

// نموذج بيانات الرحلة
class TripResult {
  final String company;
  final String time;
  final double price;
  
  TripResult({
    required this.company,
    required this.time,
    required this.price,
  });
}

// شاشة تسجيل بيانات المشتري
class CustomerRegistrationScreen extends StatefulWidget {
  final TripResult trip;
  final String from;
  final String to;
  final DateTime date;
  final List<int> selectedSeats;
  final String selectedGender;
  
  const CustomerRegistrationScreen({
    super.key,
    required this.trip,
    required this.from,
    required this.to,
    required this.date,
    required this.selectedSeats,
    required this.selectedGender,
  });

  @override
  State<CustomerRegistrationScreen> createState() => _CustomerRegistrationScreenState();
}

class _CustomerRegistrationScreenState extends State<CustomerRegistrationScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  String paymentMethod = 'cash'; // 'cash' or 'visa'
  bool isIdPassport = false; // false for ID, true for passport

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return Directionality(
      textDirection: locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.person_add, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Text('تسجيل البيانات'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Trip Summary Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E3A8A).withValues(alpha: 0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${widget.from} → ${widget.to}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${widget.trip.company} - ${widget.trip.time}',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'المقاعد: ${widget.selectedSeats.join(', ')} (${widget.selectedGender == 'male' ? 'ذكر' : 'أنثى'})',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'السعر الإجمالي: ${(widget.trip.price * widget.selectedSeats.length).toStringAsFixed(0)} ل.س',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Personal Information Form
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Color(0xFF1E3A8A),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'البيانات الشخصية',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // First Name
                      TextField(
                        controller: firstNameController,
                        decoration: const InputDecoration(
                          labelText: 'الاسم الأول',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Last Name
                      TextField(
                        controller: lastNameController,
                        decoration: const InputDecoration(
                          labelText: 'اللقب',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Phone Number
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'رقم الهاتف',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // ID Type Selection
                      Row(
                        children: [
                          Expanded(
                            child: _buildIdTypeButton(
                              label: 'رقم الهوية',
                              isSelected: !isIdPassport,
                              onTap: () {
                                setState(() {
                                  isIdPassport = false;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildIdTypeButton(
                              label: 'جواز السفر',
                              isSelected: isIdPassport,
                              onTap: () {
                                setState(() {
                                  isIdPassport = true;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // ID/Passport Number
                      TextField(
                        controller: idController,
                        decoration: InputDecoration(
                          labelText: isIdPassport ? 'رقم جواز السفر' : 'رقم الهوية',
                          prefixIcon: const Icon(Icons.credit_card),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Payment Method Selection
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.payment,
                              color: Color(0xFF10B981),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'طريقة الدفع',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      Row(
                        children: [
                          Expanded(
                            child: _buildPaymentMethodButton(
                              icon: Icons.credit_card,
                              label: 'فيزا',
                              isSelected: paymentMethod == 'visa',
                              onTap: () {
                                setState(() {
                                  paymentMethod = 'visa';
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildPaymentMethodButton(
                              icon: Icons.money,
                              label: 'عند الصعود',
                              isSelected: paymentMethod == 'cash',
                              onTap: () {
                                setState(() {
                                  paymentMethod = 'cash';
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Confirm Button
                ElevatedButton(
                  onPressed: _canProceed() ? () {
                    _showVerificationDialog();
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _canProceed() ? const Color(0xFF1E3A8A) : const Color(0xFFE5E7EB),
                    foregroundColor: _canProceed() ? Colors.white : const Color(0xFF9CA3AF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'تأكيد الحجز',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _canProceed() {
    return firstNameController.text.isNotEmpty &&
           lastNameController.text.isNotEmpty &&
           phoneController.text.isNotEmpty &&
           idController.text.isNotEmpty;
  }

  Widget _buildIdTypeButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3A8A) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFFE5E7EB),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF1F2937),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildPaymentMethodButton({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF10B981) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF10B981) : const Color(0xFFE5E7EB),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : const Color(0xFF10B981),
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF1F2937),
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVerificationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحجز'),
        content: const Text(
          'سيتم إرسال رمز التحقق إلى رقم هاتفك لتأكيد الحجز.',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showVerificationCodeDialog();
            },
            child: const Text('إرسال الرمز'),
          ),
        ],
      ),
    );
  }

  void _showVerificationCodeDialog() {
    final verificationCode = '123456'; // رمز تحقق عشوائي
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('رمز التحقق'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'تم إرسال رمز التحقق إلى رقم هاتفك:',
              style: TextStyle(fontFamily: 'Cairo'),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                verificationCode,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                  fontFamily: 'Cairo',
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'أدخل الرمز أعلاه لتأكيد الحجز',
              style: TextStyle(fontFamily: 'Cairo'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _proceedToTicketGeneration();
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _proceedToTicketGeneration() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => BookingConfirmationScreen(
          from: widget.from,
          to: widget.to,
          date: widget.date,
          busCompany: widget.trip.company,
          departureTime: widget.trip.time,
          arrivalTime: '${widget.trip.time.split(' ')[0]} + 4 ساعات',
          price: widget.trip.price * widget.selectedSeats.length,
          seatNumber: widget.selectedSeats.join(', '),
          customerName: '${firstNameController.text} ${lastNameController.text}',
          customerPhone: phoneController.text,
          customerId: idController.text,
          paymentMethod: paymentMethod,
        ),
      ),
    );
  }
}

// تعريف GovernoratePickerScreen إذا لم يكن موجوداً
class GovernoratePickerScreen extends StatelessWidget {
  final String title;
  final List<String> governorates;
  const GovernoratePickerScreen({super.key, required this.title, required this.governorates});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontFamily: 'Cairo')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: governorates.map((gov) => ListTile(
            title: Text(gov, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.of(context).pop(gov);
            },
          )).toList(),
        ),
      ),
    );
  }
}
