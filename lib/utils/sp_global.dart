import 'package:shared_preferences/shared_preferences.dart';

class SPGlobal {
  static final SPGlobal _instance = SPGlobal._();
  SPGlobal._();

  factory SPGlobal() {
    return _instance;
  }

  late SharedPreferences prefs;

  initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  set token(String value) {
    prefs.setString("token", value);
  }

  String get token => prefs.getString("token") ?? "";

  set isLogin(bool value) {
    prefs.setBool("isLogin", value);
  }

  bool get isLogin => prefs.getBool("isLogin") ?? false;

  set id(int value) {
    prefs.setInt("id", value);
  }

  int get id => prefs.getInt("id") ?? 0;
}
