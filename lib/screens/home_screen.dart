import 'package:flutter/material.dart';
import 'package:flutter_weather_app/db/search_history_db.dart';
import 'package:flutter_weather_app/provider/weather_provider.dart';
import 'package:provider/provider.dart';
import 'weather_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SearchHistoryService _searchHistoryService = SearchHistoryService();
  TextEditingController cityController = TextEditingController();
  List<String> _searchHistory = [];

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    List<String> history = await _searchHistoryService.getSearchHistory();
    setState(() {
      _searchHistory = history;
    });
  }

  void _submitSearch(String searchTerm) async {
    await _searchHistoryService.saveSearchTerm(searchTerm);
    _loadSearchHistory();
  }

  void _clearSearchHistory() async {
    await _searchHistoryService.clearSearchHistory();
    _loadSearchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
              onSubmitted: (String searchTerm) {
                if (searchTerm.isNotEmpty) {
                  _submitSearch(searchTerm);
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String searchTerm = cityController.text;
                if (searchTerm.isNotEmpty) {
                  _submitSearch(searchTerm);
                }
                String cityName = cityController.text;
                if (cityName.isNotEmpty) {
                  await Provider.of<WeatherProvider>(context, listen: false)
                      .fetchWeather(cityName);
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WeatherDetailsScreen(),
                    ));
              },
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 20),
            const Text('Last Searches:'),
            Expanded(
              child: ListView.builder(
                itemCount: _searchHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_searchHistory[index]),
                  );
                },
              ),
            ),
            TextButton(
                onPressed: _clearSearchHistory,
                child: const Text('delete History')),
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
