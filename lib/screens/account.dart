import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../l10n/app_localizations.dart';

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
  bool isLoggedIn = false;

  void _showLoginDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Section
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.person,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              
              // Title
              Text(
                AppLocalizations.of(context)!.welcomeToSham,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              
              // Subtitle
              Text(
                AppLocalizations.of(context)!.loginToAccess,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Social Login Section
              const Text(
                'تسجيل الدخول عبر',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),

              // Social Login Buttons
              _buildSocialLoginButton(
                icon: Icons.apple,
                title: AppLocalizations.of(context)!.loginWithApple,
                color: Colors.black,
                onTap: () => _loginWithApple(),
              ),
              const SizedBox(height: 10),
              _buildSocialLoginButton(
                icon: Icons.g_mobiledata,
                title: AppLocalizations.of(context)!.loginWithGoogle,
                color: const Color(0xFFDB4437),
                onTap: () => _loginWithGoogle(),
              ),
              const SizedBox(height: 10),
              _buildSocialLoginButton(
                icon: Icons.facebook,
                title: AppLocalizations.of(context)!.loginWithFacebook,
                color: const Color(0xFF4267B2),
                onTap: () => _loginWithFacebook(),
              ),
              const SizedBox(height: 10),
              _buildSocialLoginButton(
                icon: Icons.phone,
                title: AppLocalizations.of(context)!.loginWithPhone,
                color: const Color(0xFF25D366),
                onTap: () => _loginWithPhone(),
              ),
              const SizedBox(height: 20),

              // Divider
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      AppLocalizations.of(context)!.or,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),

              // Create Account Section
              const Text(
                'إنشاء حساب جديد',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),

              // Create Account Button
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () => _showCreateAccountDialog(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.createNewAccount,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      inherit: false,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Cancel Button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white, size: 20),
        label: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            inherit: false,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
        ),
      ),
    );
  }

  void _showCreateAccountDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.person_add,
                color: Color(0xFF1E3A8A),
                size: 25,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)!.createAccountTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'أدخل بياناتك الشخصية',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              
              // Full Name
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.fullName,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  prefixIcon: const Icon(Icons.person, size: 20),
                ),
              ),
              const SizedBox(height: 12),
              
              // Email
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.email,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  prefixIcon: const Icon(Icons.email, size: 20),
                ),
              ),
              const SizedBox(height: 12),
              
              // Phone Number
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.phoneNumber,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  prefixIcon: const Icon(Icons.phone, size: 20),
                ),
              ),
              const SizedBox(height: 12),
              
              // Password
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.password,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  prefixIcon: const Icon(Icons.lock, size: 20),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                userName = nameController.text;
                userEmail = emailController.text;
                userPhone = phoneController.text;
                isLoggedIn = true;
              });
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('تم إنشاء الحساب بنجاح!'),
                  backgroundColor: Colors.green.shade600,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.create,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                inherit: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _loginWithApple() {
    setState(() {
      userName = 'أحمد محمد';
      userEmail = 'ahmed@example.com';
      userPhone = '+963912345678';
      isLoggedIn = true;
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم تسجيل الدخول عبر Apple بنجاح!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _loginWithGoogle() {
    setState(() {
      userName = 'فاطمة علي';
      userEmail = 'fatima@example.com';
      userPhone = '+963987654321';
      isLoggedIn = true;
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم تسجيل الدخول عبر Google بنجاح!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _loginWithFacebook() {
    setState(() {
      userName = 'محمد حسن';
      userEmail = 'mohammed@example.com';
      userPhone = '+963955555555';
      isLoggedIn = true;
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم تسجيل الدخول عبر Facebook بنجاح!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _loginWithPhone() {
    final phoneController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'تسجيل الدخول عبر الهاتف',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.enterPhone,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.phoneNumber,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                userName = 'مستخدم الهاتف';
                userEmail = 'phone@example.com';
                userPhone = phoneController.text;
                isLoggedIn = true;
              });
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم تسجيل الدخول عبر الهاتف بنجاح!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text(
              AppLocalizations.of(context)!.sendCode,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                inherit: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.selectLanguage,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('العربية', 'ar', Icons.language),
            _buildLanguageOption('English', 'en', Icons.language),
            _buildLanguageOption('Türkçe', 'tr', Icons.language),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String title, String languageCode, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1E3A8A)),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        widget.onLocaleChange?.call(Locale(languageCode));
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم تغيير اللغة إلى $title'),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  // Profile Avatar
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: isLoggedIn
                        ? Text(
                            userName?.substring(0, 1) ?? 'م',
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E3A8A),
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            size: 50,
                            color: Color(0xFF1E3A8A),
                          ),
                  ),
                  const SizedBox(height: 16),
                  // User Info
                  if (isLoggedIn) ...[
                    Text(
                      userName ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userEmail ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userPhone ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ] else ...[
                    Text(
                      AppLocalizations.of(context)!.welcomeBack,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.loginToAccess,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _showLoginDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1E3A8A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E3A8A),
                          inherit: false,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Settings Section
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // App Settings
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.appSettings,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E3A8A),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Language Setting
                          _buildSettingItem(
                            icon: Icons.language,
                            title: AppLocalizations.of(context)!.selectLanguage,
                            subtitle: 'العربية / English / Türkçe',
                            onTap: _showLanguageDialog,
                          ),
                          const Divider(),
                          // Dark Mode Setting
                          _buildSettingItem(
                            icon: Icons.dark_mode,
                            title: AppLocalizations.of(context)!.darkModeTitle,
                            subtitle: AppLocalizations.of(context)!.darkModeSubtitle,
                            trailing: Switch(
                              value: isDark,
                              onChanged: (value) {
                                setState(() => isDark = value);
                                widget.onToggleDarkMode?.call();
                              },
                            ),
                          ),
                          const Divider(),
                          // Notifications Setting
                          _buildSettingItem(
                            icon: Icons.notifications,
                            title: AppLocalizations.of(context)!.notificationsTitle,
                            subtitle: AppLocalizations.of(context)!.notificationsSubtitle,
                            trailing: Switch(
                              value: !notificationsMuted,
                              onChanged: (value) {
                                setState(() => notificationsMuted = !value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // User Information (if logged in)
                  if (isLoggedIn) ...[
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.accountInfo,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E3A8A),
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildInfoItem(
                              icon: Icons.person,
                              title: AppLocalizations.of(context)!.fullName,
                              value: userName ?? '---',
                            ),
                            const SizedBox(height: 12),
                            _buildInfoItem(
                              icon: Icons.email,
                              title: AppLocalizations.of(context)!.email,
                              value: userEmail ?? '---',
                            ),
                            const SizedBox(height: 12),
                            _buildInfoItem(
                              icon: Icons.phone,
                              title: AppLocalizations.of(context)!.phoneNumber,
                              value: userPhone ?? '---',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // About App
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.aboutApp,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E3A8A),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            AppLocalizations.of(context)!.appDescription,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            AppLocalizations.of(context)!.version,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Logout Button (if logged in)
                   if (isLoggedIn)
                     SizedBox(
                       width: double.infinity,
                       height: 50,
                       child: ElevatedButton.icon(
                         onPressed: () {
                           setState(() {
                             isLoggedIn = false;
                             userName = null;
                             userEmail = null;
                             userPhone = null;
                           });
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                               content: Text('تم تسجيل الخروج بنجاح'),
                               backgroundColor: Colors.orange,
                             ),
                           );
                         },
                         icon: const Icon(Icons.logout),
                         label: Text(
                           AppLocalizations.of(context)!.logout,
                           style: const TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.w600,
                             color: Colors.white,
                             inherit: false,
                           ),
                         ),
                         style: ElevatedButton.styleFrom(
                           backgroundColor: Colors.red,
                           foregroundColor: Colors.white,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(12),
                           ),
                         ),
                       ),
                     ),
                 ],
               ),
             ),
           ],
         ),
       ),
     );
   }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF1E3A8A).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: const Color(0xFF1E3A8A)),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF1E3A8A).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF1E3A8A), size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
} 
