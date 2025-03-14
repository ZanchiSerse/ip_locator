import 'package:flutter/material.dart';
import 'package:myapp/models/ip_location_model.dart';
import 'package:myapp/services/ip_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IpLocationProvider with ChangeNotifier {
  final IpApiService _apiService = IpApiService();
  final SharedPreferences _prefs;

  IpLocation? _ipLocation;
  String? _errorMessage;
  bool _isLoading = false;
  List<String> _history = []; // List of IP strings

  IpLocation? get ipLocation => _ipLocation;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  List<String> get history => _history;

  IpLocationProvider(this._prefs) {
    _loadHistory();
  }


  Future<void> fetchIpLocation(String ipAddress) async {
    _isLoading = true;
    _errorMessage = null;
    // _ipLocation = null;  // Clear previous location.  Important!
    notifyListeners();

    try {
      _ipLocation = await _apiService.getIpLocation(ipAddress);
       if (_ipLocation?.status == 'fail') {
        _errorMessage = _ipLocation!.message ?? 'Lookup failed'; // Use the API's error message
        _ipLocation = null; // Ensure _ipLocation is cleared on failure

      } else {
        _addToHistory(ipAddress);
      }

    } catch (e) {
      _errorMessage = 'An error occurred: $e';
       _ipLocation = null; // Clear ipLocation on error, VERY IMPORTANT
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMyIpLocation() async {
    _isLoading = true;
    _errorMessage = null;
    //_ipLocation = null; //Clear before fetch
    notifyListeners();

    try {
      _ipLocation = await _apiService.getMyIpLocation();
      if (_ipLocation?.status == 'fail') {
        _errorMessage = _ipLocation!.message ?? 'Lookup failed';
        _ipLocation = null; // Ensure _ipLocation is cleared on failure
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      _ipLocation = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

    void _addToHistory(String ip) {
    if (!_history.contains(ip)) {
      _history.insert(0, ip); // Add to the beginning
      if (_history.length > 10) {
        // Limit history size
        _history = _history.sublist(0, 10);
      }
      _saveHistory();
      notifyListeners();
    }
  }
  void clearHistory() {
    _history = [];
    _saveHistory();
     notifyListeners(); // Notify after changing the list
  }

    void _loadHistory() {
    final historyJson = _prefs.getStringList('ip_history');
    if (historyJson != null) {
        _history = historyJson;
    }
  }

    void _saveHistory() {
    _prefs.setStringList('ip_history', _history);
  }

  // Method to retry a failed request
  Future<void> retryFetch() async {
    if (_ipLocation == null && _errorMessage != null) {
      // Refetch IP info if it's not already available
      await fetchMyIpLocation(); // Or refetch a given IP
    }
  }
}