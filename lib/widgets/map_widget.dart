import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:myapp/models/ip_location_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';


class MapWidget extends StatefulWidget {
  final IpLocation ipLocation;

  const MapWidget({super.key, required this.ipLocation});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  @override
  Widget build(BuildContext context) {
    final lat = widget.ipLocation.lat;
    final lon = widget.ipLocation.lon;

    // Gestisci il caso in cui latitudine o longitudine siano null
    if (lat == null || lon == null) {
      return const SizedBox
          .shrink(); // Non mostrare la mappa se le coordinate non sono disponibili
    }

    return SizedBox(
      height: 200,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(lat, lon),
          initialZoom: 13.0,
          onTap: (tapPosition, point) => _launchMaps(lat, lon),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.ip_locator_app', // Replace with your app's package name
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(lat, lon),
                child: const Icon(Icons.location_pin,
                    color: Colors.red, size: 40),
              ),
            ],
          ),

        ],
      ),
    );
  }
    Future<void> _launchMaps(double lat, double lon) async {
    final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // Potresti mostrare uno snackbar o un dialog qui
      print('Could not launch $url');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the map.')),
      );
    }
  }
}