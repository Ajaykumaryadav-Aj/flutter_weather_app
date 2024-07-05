import 'package:flutter/material.dart';
import 'package:flutter_weather_app/provider/weather_provider.dart';
import 'package:provider/provider.dart';

class WeatherDetailsScreen extends StatelessWidget {
  const WeatherDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weather = weatherProvider.weather;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () async {
                  await weatherProvider.refreshWeather();
                },
              ),
              if (weatherProvider.isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
            ],
          ),
        ],
      ),
      body: weatherProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : weather != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weather.cityName,
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${weather.temperature}°C',
                          style: const TextStyle(fontSize: 32),
                        ),
                        Text(
                          weather.condition,
                          style: const TextStyle(fontSize: 24),
                        ),
                        Image.network(
                            'http://openweathermap.org/img/wn/${weather.icon}@2x.png'),
                        Text('Humidity: ${weather.humidity}%'),
                        Text('Wind Speed: ${weather.windSpeed} m/s'),
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
