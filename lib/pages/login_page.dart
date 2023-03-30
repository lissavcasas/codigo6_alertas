import 'package:codigo6_alertas/pages/init_page.dart';
import 'package:codigo6_alertas/pages/register_page.dart';
import 'package:codigo6_alertas/services/api_service.dart';
import 'package:codigo6_alertas/ui/general.dart';
import 'package:codigo6_alertas/utils/types.dart';
import 'package:codigo6_alertas/widgets/common_button_widget.dart';
import 'package:codigo6_alertas/widgets/common_textfield_password_widget.dart';
import 'package:codigo6_alertas/widgets/common_textfield_widget.dart';
import 'package:codigo6_alertas/widgets/general_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _dniController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final loginFormKey = GlobalKey<FormState>();

  bool isLoading = false;

  void login() {
    if (loginFormKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});

      ApiService apiService = ApiService();

      apiService
          .login(_dniController.text, _passwordController.text)
          .then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const InitPage()),
            (route) => false);
      }).catchError((error) {
        isLoading = false;
        setState(() {});

        Map dataError = error as Map;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(dataError["message"]),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Image.network(
                        "https://www.municayma.gob.pe/wp-content/uploads/2021/07/escudo-solo.png",
                        height: 90.0,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Text(
                        "Municipalidad Distrital de Cayma",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff212121),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Text(
                        "Alerta Cayma",
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff212121),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text(
                        "Iniciar Sesión",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff212121),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
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
                      CommonTextFieldPasswordWidget(
                        controller: _passwordController,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      CommonButtonWidget(
                        text: "Iniciar Sesión",
                        onPressed: () {
                          login();
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Aún no estás registrado? ",
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                            child: Text(
                              " Regístrate",
                              style: TextStyle(
                                color: kBrandPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          isLoading
              ? Container(
                  color: Colors.white.withOpacity(0.8),
                  child: loadingWidget,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
