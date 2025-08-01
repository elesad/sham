import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/admin_state.dart';
import '../models/admin_models.dart' as admin_models;

class AdminBookingsScreen extends StatefulWidget {
  const AdminBookingsScreen({super.key});

  @override
  State<AdminBookingsScreen> createState() => _AdminBookingsScreenState();
}

class _AdminBookingsScreenState extends State<AdminBookingsScreen> {
  String _searchQuery = '';
  String _selectedType = 'all';
  String _selectedStatus = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Consumer<AdminState>(
        builder: (context, adminState, child) {
          if (adminState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          var filteredBookings = adminState.bookings;

          // Apply search filter
          if (_searchQuery.isNotEmpty) {
            filteredBookings = adminState.searchBookings(_searchQuery);
          }

          // Apply type filter
          if (_selectedType != 'all') {
            filteredBookings = adminState.filterBookingsByType(_selectedType);
          }

          // Apply status filter
          if (_selectedStatus != 'all') {
            filteredBookings = adminState.filterBookingsByStatus(_selectedStatus);
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
                      'إدارة الحجوزات',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'إجمالي الحجوزات: ${filteredBookings.length}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Filters
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Search
                        Expanded(
                          flex: 2,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: 'البحث في الحجوزات...',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Type Filter
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedType,
                            decoration: const InputDecoration(
                              labelText: 'نوع الحجز',
                              border: OutlineInputBorder(),
                            ),
                            items: const [
                              DropdownMenuItem(value: 'all', child: Text('الكل')),
                              DropdownMenuItem(value: 'bus', child: Text('حافلة')),
                              DropdownMenuItem(value: 'train', child: Text('قطار')),
                              DropdownMenuItem(value: 'flight', child: Text('طيران')),
                              DropdownMenuItem(value: 'hotel', child: Text('فندق')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedType = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Status Filter
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedStatus,
                            decoration: const InputDecoration(
                              labelText: 'الحالة',
                              border: OutlineInputBorder(),
                            ),
                            items: const [
                              DropdownMenuItem(value: 'all', child: Text('الكل')),
                              DropdownMenuItem(value: 'pending', child: Text('معلق')),
                              DropdownMenuItem(value: 'confirmed', child: Text('مؤكد')),
                              DropdownMenuItem(value: 'cancelled', child: Text('ملغي')),
                              DropdownMenuItem(value: 'completed', child: Text('مكتمل')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedStatus = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Bookings Table
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: SingleChildScrollView(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('رقم الحجز')),
                          DataColumn(label: Text('المستخدم')),
                          DataColumn(label: Text('النوع')),
                          DataColumn(label: Text('من - إلى')),
                          DataColumn(label: Text('التاريخ')),
                          DataColumn(label: Text('المبلغ')),
                          DataColumn(label: Text('الحالة')),
                          DataColumn(label: Text('الإجراءات')),
                        ],
                        rows: filteredBookings.map((booking) {
                          return DataRow(
                            cells: [
                              DataCell(Text(booking.id)),
                              DataCell(
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(booking.userName),
                                    Text(
                                      booking.userEmail,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getTypeColor(booking.bookingType),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    _getTypeText(booking.bookingType),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(Text('${booking.fromLocation} → ${booking.toLocation}')),
                              DataCell(Text(_formatDate(booking.travelDate))),
                              DataCell(Text('${booking.amount.toStringAsFixed(0)} ل.س')),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(booking.status),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    _getStatusText(booking.status),
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
                                      icon: const Icon(Icons.edit, size: 18),
                                      onPressed: () => _showEditDialog(context, booking),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                                      onPressed: () => _showDeleteDialog(context, booking),
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

  Color _getTypeColor(String type) {
    switch (type) {
      case 'bus':
        return Colors.blue;
      case 'train':
        return Colors.green;
      case 'flight':
        return Colors.orange;
      case 'hotel':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _getTypeText(String type) {
    switch (type) {
      case 'bus':
        return 'حافلة';
      case 'train':
        return 'قطار';
      case 'flight':
        return 'طيران';
      case 'hotel':
        return 'فندق';
      default:
        return type;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'معلق';
      case 'confirmed':
        return 'مؤكد';
      case 'cancelled':
        return 'ملغي';
      case 'completed':
        return 'مكتمل';
      default:
        return status;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showEditDialog(BuildContext context, admin_models.Booking booking) {
    String selectedStatus = booking.status;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعديل حالة الحجز'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('رقم الحجز: ${booking.id}'),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedStatus,
              decoration: const InputDecoration(
                labelText: 'الحالة الجديدة',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'pending', child: Text('معلق')),
                DropdownMenuItem(value: 'confirmed', child: Text('مؤكد')),
                DropdownMenuItem(value: 'cancelled', child: Text('ملغي')),
                DropdownMenuItem(value: 'completed', child: Text('مكتمل')),
              ],
              onChanged: (value) {
                selectedStatus = value!;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () async {
              final adminState = Provider.of<AdminState>(context, listen: false);
              await adminState.updateBookingStatus(booking.id, selectedStatus);
              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم تحديث حالة الحجز بنجاح')),
                );
              }
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, admin_models.Booking booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الحجز'),
        content: Text('هل أنت متأكد من حذف الحجز رقم ${booking.id}؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () async {
              final adminState = Provider.of<AdminState>(context, listen: false);
              await adminState.deleteBooking(booking.id);
              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حذف الحجز بنجاح')),
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