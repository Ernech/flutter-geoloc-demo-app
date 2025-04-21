import 'package:flutter/material.dart';
import 'package:geoloc_demo_app/pages/google_maps_page.dart';
import 'package:geoloc_demo_app/services/ubicacion_service.dart';
import 'package:geoloc_demo_app/pages/ubicaciones_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UbicacionService())],
      child: MaterialApp(
        title: 'Demo geolocalizacion',
        debugShowCheckedModeBanner: false,
        initialRoute: 'ubicaciones-page',
        routes: {
          'ubicaciones-page': (_) => const UbicacionesPage(),
          'mapa-page': (_) => const MapSamplePage(),
        },
      ),
    );
  }
}
