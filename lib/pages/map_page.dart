import 'package:codigo6_alertas/models/incident_model.dart';
import 'package:codigo6_alertas/services/api_service.dart';
import 'package:codigo6_alertas/widgets/common_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Marker> myMarkers = {};
  ApiService apiService = ApiService();

  void showIncidentDetail(IncidentModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Detalle de la alerta",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Text(
                model.tipoIncidente.titulo,
              ),
              Text(
                model.datosCiudadano.nombres,
              ),
              Text(
                model.datosCiudadano.dni,
              ),
              Text(
                model.datosCiudadano.telefono,
              ),
              Text(
                "${model.fecha} ${model.hora}",
              ),
              const SizedBox(
                height: 12.0,
              ),
              CommonButtonWidget(
                text: "Aceptar",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: apiService.getIncidents(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            List<IncidentModel> incidents = snap.data;

            for (var item in incidents) {
              Marker myMarker = Marker(
                markerId: MarkerId(
                  myMarkers.length.toString(),
                ),
                position: LatLng(item.latitud, item.longitud),
                onTap: () {
                  showIncidentDetail(item);
                },
              );
              myMarkers.add(myMarker);
            }

            return GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(-16.378531, -71.558272),
                zoom: 14,
              ),
              markers: myMarkers,
              // onTap: (LatLng position) {
              //   Marker marker = Marker(
              //     markerId: MarkerId(myMarkers.length.toString()),
              //     position: position,
              //   );
              //   myMarkers.add(marker);
              //   setState(() {});
              //   //print(position);
              // },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
