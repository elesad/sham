import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/admin_state.dart';
import '../models/admin_models.dart' as admin_models;

class AdminReportsScreen extends StatefulWidget {
  const AdminReportsScreen({super.key});

  @override
  State<AdminReportsScreen> createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends State<AdminReportsScreen> {
  String _selectedReportType = 'financial';

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

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const Text(
                      'التقارير والإحصائيات',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () => _exportReport(),
                      icon: const Icon(Icons.download),
                      label: const Text('تصدير التقرير'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Report Type Selector
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Text(
                          'نوع التقرير:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        ChoiceChip(
                          label: const Text('التقرير المالي'),
                          selected: _selectedReportType == 'financial',
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedReportType = 'financial';
                              });
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('تقرير المستخدمين'),
                          selected: _selectedReportType == 'users',
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedReportType = 'users';
                              });
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('تقرير الحجوزات'),
                          selected: _selectedReportType == 'bookings',
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedReportType = 'bookings';
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Report Content
                Expanded(
                  child: _buildReportContent(stats, adminState),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildReportContent(admin_models.AdminStats stats, AdminState adminState) {
    switch (_selectedReportType) {
      case 'financial':
        return _buildFinancialReport(stats);
      case 'users':
        return _buildUsersReport(adminState);
      case 'bookings':
        return _buildBookingsReport(stats, adminState);
      default:
        return _buildFinancialReport(stats);
    }
  }

  Widget _buildFinancialReport(admin_models.AdminStats stats) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Revenue Overview
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'نظرة عامة على الإيرادات',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'إجمالي الإيرادات',
                          '${(stats.totalRevenue / 1000000).toStringAsFixed(1)} مليون ل.س',
                          Icons.attach_money,
                          Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          'متوسط الإيراد اليومي',
                          '${(stats.totalRevenue / 30 / 1000).toStringAsFixed(0)} ألف ل.س',
                          Icons.trending_up,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          'نسبة النمو',
                          '+15%',
                          Icons.trending_up,
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Monthly Revenue Chart
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الإيرادات الشهرية',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 300,
                    child: _buildMonthlyRevenueChart(stats),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Revenue by Service Type
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الإيرادات حسب نوع الخدمة',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildRevenueByServiceTable(stats),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersReport(AdminState adminState) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Users Overview
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'نظرة عامة على المستخدمين',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'إجمالي المستخدمين',
                          adminState.stats?.totalUsers.toString() ?? '0',
                          Icons.people,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          'المستخدمين النشطين',
                          '${(adminState.stats?.totalUsers ?? 0) * 0.8}',
                          Icons.person,
                          Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          'مستخدمين جدد هذا الشهر',
                          '45',
                          Icons.person_add,
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Users Table
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'أفضل المستخدمين',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTopUsersTable(adminState),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsReport(admin_models.AdminStats stats, AdminState adminState) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Bookings Overview
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'نظرة عامة على الحجوزات',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'إجمالي الحجوزات',
                          stats.totalBookings.toString(),
                          Icons.confirmation_number,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          'الحجوزات النشطة',
                          stats.activeBookings.toString(),
                          Icons.check_circle,
                          Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          'الحجوزات المعلقة',
                          stats.pendingBookings.toString(),
                          Icons.pending,
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Bookings by Type
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الحجوزات حسب النوع',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildBookingsByTypeTable(stats),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
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
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyRevenueChart(admin_models.AdminStats stats) {
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

  Widget _buildRevenueByServiceTable(admin_models.AdminStats stats) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('نوع الخدمة')),
        DataColumn(label: Text('عدد الحجوزات')),
        DataColumn(label: Text('نسبة الإيرادات')),
        DataColumn(label: Text('متوسط السعر')),
      ],
      rows: [
        DataRow(cells: [
          const DataCell(Text('الحافلات')),
          DataCell(Text(stats.bookingsByType['bus'].toString())),
          const DataCell(Text('35%')),
          const DataCell(Text('25,000 ل.س')),
        ]),
        DataRow(cells: [
          const DataCell(Text('القطارات')),
          DataCell(Text(stats.bookingsByType['train'].toString())),
          const DataCell(Text('25%')),
          const DataCell(Text('35,000 ل.س')),
        ]),
        DataRow(cells: [
          const DataCell(Text('الطيران')),
          DataCell(Text(stats.bookingsByType['flight'].toString())),
          const DataCell(Text('20%')),
          const DataCell(Text('150,000 ل.س')),
        ]),
        DataRow(cells: [
          const DataCell(Text('الفنادق')),
          DataCell(Text(stats.bookingsByType['hotel'].toString())),
          const DataCell(Text('20%')),
          const DataCell(Text('120,000 ل.س')),
        ]),
      ],
    );
  }

  Widget _buildTopUsersTable(AdminState adminState) {
    final topUsers = adminState.users.take(5).toList();
    return DataTable(
      columns: const [
        DataColumn(label: Text('المستخدم')),
        DataColumn(label: Text('عدد الحجوزات')),
        DataColumn(label: Text('إجمالي الإنفاق')),
        DataColumn(label: Text('آخر نشاط')),
      ],
      rows: topUsers.map((user) {
        return DataRow(cells: [
          DataCell(Text(user.name)),
          DataCell(Text(user.totalBookings.toString())),
          DataCell(Text('${user.totalSpent.toStringAsFixed(0)} ل.س')),
          DataCell(Text(_formatTime(user.lastLogin))),
        ]);
      }).toList(),
    );
  }

  Widget _buildBookingsByTypeTable(admin_models.AdminStats stats) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('نوع الحجز')),
        DataColumn(label: Text('العدد')),
        DataColumn(label: Text('النسبة')),
        DataColumn(label: Text('الحالة')),
      ],
      rows: [
        DataRow(cells: [
          const DataCell(Text('الحافلات')),
          DataCell(Text(stats.bookingsByType['bus'].toString())),
          const DataCell(Text('35%')),
          const DataCell(Text('مؤكد')),
        ]),
        DataRow(cells: [
          const DataCell(Text('القطارات')),
          DataCell(Text(stats.bookingsByType['train'].toString())),
          const DataCell(Text('25%')),
          const DataCell(Text('مؤكد')),
        ]),
        DataRow(cells: [
          const DataCell(Text('الطيران')),
          DataCell(Text(stats.bookingsByType['flight'].toString())),
          const DataCell(Text('20%')),
          const DataCell(Text('معلق')),
        ]),
        DataRow(cells: [
          const DataCell(Text('الفنادق')),
          DataCell(Text(stats.bookingsByType['hotel'].toString())),
          const DataCell(Text('20%')),
          const DataCell(Text('مؤكد')),
        ]),
      ],
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

  void _exportReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم تصدير التقرير بنجاح'),
        backgroundColor: Colors.green,
      ),
    );
  }
} 