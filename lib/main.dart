import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'screens/account.dart';
import 'screens/home_page.dart';
import 'screens/chatbot.dart';
import 'screens/my_trips.dart';
import 'screens/favorite_screen.dart';
import 'package:provider/provider.dart';
import 'models/app_state.dart';
import 'models/admin_state.dart';
import 'models/favorites_provider.dart';
import 'screens/admin_login_screen.dart';
import 'screens/bus_company_selection_screen.dart';
import 'screens/bus_seat_selection.dart';
import 'screens/booking_summary_screen.dart';
import 'screens/phone_code_screen.dart';
import 'screens/ticket_screen.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyTripsProvider()),
        ChangeNotifierProvider(create: (_) => AdminState()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const ShamApp(),
    ),
  );
}

class ShamApp extends StatefulWidget {
  const ShamApp({super.key});

  @override
  State<ShamApp> createState() => _ShamAppState();
}

class _ShamAppState extends State<ShamApp> {
  Locale _locale = const Locale('ar');
  bool _isDarkMode = false;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
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
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF1E3A8A),
        scaffoldBackgroundColor: const Color(0xFF181A20),
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
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MainNavigation(onLocaleChange: setLocale, onToggleDarkMode: toggleDarkMode, isDarkMode: _isDarkMode),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final void Function(Locale) onLocaleChange;
  final VoidCallback onToggleDarkMode;
  final bool isDarkMode;
  const MainNavigation({super.key, required this.onLocaleChange, required this.onToggleDarkMode, required this.isDarkMode});

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
      const MyTripsScreen(),
      const FavoriteScreen(),
      AccountScreen(onLocaleChange: widget.onLocaleChange, onToggleDarkMode: widget.onToggleDarkMode),
    ];
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'شات بوت',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: 'رحلاتي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'المفضلة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'ملفي الشخصي',
          ),
        ],
      ),
    );
  }
}
