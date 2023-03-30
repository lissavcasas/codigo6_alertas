import 'package:codigo6_alertas/modals/register_incident_modal.dart';
import 'package:codigo6_alertas/models/incident_model.dart';
import 'package:codigo6_alertas/models/incident_type_model.dart';
import 'package:codigo6_alertas/services/api_service.dart';
import 'package:codigo6_alertas/ui/general.dart';
import 'package:codigo6_alertas/widgets/general_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  List<IncidentType> incidentsType = [];

  @override
  void initState() {
    super.initState();
    apiService.getTypeIncidents().then((value) {
      incidentsType = value;
    });
  }

  showSendIncident() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RegisterIncidentModal(incidentsType: incidentsType);
      },
    ).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSendIncident();
        },
        backgroundColor: kBrandPrimaryColor,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
            ),
            child: Column(
              children: [
                const Text(
                  "Alertas Generales",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                FutureBuilder(
                  future: apiService.getIncidents(),
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (snap.hasData) {
                      List<IncidentModel> incidents = snap.data;
                      return ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: incidents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 6.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                14.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 12,
                                  offset: const Offset(4, 4),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(
                                incidents[index].tipoIncidente.titulo,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    incidents[index].datosCiudadano.nombres,
                                  ),
                                  Text(
                                    "DNI: ${incidents[index].datosCiudadano.dni}",
                                  ),
                                  Text(
                                    incidents[index].fecha,
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Uri url = Uri.parse(
                                          "http://maps.google.com/?q=${incidents[index].latitud},${incidents[index].longitud}");
                                      launchUrl(url,
                                          mode: LaunchMode.externalApplication);
                                    },
                                    icon: Icon(
                                      Icons.map,
                                      color: kBrandPrimaryColor,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Uri uriPhone = Uri(
                                        scheme: "tel",
                                        path: incidents[index]
                                            .datosCiudadano
                                            .telefono,
                                      );
                                      launchUrl(uriPhone);
                                    },
                                    icon: Icon(
                                      Icons.call,
                                      color: kBrandPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return loadingWidget;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
