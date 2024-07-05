import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  WeatherService _weatherService = WeatherService();
  Weather? _weather;
  bool _isLoading = false;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _weatherService.fetchWeather(cityName);
      _weather = Weather.fromJson(data);
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshWeather() async {
    if (_weather != null) {
      await fetchWeather(_weather!.cityName);
    }
  }
}
