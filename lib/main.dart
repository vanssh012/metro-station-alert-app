import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'services/journey_provider.dart';
import 'data/metro_data_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0A0E21),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize metro data
  final metroDataProvider = MetroDataProvider();
  await metroDataProvider.initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider<MetroDataProvider>.value(value: metroDataProvider),
        ChangeNotifierProvider<JourneyProvider>(
          create: (_) => JourneyProvider(metroDataProvider),
        ),
      ],
      child: const MetroWakeApp(),
    ),
  );
}
