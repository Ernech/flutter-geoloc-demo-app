import 'package:flutter/material.dart';
import 'package:geoloc_demo_app/models/ubicacion.dart';
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
          if (!ubicacionService.controller.isCompleted) {
            ubicacionService.controller.complete(controller);
          }
        },
        onTap: ubicacionService.accion == 1
            ? null
            : (latLng) {
                ubicacionService.addMark(
                    ubicacionService.ubicaciones.length + 1, latLng);
                ubicacionService.nuevaLatitud = latLng.latitude;
                ubicacionService.nuevaLongitud = latLng.longitude;
                _showAlertDialog(context, ubicacionService);
              },
        markers: ubicacionService.markers,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: ubicacionService.accion == 1
      //       ? null
      //       : () {
      //           _showAlertDialog(context, ubicacionService);
      //         },
      //   backgroundColor: Colors.grey,
      //   child: const Icon(
      //     Icons.add_rounded,
      //     color: Colors.white,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _showAlertDialog(BuildContext context, UbicacionService ubicacionService) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar Ubicacion'),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Ingrese un nombre para la ubicacion'),
                  const SizedBox(
                    height: 3.0,
                  ),
                  TextField(
                    obscureText: false,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0))),
                        labelText: 'Ubicacion'),
                    onChanged: (value) {
                      ubicacionService.nuevoNombre = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                //Navigator.pop(context);
                if (ubicacionService.nuevoNombre.isEmpty ||
                    ubicacionService.nuevaLatitud == 0.0 ||
                    ubicacionService.nuevaLongitud == 0.0) {
                  return;
                }
                Ubicacion nuevaUbicacion = Ubicacion(
                    id: ubicacionService.ubicaciones.length + 1,
                    latitud: ubicacionService.nuevaLatitud,
                    longitud: ubicacionService.nuevaLongitud,
                    nombre: ubicacionService.nuevoNombre);
                ubicacionService.addUbicacion(nuevaUbicacion);
                ubicacionService.reiniciarUbicacion();
                Navigator.pop(context);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
