import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String _firstTimeKey = 'firstTime';

  /// Check if the app is launched for the first time
  static Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstTimeKey) ?? true;
  }

  /// Set the flag when the user accepts
  static Future<void> setFirstTimeFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstTimeKey, false);
  }
}
