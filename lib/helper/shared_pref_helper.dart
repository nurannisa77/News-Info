import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const String _newUserKey = 'newUser';

  static Future<SharedPreferences> _getPrefs() async =>
      await SharedPreferences.getInstance();

  static Future<bool> newUser() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_newUserKey) ?? true;
  }

  static Future<void> setFirstTime(bool newUser) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_newUserKey, newUser);
  }
}
