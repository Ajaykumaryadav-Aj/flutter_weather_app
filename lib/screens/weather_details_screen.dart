import 'package:flutter/material.dart';
import 'package:flutter_weather_app/provider/weather_provider.dart';
import 'package:provider/provider.dart';

class WeatherDetailsScreen extends StatelessWidget {
  const WeatherDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _weather = Provider.of<WeatherProvider>(context).weather;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),
        centerTitle: true,
      ),
      body: _weather != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      _weather.cityName,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${_weather.temperature}°C',
                      style: const TextStyle(fontSize: 32),
                    ),
                    Text(
                      _weather.condition,
                      style: const TextStyle(fontSize: 24),
                    ),
                    Image.network(
                        'http://openweathermap.org/img/wn/${_weather.icon}@2x.png'),
                    Text('Humidity: ${_weather.humidity}%'),
                    Text('Wind Speed: ${_weather.windSpeed} m/s'),
                  ],
                ),
              ),
            )
          : const Center(
              child: Text('No weather data available'),
            ),
    );
  }
}
