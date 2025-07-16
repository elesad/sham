import 'package:flutter/material.dart';
import '../screens/favorite_screen.dart';
import '../screens/my_trips.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<FavoriteCompany> _favoriteCompanies = [];
  final List<FavoriteRoute> _favoriteRoutes = [];

  List<FavoriteCompany> get favoriteCompanies => _favoriteCompanies;
  List<FavoriteRoute> get favoriteRoutes => _favoriteRoutes;

  void toggleCompanyFavorite(FavoriteCompany company) {
    final index = _favoriteCompanies.indexWhere((c) => c.id == company.id);
    if (index >= 0) {
      _favoriteCompanies.removeAt(index);
    } else {
      _favoriteCompanies.add(company);
    }
    notifyListeners();
  }

  void toggleRouteFavorite(FavoriteRoute route) {
    final index = _favoriteRoutes.indexWhere((r) => r.id == route.id);
    if (index >= 0) {
      _favoriteRoutes.removeAt(index);
    } else {
      _favoriteRoutes.add(route);
    }
    notifyListeners();
  }

  void sortByRating() {
    _favoriteCompanies.sort((a, b) => b.rating.compareTo(a.rating));
    _favoriteRoutes.sort((a, b) => b.price.compareTo(a.price));
    notifyListeners();
  }

  void sortByName() {
    _favoriteCompanies.sort((a, b) => a.name.compareTo(b.name));
    _favoriteRoutes.sort((a, b) => a.from.compareTo(b.from));
    notifyListeners();
  }

  void sortByPrice() {
    _favoriteRoutes.sort((a, b) => a.price.compareTo(b.price));
    notifyListeners();
  }

  void removeCompany(FavoriteCompany company) {
    _favoriteCompanies.removeWhere((c) => c.id == company.id);
    notifyListeners();
  }

  void removeRoute(FavoriteRoute route) {
    _favoriteRoutes.removeWhere((r) => r.id == route.id);
    notifyListeners();
  }
}

class MyTripsProvider extends ChangeNotifier {
  final List<Trip> _trips = [];

  List<Trip> get trips => _trips;

  void addTrip(Trip trip) {
    _trips.add(trip);
    notifyListeners();
  }

  void removeTrip(Trip trip) {
    _trips.removeWhere((t) => t.id == trip.id);
    notifyListeners();
  }
} 