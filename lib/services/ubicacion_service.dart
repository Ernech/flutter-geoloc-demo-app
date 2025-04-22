import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geoloc_demo_app/models/ubicacion.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UbicacionService with ChangeNotifier {
  final List<Ubicacion> _ubicaciones = [];
  Set<Marker> _markers = {};
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  double _nuevaLatitud = 0.0;
  double _nuevaLongitud = 0.0;
  String _nuevoNombre = '';
  int _accion = 0; //1: Mostrar ubicacion en el mapa, 2: Agregar ubicacion
  Ubicacion _ubicacionSeleccionada = Ubicacion();
  int get accion => _accion;

  List<Ubicacion> get ubicaciones => _ubicaciones;

  Set<Marker> get markers => _markers;

  double get nuevaLatitud => _nuevaLatitud;

  double get nuevaLongitud => _nuevaLongitud;

  String get nuevoNombre => _nuevoNombre;

  Ubicacion get ubicacionSeleccionada => _ubicacionSeleccionada;

  Completer<GoogleMapController> get controller => _controller;

  void addUbicacion(Ubicacion ubicacion) {
    _ubicaciones.add(ubicacion);
    notifyListeners();
  }

  void addMark(int ubicacionId, LatLng latLng) {
    _markers.add(Marker(
      markerId: MarkerId('$ubicacionId'),
      position: LatLng(latLng.latitude, latLng.longitude),
      infoWindow: const InfoWindow(title: ''),
    ));
    notifyListeners();
  }

  void addMarkUbicacionSeleccionada() {
    _markers.add(Marker(
      markerId: MarkerId('${_ubicacionSeleccionada.id}'),
      position: LatLng(
          _ubicacionSeleccionada.latitud!, _ubicacionSeleccionada.longitud!),
      infoWindow: InfoWindow(title: '${_ubicacionSeleccionada.nombre}'),
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

  set ubicacionSeleccionada(Ubicacion ubicacion) {
    _ubicacionSeleccionada = ubicacion;
    notifyListeners();
  }

  void reiniciarUbicacion() {
    _nuevaLatitud = 0.0;
    _nuevaLongitud = 0.0;
    _nuevoNombre = '';
    notifyListeners();
  }

  void cleanMarks() {
    _markers = {};
    notifyListeners();
  }

  Future<LatLng> obtenerCoordenadasActuales() async {
    final posicion = await _determinePosition();
    return LatLng(posicion.latitude, posicion.longitude);
  }

  Future<void> moverPosicionAlUsuario() async {
    final GoogleMapController mapController = await _controller.future;
    final LatLng ubicacion = await obtenerCoordenadasActuales();
    _markers.add(Marker(
      markerId: const MarkerId('0ubicacion_defecto'),
      position: ubicacion,
      infoWindow: const InfoWindow(title: 'Usted se encuentra aqui'),
    ));
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: ubicacion, zoom: 16),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
