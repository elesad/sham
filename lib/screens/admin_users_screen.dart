import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/admin_state.dart';
import '../models/admin_models.dart' as admin_models;

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Consumer<AdminState>(
        builder: (context, adminState, child) {
          if (adminState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          var filteredUsers = adminState.users;

          // Apply search filter
          if (_searchQuery.isNotEmpty) {
            filteredUsers = adminState.searchUsers(_searchQuery);
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
                      'إدارة المستخدمين',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'إجمالي المستخدمين: ${filteredUsers.length}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Search
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'البحث في المستخدمين...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Users Table
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: SingleChildScrollView(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('المستخدم')),
                          DataColumn(label: Text('البريد الإلكتروني')),
                          DataColumn(label: Text('الهاتف')),
                          DataColumn(label: Text('تاريخ التسجيل')),
                          DataColumn(label: Text('آخر تسجيل دخول')),
                          DataColumn(label: Text('الحجوزات')),
                          DataColumn(label: Text('إجمالي الإنفاق')),
                          DataColumn(label: Text('الحالة')),
                          DataColumn(label: Text('الإجراءات')),
                        ],
                        rows: filteredUsers.map((user) {
                          return DataRow(
                            cells: [
                              DataCell(
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color(0xFF1E3A8A),
                                      child: Text(
                                        user.name.substring(0, 1),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(user.name),
                                  ],
                                ),
                              ),
                              DataCell(Text(user.email)),
                              DataCell(Text(user.phone)),
                              DataCell(Text(_formatDate(user.registrationDate))),
                              DataCell(Text(_formatTime(user.lastLogin))),
                              DataCell(Text(user.totalBookings.toString())),
                              DataCell(Text('${user.totalSpent.toStringAsFixed(0)} ل.س')),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: user.isActive ? Colors.green : Colors.red,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    user.isActive ? 'نشط' : 'غير نشط',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        user.isActive ? Icons.block : Icons.check_circle,
                                        size: 18,
                                        color: user.isActive ? Colors.red : Colors.green,
                                      ),
                                      onPressed: () => _toggleUserStatus(context, user),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                                      onPressed: () => _showDeleteDialog(context, user),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
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

  void _toggleUserStatus(BuildContext context, admin_models.User user) {
    final adminState = Provider.of<AdminState>(context, listen: false);
    adminState.updateUserStatus(user.id, !user.isActive);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(user.isActive ? 'تم إلغاء تفعيل المستخدم' : 'تم تفعيل المستخدم'),
        backgroundColor: user.isActive ? Colors.orange : Colors.green,
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, admin_models.User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف المستخدم'),
        content: Text('هل أنت متأكد من حذف المستخدم ${user.name}؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () async {
              final adminState = Provider.of<AdminState>(context, listen: false);
              await adminState.deleteUser(user.id);
              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حذف المستخدم بنجاح')),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
} 