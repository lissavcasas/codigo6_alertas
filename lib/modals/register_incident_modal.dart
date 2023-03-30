import 'package:codigo6_alertas/models/incident_type_model.dart';
import 'package:codigo6_alertas/services/api_service.dart';
import 'package:codigo6_alertas/widgets/common_button_widget.dart';
import 'package:codigo6_alertas/widgets/general_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RegisterIncidentModal extends StatefulWidget {
  final List<IncidentType> incidentsType;

  const RegisterIncidentModal({
    Key? key,
    required this.incidentsType,
  }) : super(key: key);

  @override
  State<RegisterIncidentModal> createState() => _RegisterIncidentModalState();
}

class _RegisterIncidentModalState extends State<RegisterIncidentModal> {
  int intIndexIncidentType = 1;
  bool isLoading = false;
  ApiService apiService = ApiService();

  registerIncident() async {
    isLoading = true;
    setState(() {});
    Position position = await Geolocator.getCurrentPosition();
    apiService.registerIncident(intIndexIncidentType, position).then((value) {
      isLoading = false;
      setState(() {});
      Navigator.pop(context);
    }).catchError(
      (error) {
        isLoading = false;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Enviar Alerta",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 12.0,
                      color: Colors.black.withOpacity(0.07),
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: DropdownButton(
                  underline: const SizedBox(),
                  isExpanded: true,
                  value: intIndexIncidentType,
                  borderRadius: BorderRadius.circular(14.0),
                  items: widget.incidentsType
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(e.titulo),
                        ),
                      )
                      .toList(),
                  onChanged: (int? value) {
                    intIndexIncidentType = value!;
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              CommonButtonWidget(
                text: "Enviar",
                onPressed: () {
                  registerIncident();
                },
              ),
            ],
          ),
        ),
        isLoading
            ? Container(
                color: Colors.white.withOpacity(0.7),
                child: loadingWidget,
              )
            : const SizedBox(),
      ],
    );
  }
}
