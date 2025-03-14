import 'package:flutter/material.dart';
import 'package:myapp/screens/ip_location_screen.dart';
import 'package:myapp/themes/app_theme.dart';
import 'package:myapp/providers/ip_location_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Assicura che Flutter sia inizializzato
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ChangeNotifierProvider(
      create: (context) => IpLocationProvider(prefs),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IP Locator',
      theme: AppTheme.darkTheme, // Usa il tema scuro
      home: const IpLocationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}