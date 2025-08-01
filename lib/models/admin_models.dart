import 'package:flutter/material.dart';

class AdminUser {
  final String id;
  final String username;
  final String email;
  final String fullName;
  final String role; // admin, moderator, support
  final String avatar;
  final DateTime createdAt;
  final DateTime lastLogin;
  final bool isActive;
  final List<String> permissions;

  AdminUser({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.role,
    this.avatar = '',
    required this.createdAt,
    required this.lastLogin,
    this.isActive = true,
    this.permissions = const [],
  });

  factory AdminUser.fromJson(Map<String, dynamic> json) {
    return AdminUser(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      fullName: json['fullName'],
      role: json['role'],
      avatar: json['avatar'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      lastLogin: DateTime.parse(json['lastLogin']),
      isActive: json['isActive'] ?? true,
      permissions: List<String>.from(json['permissions'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'fullName': fullName,
      'role': role,
      'avatar': avatar,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin.toIso8601String(),
      'isActive': isActive,
      'permissions': permissions,
    };
  }
}

class AdminStats {
  final int totalUsers;
  final int totalBookings;
  final int totalRevenue;
  final int activeBookings;
  final int pendingBookings;
  final int cancelledBookings;
  final Map<String, int> bookingsByType;
  final Map<String, int> revenueByMonth;

  AdminStats({
    required this.totalUsers,
    required this.totalBookings,
    required this.totalRevenue,
    required this.activeBookings,
    required this.pendingBookings,
    required this.cancelledBookings,
    required this.bookingsByType,
    required this.revenueByMonth,
  });

  factory AdminStats.fromJson(Map<String, dynamic> json) {
    return AdminStats(
      totalUsers: json['totalUsers'],
      totalBookings: json['totalBookings'],
      totalRevenue: json['totalRevenue'],
      activeBookings: json['activeBookings'],
      pendingBookings: json['pendingBookings'],
      cancelledBookings: json['cancelledBookings'],
      bookingsByType: Map<String, int>.from(json['bookingsByType']),
      revenueByMonth: Map<String, int>.from(json['revenueByMonth']),
    );
  }
}

class Booking {
  final String id;
  final String userId;
  final String userName;
  final String userEmail;
  final String bookingType; // bus, train, flight, hotel
  final String status; // pending, confirmed, cancelled, completed
  final double amount;
  final DateTime bookingDate;
  final DateTime travelDate;
  final String fromLocation;
  final String toLocation;
  final String companyName;
  final String? seatNumber;
  final String? roomType;
  final int? passengers;
  final String? specialRequests;

  Booking({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.bookingType,
    required this.status,
    required this.amount,
    required this.bookingDate,
    required this.travelDate,
    required this.fromLocation,
    required this.toLocation,
    required this.companyName,
    this.seatNumber,
    this.roomType,
    this.passengers,
    this.specialRequests,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      userEmail: json['userEmail'],
      bookingType: json['bookingType'],
      status: json['status'],
      amount: json['amount'].toDouble(),
      bookingDate: DateTime.parse(json['bookingDate']),
      travelDate: DateTime.parse(json['travelDate']),
      fromLocation: json['fromLocation'],
      toLocation: json['toLocation'],
      companyName: json['companyName'],
      seatNumber: json['seatNumber'],
      roomType: json['roomType'],
      passengers: json['passengers'],
      specialRequests: json['specialRequests'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'bookingType': bookingType,
      'status': status,
      'amount': amount,
      'bookingDate': bookingDate.toIso8601String(),
      'travelDate': travelDate.toIso8601String(),
      'fromLocation': fromLocation,
      'toLocation': toLocation,
      'companyName': companyName,
      'seatNumber': seatNumber,
      'roomType': roomType,
      'passengers': passengers,
      'specialRequests': specialRequests,
    };
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final DateTime registrationDate;
  final DateTime lastLogin;
  final bool isActive;
  final int totalBookings;
  final double totalSpent;
  final String? avatar;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.registrationDate,
    required this.lastLogin,
    this.isActive = true,
    this.totalBookings = 0,
    this.totalSpent = 0.0,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      registrationDate: DateTime.parse(json['registrationDate']),
      lastLogin: DateTime.parse(json['lastLogin']),
      isActive: json['isActive'] ?? true,
      totalBookings: json['totalBookings'] ?? 0,
      totalSpent: json['totalSpent']?.toDouble() ?? 0.0,
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'registrationDate': registrationDate.toIso8601String(),
      'lastLogin': lastLogin.toIso8601String(),
      'isActive': isActive,
      'totalBookings': totalBookings,
      'totalSpent': totalSpent,
      'avatar': avatar,
    };
  }
}

class Notification {
  final String id;
  final String title;
  final String message;
  final String type; // info, warning, error, success
  final DateTime createdAt;
  final bool isRead;
  final String? targetUserId;
  final String? targetUserType; // all, admin, user

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    this.isRead = false,
    this.targetUserId,
    this.targetUserType,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      type: json['type'],
      createdAt: DateTime.parse(json['createdAt']),
      isRead: json['isRead'] ?? false,
      targetUserId: json['targetUserId'],
      targetUserType: json['targetUserType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
      'targetUserId': targetUserId,
      'targetUserType': targetUserType,
    };
  }
} 