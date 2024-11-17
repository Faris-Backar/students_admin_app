import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  SharedPrefManager._internal();

  static final SharedPrefManager _instance = SharedPrefManager._internal();

  factory SharedPrefManager() {
    return _instance;
  }

  static SharedPreferences? _preferences;

  static Future<void> initialise() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static SharedPreferences? get prefs {
    if (_preferences == null) {
      throw Exception(
          "SharedPrefernceManager must be initilized before accessing prefs.");
    }
    return _preferences;
  }

  static String getString(String key, {String defaultValue = ""}) {
    return prefs!.getString(key) ?? defaultValue;
  }

  static Future<bool> setString(String key, String value) {
    return prefs!.setString(key, value);
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return prefs!.getInt(key) ?? defaultValue;
  }

  static Future<bool> setInt(String key, int value) {
    return prefs!.setInt(key, value);
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return prefs!.getBool(key) ?? defaultValue;
  }

  static Future<bool> setBool(String key, bool value) {
    return prefs!.setBool(key, value);
  }

  static double getDouble(String key, {double defaultValue = 0.0}) {
    return prefs!.getDouble(key) ?? defaultValue;
  }

  static Future<bool> setDouble(String key, double value) {
    return prefs!.setDouble(key, value);
  }

  static List<String>? getStringList(String key) {
    return prefs!.getStringList(key);
  }

  static Future<bool> setStringList(String key, List<String> value) {
    return prefs!.setStringList(key, value);
  }

  static Future<bool>? remove(String key) {
    return prefs!.remove(key);
  }

  static Future<bool> clear() {
    return prefs!.clear();
  }
}
