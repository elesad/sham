import 'package:flutter/material.dart';
import 'admin_models.dart' as admin_models;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AdminState extends ChangeNotifier {
  admin_models.AdminUser? _currentAdmin;
  admin_models.AdminStats? _stats;
  List<admin_models.Booking> _bookings = [];
  List<admin_models.User> _users = [];
  List<admin_models.Notification> _notifications = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  admin_models.AdminUser? get currentAdmin => _currentAdmin;
  admin_models.AdminStats? get stats => _stats;
  List<admin_models.Booking> get bookings => _bookings;
  List<admin_models.User> get users => _users;
  List<admin_models.Notification> get notifications => _notifications;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Check if admin is logged in
  bool get isLoggedIn => _currentAdmin != null;

  // Initialize admin state
  Future<void> initialize() async {
    await _loadAdminFromStorage();
    if (_currentAdmin != null) {
      await _loadStats();
      await _loadBookings();
      await _loadUsers();
      await _loadNotifications();
    }
  }

  // Admin Authentication
  Future<bool> login(String username, String password) async {
    _setLoading(true);
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock admin data - in real app, this would come from API
      final admin = admin_models.AdminUser(
        id: 'admin_1',
        username: username,
        email: 'admin@sham.com',
        fullName: 'مدير النظام',
        role: 'admin',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        lastLogin: DateTime.now(),
        permissions: ['all'],
      );

      _currentAdmin = admin;
      await _saveAdminToStorage(admin);
      await _loadStats();
      await _loadBookings();
      await _loadUsers();
      await _loadNotifications();
      
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('فشل في تسجيل الدخول: $e');
      _setLoading(false);
      return false;
    }
  }

  Future<void> logout() async {
    _currentAdmin = null;
    _bookings.clear();
    _users.clear();
    _notifications.clear();
    _stats = null;
    await _clearAdminStorage();
    notifyListeners();
  }

  // Stats Management
  Future<void> _loadStats() async {
    try {
      // Mock stats data
      _stats = admin_models.AdminStats(
        totalUsers: 1250,
        totalBookings: 3456,
        totalRevenue: 12500000,
        activeBookings: 234,
        pendingBookings: 45,
        cancelledBookings: 12,
        bookingsByType: {
          'bus': 1200,
          'train': 800,
          'flight': 600,
          'hotel': 856,
        },
        revenueByMonth: {
          'يناير': 1200000,
          'فبراير': 1350000,
          'مارس': 1420000,
          'أبريل': 1580000,
          'مايو': 1650000,
          'يونيو': 1800000,
        },
      );
      notifyListeners();
    } catch (e) {
      _setError('فشل في تحميل الإحصائيات: $e');
    }
  }

  // Bookings Management
  Future<void> _loadBookings() async {
    try {
      // Mock bookings data
      _bookings = [
        admin_models.Booking(
          id: 'booking_1',
          userId: 'user_1',
          userName: 'أحمد محمد',
          userEmail: 'ahmed@example.com',
          bookingType: 'bus',
          status: 'confirmed',
          amount: 25000,
          bookingDate: DateTime.now().subtract(const Duration(days: 2)),
          travelDate: DateTime.now().add(const Duration(days: 5)),
          fromLocation: 'دمشق',
          toLocation: 'حلب',
          companyName: 'شركة الشام للنقل',
          seatNumber: 'A12',
          passengers: 1,
        ),
        admin_models.Booking(
          id: 'booking_2',
          userId: 'user_2',
          userName: 'فاطمة علي',
          userEmail: 'fatima@example.com',
          bookingType: 'hotel',
          status: 'pending',
          amount: 150000,
          bookingDate: DateTime.now().subtract(const Duration(days: 1)),
          travelDate: DateTime.now().add(const Duration(days: 3)),
          fromLocation: 'دمشق',
          toLocation: 'دمشق',
          companyName: 'فندق الشام الكبير',
          roomType: 'غرفة مزدوجة',
          passengers: 2,
        ),
        admin_models.Booking(
          id: 'booking_3',
          userId: 'user_3',
          userName: 'محمد حسن',
          userEmail: 'mohammed@example.com',
          bookingType: 'train',
          status: 'completed',
          amount: 35000,
          bookingDate: DateTime.now().subtract(const Duration(days: 5)),
          travelDate: DateTime.now().subtract(const Duration(days: 1)),
          fromLocation: 'حلب',
          toLocation: 'اللاذقية',
          companyName: 'سكك حديد سوريا',
          seatNumber: 'B8',
          passengers: 1,
        ),
      ];
      notifyListeners();
    } catch (e) {
      _setError('فشل في تحميل الحجوزات: $e');
    }
  }

  Future<void> updateBookingStatus(String bookingId, String newStatus) async {
    try {
      final index = _bookings.indexWhere((booking) => booking.id == bookingId);
      if (index != -1) {
        final booking = _bookings[index];
        _bookings[index] = admin_models.Booking(
          id: booking.id,
          userId: booking.userId,
          userName: booking.userName,
          userEmail: booking.userEmail,
          bookingType: booking.bookingType,
          status: newStatus,
          amount: booking.amount,
          bookingDate: booking.bookingDate,
          travelDate: booking.travelDate,
          fromLocation: booking.fromLocation,
          toLocation: booking.toLocation,
          companyName: booking.companyName,
          seatNumber: booking.seatNumber,
          roomType: booking.roomType,
          passengers: booking.passengers,
          specialRequests: booking.specialRequests,
        );
        notifyListeners();
      }
    } catch (e) {
      _setError('فشل في تحديث حالة الحجز: $e');
    }
  }

  Future<void> deleteBooking(String bookingId) async {
    try {
      _bookings.removeWhere((booking) => booking.id == bookingId);
      notifyListeners();
    } catch (e) {
      _setError('فشل في حذف الحجز: $e');
    }
  }

  // Users Management
  Future<void> _loadUsers() async {
    try {
      // Mock users data
      _users = [
        admin_models.User(
          id: 'user_1',
          name: 'أحمد محمد',
          email: 'ahmed@example.com',
          phone: '+963912345678',
          registrationDate: DateTime.now().subtract(const Duration(days: 30)),
          lastLogin: DateTime.now().subtract(const Duration(hours: 2)),
          totalBookings: 5,
          totalSpent: 125000,
        ),
        admin_models.User(
          id: 'user_2',
          name: 'فاطمة علي',
          email: 'fatima@example.com',
          phone: '+963987654321',
          registrationDate: DateTime.now().subtract(const Duration(days: 15)),
          lastLogin: DateTime.now().subtract(const Duration(hours: 1)),
          totalBookings: 3,
          totalSpent: 450000,
        ),
        admin_models.User(
          id: 'user_3',
          name: 'محمد حسن',
          email: 'mohammed@example.com',
          phone: '+963955555555',
          registrationDate: DateTime.now().subtract(const Duration(days: 7)),
          lastLogin: DateTime.now().subtract(const Duration(minutes: 30)),
          totalBookings: 2,
          totalSpent: 70000,
        ),
      ];
      notifyListeners();
    } catch (e) {
      _setError('فشل في تحميل المستخدمين: $e');
    }
  }

  Future<void> updateUserStatus(String userId, bool isActive) async {
    try {
      final index = _users.indexWhere((user) => user.id == userId);
      if (index != -1) {
        final user = _users[index];
        _users[index] = admin_models.User(
          id: user.id,
          name: user.name,
          email: user.email,
          phone: user.phone,
          registrationDate: user.registrationDate,
          lastLogin: user.lastLogin,
          isActive: isActive,
          totalBookings: user.totalBookings,
          totalSpent: user.totalSpent,
          avatar: user.avatar,
        );
        notifyListeners();
      }
    } catch (e) {
      _setError('فشل في تحديث حالة المستخدم: $e');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      _users.removeWhere((user) => user.id == userId);
      notifyListeners();
    } catch (e) {
      _setError('فشل في حذف المستخدم: $e');
    }
  }

  // Notifications Management
  Future<void> _loadNotifications() async {
    try {
      // Mock notifications data
      _notifications = [
        admin_models.Notification(
          id: 'notif_1',
          title: 'حجز جديد',
          message: 'تم إنشاء حجز جديد من المستخدم أحمد محمد',
          type: 'info',
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        admin_models.Notification(
          id: 'notif_2',
          title: 'دفعة مكتملة',
          message: 'تم إكمال عملية الدفع للحجز رقم #12345',
          type: 'success',
          createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        admin_models.Notification(
          id: 'notif_3',
          title: 'مستخدم جديد',
          message: 'انضم مستخدم جديد إلى التطبيق',
          type: 'info',
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
      ];
      notifyListeners();
    } catch (e) {
      _setError('فشل في تحميل الإشعارات: $e');
    }
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      final index = _notifications.indexWhere((notif) => notif.id == notificationId);
      if (index != -1) {
        final notification = _notifications[index];
        _notifications[index] = admin_models.Notification(
          id: notification.id,
          title: notification.title,
          message: notification.message,
          type: notification.type,
          createdAt: notification.createdAt,
          isRead: true,
          targetUserId: notification.targetUserId,
          targetUserType: notification.targetUserType,
        );
        notifyListeners();
      }
    } catch (e) {
      _setError('فشل في تحديث الإشعار: $e');
    }
  }

  Future<void> sendNotification(String title, String message, String type, {String? targetUserId, String? targetUserType}) async {
    try {
      final notification = admin_models.Notification(
        id: 'notif_${DateTime.now().millisecondsSinceEpoch}',
        title: title,
        message: message,
        type: type,
        createdAt: DateTime.now(),
        targetUserId: targetUserId,
        targetUserType: targetUserType,
      );
      _notifications.insert(0, notification);
      notifyListeners();
    } catch (e) {
      _setError('فشل في إرسال الإشعار: $e');
    }
  }

  // Storage Management
  Future<void> _saveAdminToStorage(admin_models.AdminUser admin) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('admin_user', jsonEncode(admin.toJson()));
    } catch (e) {
      _setError('فشل في حفظ بيانات المدير: $e');
    }
  }

  Future<void> _loadAdminFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final adminJson = prefs.getString('admin_user');
      if (adminJson != null) {
        final adminData = jsonDecode(adminJson);
        _currentAdmin = admin_models.AdminUser.fromJson(adminData);
        notifyListeners();
      }
    } catch (e) {
      _setError('فشل في تحميل بيانات المدير: $e');
    }
  }

  Future<void> _clearAdminStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('admin_user');
    } catch (e) {
      _setError('فشل في مسح بيانات المدير: $e');
    }
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Search and filter methods
  List<admin_models.Booking> searchBookings(String query) {
    return _bookings.where((booking) =>
        booking.userName.toLowerCase().contains(query.toLowerCase()) ||
        booking.userEmail.toLowerCase().contains(query.toLowerCase()) ||
        booking.bookingType.toLowerCase().contains(query.toLowerCase()) ||
        booking.status.toLowerCase().contains(query.toLowerCase()) ||
        booking.fromLocation.toLowerCase().contains(query.toLowerCase()) ||
        booking.toLocation.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  List<admin_models.User> searchUsers(String query) {
    return _users.where((user) =>
        user.name.toLowerCase().contains(query.toLowerCase()) ||
        user.email.toLowerCase().contains(query.toLowerCase()) ||
        user.phone.contains(query)
    ).toList();
  }

  List<admin_models.Booking> filterBookingsByType(String type) {
    if (type == 'all') return _bookings;
    return _bookings.where((booking) => booking.bookingType == type).toList();
  }

  List<admin_models.Booking> filterBookingsByStatus(String status) {
    if (status == 'all') return _bookings;
    return _bookings.where((booking) => booking.status == status).toList();
  }
} 