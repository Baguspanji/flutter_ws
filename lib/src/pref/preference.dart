import 'package:shared_preferences/shared_preferences.dart';

Future setKdUser(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("kduser", value);
}

Future getKdUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("kduser");
}

Future rmvKdUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("kduser");
}

Future setNama(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("nama", value);
}

Future getNama() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("nama");
}

Future rmvNama() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("nama");
}
