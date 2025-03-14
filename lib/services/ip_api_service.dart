// services/ip_api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myapp/models/ip_location_model.dart';
import 'package:myapp/utils/app_constants.dart';

class IpApiService {
  Future<IpLocation> getIpLocation(String ipAddress) async {
    final url = Uri.parse('${AppConstants.baseUrl}/$ipAddress');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return IpLocation.fromJson(data);
    } else {
      throw Exception(
          'Failed to load IP location. Status code: ${response.statusCode}');
    }
  }
    Future<IpLocation> getMyIpLocation() async {
    final url = Uri.parse(AppConstants.baseUrl); // Simpler URL construction
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return IpLocation.fromJson(data);
    } else {
      throw Exception('Failed to load IP location. Status code: ${response.statusCode}'); // Corrected here
    }
  }
}