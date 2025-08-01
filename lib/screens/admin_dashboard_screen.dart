import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/admin_state.dart';
import '../models/admin_models.dart' as admin_models;
import 'admin_bookings_screen.dart';
import 'admin_users_screen.dart';
import 'admin_notifications_screen.dart';
import 'admin_reports_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final adminState = Provider.of<AdminState>(context, listen: false);
      adminState.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar Navigation
          Container(
            width: 250,
            color: const Color(0xFF1E3A8A),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.admin_panel_settings,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'لوحة التحكم',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'مواصلات الشام',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.white24),
                // Navigation Items
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      _buildNavItem(0, Icons.dashboard, 'الرئيسية'),
                      _buildNavItem(1, Icons.confirmation_number, 'الحجوزات'),
                      _buildNavItem(2, Icons.people, 'المستخدمين'),
                      _buildNavItem(3, Icons.notifications, 'الإشعارات'),
                      _buildNavItem(4, Icons.analytics, 'التقارير'),
                    ],
                  ),
                ),
                // Logout Button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Consumer<AdminState>(
                    builder: (context, adminState, child) {
                      return ElevatedButton.icon(
                        onPressed: () async {
                          await adminState.logout();
                          if (mounted) {
                            Navigator.of(context).pushReplacementNamed('/admin-login');
                          }
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('تسجيل الخروج'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 45),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String title) {
    final isSelected = _selectedIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFF1E3A8A) : Colors.white70,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFF1E3A8A) : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        tileColor: isSelected ? Colors.white : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return const DashboardHome();
      case 1:
        return const AdminBookingsScreen();
      case 2:
        return const AdminUsersScreen();
      case 3:
        return const AdminNotificationsScreen();
      case 4:
        return const AdminReportsScreen();
      default:
        return const DashboardHome();
    }
  }
}

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Consumer<AdminState>(
        builder: (context, adminState, child) {
          if (adminState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final stats = adminState.stats;
          if (stats == null) {
            return const Center(child: Text('لا توجد بيانات متاحة'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const Text(
                      'لوحة التحكم',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    const Spacer(),
                    Consumer<AdminState>(
                      builder: (context, adminState, child) {
                        final admin = adminState.currentAdmin;
                        return Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: const Color(0xFF1E3A8A),
                              child: Text(
                                admin?.fullName.substring(0, 1) ?? 'م',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              admin?.fullName ?? 'مدير النظام',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Stats Cards
                Row(
                  children: [
                    Expanded(child: _buildStatCard('إجمالي المستخدمين', stats.totalUsers.toString(), Icons.people, Colors.blue)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildStatCard('إجمالي الحجوزات', stats.totalBookings.toString(), Icons.confirmation_number, Colors.green)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildStatCard('إجمالي الإيرادات', '${(stats.totalRevenue / 1000).toStringAsFixed(0)} ألف', Icons.attach_money, Colors.orange)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildStatCard('الحجوزات النشطة', stats.activeBookings.toString(), Icons.check_circle, Colors.purple)),
                  ],
                ),
                const SizedBox(height: 32),

                // Charts Row
                Row(
                  children: [
                    // Bookings by Type Chart
                    Expanded(
                      flex: 2,
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'الحجوزات حسب النوع',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 200,
                                child: _buildSimplePieChart(stats),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Revenue Chart
                    Expanded(
                      flex: 3,
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'الإيرادات الشهرية',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 200,
                                child: _buildSimpleLineChart(stats),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Recent Activity
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'النشاط الأخير',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                            itemCount: adminState.notifications.length,
                            itemBuilder: (context, index) {
                              final notification = adminState.notifications[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: _getNotificationColor(notification.type),
                                  child: Icon(
                                    _getNotificationIcon(notification.type),
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                title: Text(notification.title),
                                subtitle: Text(notification.message),
                                trailing: Text(
                                  _formatTime(notification.createdAt),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color),
                ),
                const Spacer(),
                Icon(Icons.trending_up, color: Colors.green, size: 20),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'success':
        return Colors.green;
      case 'warning':
        return Colors.orange;
      case 'error':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'success':
        return Icons.check_circle;
      case 'warning':
        return Icons.warning;
      case 'error':
        return Icons.error;
      default:
        return Icons.info;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return 'منذ ${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 24) {
      return 'منذ ${difference.inHours} ساعة';
    } else {
      return 'منذ ${difference.inDays} يوم';
    }
  }

  Widget _buildSimplePieChart(admin_models.AdminStats stats) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildChartItem('حافلة', stats.bookingsByType['bus'] ?? 0, Colors.blue),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildChartItem('قطار', stats.bookingsByType['train'] ?? 0, Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildChartItem('طيران', stats.bookingsByType['flight'] ?? 0, Colors.orange),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildChartItem('فندق', stats.bookingsByType['hotel'] ?? 0, Colors.purple),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartItem(String label, int value, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleLineChart(admin_models.AdminStats stats) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: stats.revenueByMonth.entries.map((entry) {
          final percentage = (entry.value / stats.totalRevenue * 100).toStringAsFixed(1);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(entry.key),
                ),
                Expanded(
                  flex: 8,
                  child: LinearProgressIndicator(
                    value: entry.value / stats.totalRevenue,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getMonthColor(entry.key),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Text(
                    '${(entry.value / 1000).toStringAsFixed(0)} ألف',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text('$percentage%'),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Color _getMonthColor(String month) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];
    final months = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو'];
    final index = months.indexOf(month);
    return index >= 0 && index < colors.length ? colors[index] : Colors.grey;
  }
} 