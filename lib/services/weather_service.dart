import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '7beb81196fa749ea95765fab8bc1b0fa';

  final String baseUrl = 'http://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> fetchWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
