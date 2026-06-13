import 'package:flutter/material.dart';
import '/db/weather_location_db.dart'; 
import '/models/saved_location.dart';
import '/services/weather_service.dart';

class SavedLocationsController extends ChangeNotifier {

  final WeatherService _weatherService = WeatherService();

  List<SavedLocation> locations = [];
  Map<int, String> temperatures = {};
  int? selectedId;

  Future<void> loadLocations() async {
    final data = await LocationDB.getLocations();
    locations = data;
    notifyListeners();
    _fetchTemperatures(data);
  }

  Future<void> _fetchTemperatures(List<SavedLocation> locs) async {
    for (final loc in locs) {
      try {
        final data = await _weatherService.getAllData(loc.city);
        final temp = data["weather"]["main"]["temp"].round().toString();
        temperatures[loc.id!] = "$temp°";
        notifyListeners();
      } catch (_) {
        temperatures[loc.id!] = "--";
        notifyListeners();
      }
    }
  }

  Future<void> deleteLocation(int id) async {
    await LocationDB.deleteLocation(id);
    await loadLocations();
  }

  void setSelected(int? id) {
    selectedId = id;
    notifyListeners();
  }
}