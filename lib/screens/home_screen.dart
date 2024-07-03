import 'package:flutter/material.dart';
import 'package:flutter_weather_app/provider/weather_provider.dart';
import 'package:flutter_weather_app/screens/weather_details_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController cityController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String cityName = cityController.text;
                if (cityName.isNotEmpty) {
                  await Provider.of<WeatherProvider>(context, listen: false)
                      .fetchWeather(cityName);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WeatherDetailsScreen(),
                      ));
                }
              },
              child: const Text('Get Weather'),
            ),
            Consumer<WeatherProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const CircularProgressIndicator();
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
