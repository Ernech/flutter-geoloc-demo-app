import 'package:flutter/material.dart';
import 'package:geoloc_demo_app/services/ubicacion_service.dart';
import 'package:provider/provider.dart';

class UbicacionesPage extends StatelessWidget {
  const UbicacionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ubicacionService = Provider.of<UbicacionService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ubicaciones',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) => ListTile(
                title: Text('Ubicacion - ${index + 1}'),
                leading: const Icon(Icons.location_on),
                trailing: const Icon(Icons.arrow_forward_ios),
                subtitle: const Text('Coordenadas: 12.22115515 - -58.21515115'),
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'mapa-page');
        },
        backgroundColor: Colors.grey,
        child: const Icon(
          Icons.add_location_alt_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
