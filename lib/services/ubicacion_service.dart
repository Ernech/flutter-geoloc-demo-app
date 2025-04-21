import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geoloc_demo_app/models/ubicacion.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UbicacionService with ChangeNotifier {
  final List<Ubicacion> _ubicaciones = [];
  final Set<Marker> _markers = {};
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  double _nuevaLatitud = 0.0;
  double _nuevaLongitud = 0.0;
  String _nuevoNombre = '';
  int _accion = 0;

  int get accion => _accion;

  List<Ubicacion> get ubicaciones => _ubicaciones;

  Set<Marker> get markers => _markers;

  double get nuevaLatitud => _nuevaLatitud;

  double get nuevaLongitud => _nuevaLongitud;

  String get nuevoNombre => _nuevoNombre;

  Completer<GoogleMapController> get controller => _controller;

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

  set nuevaLatitud(double latitud) {
    _nuevaLatitud = latitud;
    notifyListeners();
  }

  set nuevaLongitud(double longitud) {
    _nuevaLongitud = longitud;
    notifyListeners();
  }

  set nuevoNombre(String nombre) {
    _nuevoNombre = nombre;
    notifyListeners();
  }

  void reiniciarUbicacion() {
    _nuevaLatitud = 0.0;
    _nuevaLongitud = 0.0;
    _nuevoNombre = '';
    notifyListeners();
  }
}
