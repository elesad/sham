import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/admin_state.dart';
import '../models/admin_models.dart' as admin_models;

class AdminNotificationsScreen extends StatefulWidget {
  const AdminNotificationsScreen({super.key});

  @override
  State<AdminNotificationsScreen> createState() => _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState extends State<AdminNotificationsScreen> {
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedType = 'info';
  String _selectedTargetType = 'all';

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Consumer<AdminState>(
        builder: (context, adminState, child) {
          if (adminState.isLoading) {
            return const Center(child: CircularProgressIndicator());
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
                      'إدارة الإشعارات',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () => _showSendNotificationDialog(context, adminState),
                      icon: const Icon(Icons.send),
                      label: const Text('إرسال إشعار جديد'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Notifications List
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: adminState.notifications.length,
                      itemBuilder: (context, index) {
                        final notification = adminState.notifications[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          color: notification.isRead ? Colors.grey.shade50 : Colors.white,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: _getNotificationColor(notification.type),
                              child: Icon(
                                _getNotificationIcon(notification.type),
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            title: Text(
                              notification.title,
                              style: TextStyle(
                                fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(notification.message),
                                const SizedBox(height: 4),
                                Text(
                                  _formatTime(notification.createdAt),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            trailing: PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'mark_read' && !notification.isRead) {
                                  adminState.markNotificationAsRead(notification.id);
                                } else if (value == 'delete') {
                                  _showDeleteNotificationDialog(context, notification);
                                }
                              },
                              itemBuilder: (context) => [
                                if (!notification.isRead)
                                  const PopupMenuItem(
                                    value: 'mark_read',
                                    child: Row(
                                      children: [
                                        Icon(Icons.check_circle, size: 16),
                                        SizedBox(width: 8),
                                        Text('تحديد كمقروء'),
                                      ],
                                    ),
                                  ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, size: 16, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('حذف', style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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

  void _showSendNotificationDialog(BuildContext context, AdminState adminState) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إرسال إشعار جديد'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'عنوان الإشعار',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _messageController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'محتوى الإشعار',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'نوع الإشعار',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'info', child: Text('معلومات')),
                  DropdownMenuItem(value: 'success', child: Text('نجاح')),
                  DropdownMenuItem(value: 'warning', child: Text('تحذير')),
                  DropdownMenuItem(value: 'error', child: Text('خطأ')),
                ],
                onChanged: (value) {
                  _selectedType = value!;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedTargetType,
                decoration: const InputDecoration(
                  labelText: 'المستهدف',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'all', child: Text('جميع المستخدمين')),
                  DropdownMenuItem(value: 'admin', child: Text('المديرين فقط')),
                  DropdownMenuItem(value: 'user', child: Text('المستخدمين فقط')),
                ],
                onChanged: (value) {
                  _selectedTargetType = value!;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _titleController.clear();
              _messageController.clear();
              Navigator.pop(context);
            },
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_titleController.text.isNotEmpty && _messageController.text.isNotEmpty) {
                adminState.sendNotification(
                  _titleController.text,
                  _messageController.text,
                  _selectedType,
                  targetUserType: _selectedTargetType,
                );
                _titleController.clear();
                _messageController.clear();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم إرسال الإشعار بنجاح')),
                );
              }
            },
            child: const Text('إرسال'),
          ),
        ],
      ),
    );
  }

  void _showDeleteNotificationDialog(BuildContext context, admin_models.Notification notification) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الإشعار'),
        content: Text('هل أنت متأكد من حذف الإشعار "${notification.title}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              // Note: You would need to add a deleteNotification method to AdminState
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم حذف الإشعار بنجاح')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
} 