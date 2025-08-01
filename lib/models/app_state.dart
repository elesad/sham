import 'package:flutter/material.dart';
import '../screens/my_trips.dart';

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