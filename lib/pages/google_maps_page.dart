import 'package:flutter/material.dart';
import 'package:geoloc_demo_app/services/ubicacion_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GoogleMapPage extends StatelessWidget {
  const GoogleMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ubicacionService = Provider.of<UbicacionService>(context);
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          ubicacionService.controller.complete(controller);
        },
        onTap: (latLng) {
          // setState(() {
          //   _markers.add(Marker(
          //     markerId: MarkerId('${_markers.length + 1}'),
          //     position: LatLng(latLng.latitude, latLng.longitude),
          //     infoWindow: const InfoWindow(title: 'La paz Bolivia'),
          //   ));
          // });
        },
        //  markers: _markers,
      ),
    );
  }
}
