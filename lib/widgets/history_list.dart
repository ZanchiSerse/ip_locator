import 'package:flutter/material.dart';
import 'package:myapp/providers/ip_location_provider.dart';
import 'package:provider/provider.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<IpLocationProvider>(context);
    final history = provider.history;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min, // Important for bottom sheets
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Search History', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          if (history.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No search history yet.'),
            )
          else
            Expanded(
                child: ListView.builder(
                shrinkWrap: true, // Important in bottom sheets
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final ip = history[index];
                  return ListTile(
                    title: Text(ip),
                    leading: const Icon(Icons.history),
                    trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                           final updatedHistory = List<String>.from(history)..removeAt(index); // Create a new list to trigger rebuild
                            Provider.of<IpLocationProvider>(context, listen: false).clearHistory(); // First clear
                            for (var item in updatedHistory) { // Add back all the others
                              Provider.of<IpLocationProvider>(context, listen: false).fetchIpLocation(item); // Then re-add them.
                            }
                        },
                      ),
                    onTap: () {
                      // Ricerca l'IP selezionato
                      provider.fetchIpLocation(ip);
                      Navigator.pop(context); // Chiudi il bottom sheet
                    },
                  );
                },
              ),
            ),
              TextButton(
                onPressed: () {
                Provider.of<IpLocationProvider>(context, listen: false).clearHistory();
                },
                child: const Text('Clear History'),
              ),
        ],
      ),
    );
  }
}