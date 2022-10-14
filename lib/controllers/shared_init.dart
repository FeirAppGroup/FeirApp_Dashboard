import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

var logged;

Future<void> initPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
}

getPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}

clearPrefs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
}
