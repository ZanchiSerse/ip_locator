import 'package:flutter/material.dart';
import 'package:myapp/providers/ip_location_provider.dart';
import 'package:myapp/widgets/ip_details_card.dart';
import 'package:myapp/widgets/ip_input_field.dart';
import 'package:myapp/widgets/loading_indicator.dart';
import 'package:myapp/widgets/map_widget.dart';
import 'package:provider/provider.dart';
import 'package:myapp/widgets/history_list.dart';
import 'package:myapp/utils/app_constants.dart';


class IpLocationScreen extends StatefulWidget {
  const IpLocationScreen({super.key});

  @override
  State<IpLocationScreen> createState() => _IpLocationScreenState();
}

class _IpLocationScreenState extends State<IpLocationScreen> {
  final _ipAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
     // Carica la posizione dell'IP corrente all'avvio
     WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<IpLocationProvider>(context, listen: false).fetchMyIpLocation();
    });
  }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IP Locator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
               showModalBottomSheet(
                    context: context,
                    builder: (context) => const HistoryList(),
                  );
            },
          ),
           IconButton( // Icona per aggiornare la posizione corrente
            icon: const Icon(Icons.my_location),
            onPressed: () {
              Provider.of<IpLocationProvider>(context, listen: false).fetchMyIpLocation();
            },
          ),
        ],
      ),
      body: Consumer<IpLocationProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   // Input IP
                  IpInputField(
                    controller: _ipAddressController,
                    onSubmitted: (ip) {
                      if (ip.isNotEmpty) {
                        provider.fetchIpLocation(ip);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
            
                  if (provider.isLoading)
                    const LoadingIndicator() // Mostra l'indicatore di caricamento
                  else if (provider.errorMessage != null)
                    Text(
                      provider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    )
                  else if (provider.ipLocation != null) ...[
                    IpDetailsCard(ipLocation: provider.ipLocation!),
                    const SizedBox(height: 20),
                    MapWidget(ipLocation: provider.ipLocation!),
                  ] else ...[
                    const Center(child: Text(AppConstants.welcomeMessage))
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
    @override
  void dispose() {
    _ipAddressController.dispose();
    super.dispose();
  }
}