import 'package:flutter/material.dart';
import 'package:geoloc_demo_app/models/ubicacion.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UbicacionService with ChangeNotifier {
  final List<Ubicacion> _ubicaciones = [];
  final Set<Marker> _markers = {};
  int _accion = 0;

  int get accion => _accion;

  List<Ubicacion> get ubicaciones => _ubicaciones;

  void addUbicacion(Ubicacion ubicacion) {
    _ubicaciones.add(ubicacion);
    notifyListeners();
  }

  void addMark(int ubicacionId, LatLng latLng) {
    _markers.add(Marker(
      markerId: MarkerId('$ubicacionId'),
      position: LatLng(latLng.latitude, latLng.longitude),
      infoWindow: const InfoWindow(title: 'La paz Bolivia'),
    ));
    notifyListeners();
  }

  set accion(int accion) {
    _accion = accion;
    notifyListeners();
  }
}
