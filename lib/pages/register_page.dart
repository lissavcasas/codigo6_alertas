import 'package:codigo6_alertas/models/user_model.dart';
import 'package:codigo6_alertas/services/api_service.dart';
import 'package:codigo6_alertas/ui/general.dart';
import 'package:codigo6_alertas/utils/types.dart';
import 'package:codigo6_alertas/widgets/common_button_widget.dart';
import 'package:codigo6_alertas/widgets/common_textfield_password_widget.dart';
import 'package:codigo6_alertas/widgets/common_textfield_widget.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  final TextEditingController _nombreCompletoController =
      TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();

  register() {
    if (registerFormKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});

      ApiService apiService = ApiService();
      apiService
          .register(
              UserModel(
                id: 0,
                nombreCompleto: _nombreCompletoController.text,
                dni: _dniController.text,
                telefono: _telefonoController.text,
                direccion: _direccionController.text,
              ),
              _passwordController.text)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Usuario creado con éxito.",
            ),
          ),
        );
        Navigator.pop(context);

        isLoading = false;
        setState(() {});
      }).catchError(
        (error) {
          isLoading = false;
          setState(() {});

          Map dataError = error as Map;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(dataError["message"]),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDEEED),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: registerFormKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            Text(
                              "Registro",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff212121),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CommonTextFieldWidget(
                          label: "Nombre Completo",
                          hintText: "Tu Nombre",
                          type: InputType.text,
                          controller: _nombreCompletoController,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        CommonTextFieldWidget(
                          label: "DNI",
                          hintText: "Tu DNI",
                          type: InputType.dni,
                          controller: _dniController,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        CommonTextFieldWidget(
                          label: "Teléfono",
                          hintText: "Tu Teléfono",
                          type: InputType.phone,
                          controller: _telefonoController,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        CommonTextFieldWidget(
                          label: "Dirección",
                          hintText: "Tu Dirección",
                          type: InputType.text,
                          controller: _direccionController,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        CommonTextFieldPasswordWidget(
                          controller: _passwordController,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        CommonButtonWidget(
                          text: "Crear cuenta",
                          onPressed: () {
                            register();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Ya tengo una cuenta, ",
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "inicia sesión aquí",
                                style: TextStyle(
                                  color: kBrandPrimaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          isLoading
              ? Container(
                  color: Colors.white.withOpacity(0.8),
                  child: const Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 2.6,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
