import 'package:flutter/material.dart';

class UbicacionesPage extends StatelessWidget {
  const UbicacionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localizaciones'),
      ),
      body: const Center(
        child: Text('Ubicaciones map'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.ad_units),
      ),
    );
  }
}
