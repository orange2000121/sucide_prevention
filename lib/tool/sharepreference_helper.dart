import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceHelper {
  static final SharePreferenceHelper _instance = SharePreferenceHelper._internal();
  factory SharePreferenceHelper() => _instance;
  SharePreferenceHelper._internal();

  static SharedPreferences? _prefs;
  static const String favoriteKey = 'favorite';
  static const String watchKey = 'watchid';

  Future<SharedPreferences> get prefs async {
    if (_prefs != null) {
      return _prefs!;
    }
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future getJson(String key) async {
    SharedPreferences prefs = await this.prefs;
    String? value = prefs.getString(key);
    if (value == null) {
      return null;
    }
    return json.decode(value);
  }

  Future<bool> setJson(String key, dynamic value) async {
    SharedPreferences prefs = await this.prefs;
    return prefs.setString(key, json.encode(value));
  }

  Future<bool> setString(String key, String value) async {
    SharedPreferences prefs = await this.prefs;
    return prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    SharedPreferences prefs = await this.prefs;
    return prefs.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    SharedPreferences prefs = await this.prefs;
    return prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    SharedPreferences prefs = await this.prefs;
    return prefs.getBool(key);
  }

  Future<bool> setInt(String key, int value) async {
    SharedPreferences prefs = await this.prefs;
    return prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    SharedPreferences prefs = await this.prefs;
    return prefs.getInt(key);
  }

  Future<bool> setDouble(String key, double value) async {
    SharedPreferences prefs = await this.prefs;
    return prefs.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    SharedPreferences prefs = await this.prefs;
    return prefs.getDouble(key);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    SharedPreferences prefs = await this.prefs;
    return prefs.setStringList(key, value);
  }

  Future<List<String>?> getStringList(String key) async {
    SharedPreferences prefs = await this.prefs;
    return prefs.getStringList(key);
  }

  Future<bool> remove(String key) async {
    SharedPreferences prefs = await this.prefs;
    return prefs.remove(key);
  }

  Future<bool> clear() async {
    SharedPreferences prefs = await this.prefs;
    return prefs.clear();
  }
}
