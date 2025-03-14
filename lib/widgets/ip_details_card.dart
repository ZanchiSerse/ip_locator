// widgets/ip_details_card.dart
import 'package:flutter/material.dart';
import 'package:myapp/models/ip_location_model.dart';
import 'package:clipboard/clipboard.dart';

class IpDetailsCard extends StatelessWidget {
  final IpLocation ipLocation;

  const IpDetailsCard({super.key, required this.ipLocation});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(
                'IP Address:', ipLocation.query, Icons.location_on, context),
            _buildDetailRow('Country:', ipLocation.country ?? 'N/A',
                Icons.flag, context),
            _buildDetailRow(
                'Region:', ipLocation.regionName ?? 'N/A', Icons.map, context),
            _buildDetailRow(
                'City:', ipLocation.city ?? 'N/A', Icons.location_city, context),
            _buildDetailRow('Latitude:', ipLocation.lat?.toString() ?? 'N/A',
                Icons.pin_drop, context),
            _buildDetailRow('Longitude:', ipLocation.lon?.toString() ?? 'N/A',
                Icons.pin_drop, context),
            _buildDetailRow(
                'ISP:', ipLocation.isp ?? 'N/A', Icons.business, context),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      String label, String value, IconData icon, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text('$label ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child:
                Text(value, overflow: TextOverflow.ellipsis), // Gestione overflow
          ),
          IconButton(
            icon: const Icon(Icons.copy, size: 18),
            onPressed: () async { // Aggiungi async qui
              await FlutterClipboard.copy(value); // Aggiungi await qui
              // Controlla se il widget è ancora montato PRIMA di usare context
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Copied to clipboard!')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}