import 'package:codigo6_alertas/pages/init_page.dart';
import 'package:codigo6_alertas/pages/login_page.dart';
import 'package:codigo6_alertas/utils/sp_global.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SPGlobal prefs = SPGlobal();
  await prefs.initSharedPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlertApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.manropeTextTheme(),
      ),
      home: const PreInit(),
    );
  }
}

class PreInit extends StatelessWidget {
  const PreInit({super.key});

  @override
  Widget build(BuildContext context) {
    return SPGlobal().isLogin ? const InitPage() : const LoginPage();
  }
}
