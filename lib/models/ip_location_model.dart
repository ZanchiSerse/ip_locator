// ip_location_model.dart
class IpLocation {
  final String status;
  final String? country; // Make nullable
  final String? countryCode; // Make nullable
  final String? region; // Make nullable
  final String? regionName; // Make nullable
  final String? city; // Make nullable
  final String? zip; // Make nullable
  final double? lat; // Make nullable
  final double? lon; // Make nullable
  final String? timezone; // Make nullable
  final String? isp; // Make nullable
  final String? org; // Make nullable
  final String? as; // Make nullable
  final String query;
  final String? message; // For error messages

  IpLocation({
    required this.status,
    this.country,
    this.countryCode,
    this.region,
    this.regionName,
    this.city,
    this.zip,
    this.lat,
    this.lon,
    this.timezone,
    this.isp,
    this.org,
    this.as,
    required this.query,
    this.message,
  });

  factory IpLocation.fromJson(Map<String, dynamic> json) {
    return IpLocation(
      status: json['status'],
      country: json['country'],
      countryCode: json['countryCode'],
      region: json['region'],
      regionName: json['regionName'],
      city: json['city'],
      zip: json['zip'],
      lat: json['lat']?.toDouble(), // Use ?. to handle null
      lon: json['lon']?.toDouble(), // Use ?. to handle null
      timezone: json['timezone'],
      isp: json['isp'],
      org: json['org'],
      as: json['as'],
      query: json['query'],
      message: json['message'], // Capture the error message
    );
  }
}