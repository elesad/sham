import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteItem {
  final String id;
  final String name;
  final String type; // 'bus', 'plane', 'train', 'hotel'
  final String fromLocation;
  final String toLocation;
  final String date;
  final String price;
  final String time;
  final String description;
  final String features;
  final DateTime addedAt;

  FavoriteItem({
    required this.id,
    required this.name,
    required this.type,
    required this.fromLocation,
    required this.toLocation,
    required this.date,
    required this.price,
    required this.time,
    required this.description,
    required this.features,
    required this.addedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'fromLocation': fromLocation,
      'toLocation': toLocation,
      'date': date,
      'price': price,
      'time': time,
      'description': description,
      'features': features,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      fromLocation: json['fromLocation'],
      toLocation: json['toLocation'],
      date: json['date'],
      price: json['price'],
      time: json['time'],
      description: json['description'],
      features: json['features'],
      addedAt: DateTime.parse(json['addedAt']),
    );
  }
}

class FavoritesProvider extends ChangeNotifier {
  List<FavoriteItem> _favorites = [];
  bool _isLoading = false;

  List<FavoriteItem> get favorites => _favorites;
  bool get isLoading => _isLoading;

  // تحميل المفضلة من التخزين المحلي
  Future<void> loadFavorites() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getStringList('favorites') ?? [];
      
      _favorites = favoritesJson
          .map((json) => FavoriteItem.fromJson(jsonDecode(json)))
          .toList();
      
      // ترتيب المفضلة حسب تاريخ الإضافة (الأحدث أولاً)
      _favorites.sort((a, b) => b.addedAt.compareTo(a.addedAt));
    } catch (e) {
      print('Error loading favorites: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // حفظ المفضلة في التخزين المحلي
  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = _favorites
          .map((item) => jsonEncode(item.toJson()))
          .toList();
      
      await prefs.setStringList('favorites', favoritesJson);
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

  // إضافة عنصر إلى المفضلة
  Future<void> addToFavorites(FavoriteItem item) async {
    // التحقق من عدم وجود العنصر مسبقاً
    if (!_favorites.any((favorite) => favorite.id == item.id)) {
      _favorites.add(item);
      // ترتيب المفضلة حسب تاريخ الإضافة (الأحدث أولاً)
      _favorites.sort((a, b) => b.addedAt.compareTo(a.addedAt));
      await _saveFavorites();
      notifyListeners();
    }
  }

  // إزالة عنصر من المفضلة
  Future<void> removeFromFavorites(String id) async {
    _favorites.removeWhere((item) => item.id == id);
    await _saveFavorites();
    notifyListeners();
  }

  // التحقق من وجود عنصر في المفضلة
  bool isFavorite(String id) {
    return _favorites.any((item) => item.id == id);
  }

  // الحصول على المفضلة حسب النوع
  List<FavoriteItem> getFavoritesByType(String type) {
    return _favorites.where((item) => item.type == type).toList();
  }

  // مسح جميع المفضلة
  Future<void> clearAllFavorites() async {
    _favorites.clear();
    await _saveFavorites();
    notifyListeners();
  }

  // الحصول على عدد المفضلة
  int get favoritesCount => _favorites.length;

  // الحصول على عدد المفضلة حسب النوع
  int getFavoritesCountByType(String type) {
    return _favorites.where((item) => item.type == type).length;
  }
} 