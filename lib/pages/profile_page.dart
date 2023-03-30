import 'package:codigo6_alertas/models/user_model.dart';
import 'package:codigo6_alertas/pages/login_page.dart';
import 'package:codigo6_alertas/services/api_service.dart';
import 'package:codigo6_alertas/ui/general.dart';
import 'package:codigo6_alertas/utils/sp_global.dart';
import 'package:codigo6_alertas/widgets/common_button_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ApiService apiService = ApiService();
  UserModel? user;

  getUserProfile() async {
    user = await apiService.getUser();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return user != null
        ? Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mi perfil",
                                    style: TextStyle(
                                      color: kBrandPrimaryColor,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    user!.nombreCompleto,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                backgroundColor: kBrandPrimaryColor,
                                radius: 50.0,
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 60.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 70.0,
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.document_scanner,
                            ),
                            title: Text(
                              user!.dni,
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.phone,
                            ),
                            title: Text(
                              user!.telefono,
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.maps_home_work,
                            ),
                            title: Text(
                              user!.direccion,
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          CommonButtonWidget(
                            text: "Cerrar sesión",
                            onPressed: () {
                              SPGlobal().isLogin = false;
                              SPGlobal().token = "";
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
