import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryService {
  static const String _searchHistoryKey = 'searchHistory';

  Future<void> saveSearchTerm(String searchTerm) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> searchHistory = prefs.getStringList(_searchHistoryKey) ?? [];

    if (searchHistory.contains(searchTerm)) {
      searchHistory.remove(searchTerm); 
    }

    searchHistory.insert(0, searchTerm); 

    if (searchHistory.length > 20) {
      searchHistory = searchHistory.sublist(0, 10);
    }

    await prefs.setStringList(_searchHistoryKey, searchHistory);
  }

  Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_searchHistoryKey) ?? [];
  }

  Future<void> clearSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_searchHistoryKey);
  }
}