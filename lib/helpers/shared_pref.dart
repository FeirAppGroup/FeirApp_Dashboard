import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  static readTimeout() async {
    final prefs = await SharedPreferences.getInstance();

    var existTime = prefs.getInt('expireTime');

    if (existTime != null) {
      int? oldTime = prefs.getInt('expireTime');
      int diff = DateTime.now().millisecondsSinceEpoch - oldTime!;
      prefs.setInt('diff', diff);
    }
  }

  static clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static getIntByKey(String key, obj) async {
    final prefs = await SharedPreferences.getInstance();
    return obj = prefs.getInt(key) ?? "";
  }

  static read(String key, object) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) != null) {
      return object.fromJson(prefs.getString(key) ?? "");
    } else {
      return object = null;
    }
  }

  static save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> valueMap = value!.toMap();
    await prefs.setString(key, json.encode(value));
  }

  static remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
