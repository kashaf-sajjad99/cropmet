import 'package:hive_flutter/adapters.dart';

class HiveService {
  /// Initialize Hive and open required boxes
  static Future<void> initializeHive() async {
    try {
      await Hive.initFlutter();
      await Hive.openBox<Map<dynamic, dynamic>>('CurrentWeather');
      // await Hive.openBox<Map<dynamic, dynamic>>('WeatherForecast');
      // await Hive.openBox<Map<dynamic, dynamic>>('WeatherStations');
    } catch (e) {
      print('Error initializing Hive: $e');
    }
  }

  static Future<void> insertOrUpdateWeather(
    Map<dynamic, dynamic> newWeatherData,
  ) async {
    try {
      var box = Hive.box<Map<dynamic, dynamic>>('CurrentWeather');

      // Always overwrite the same key with the latest weather data
      await box.put('currentWeather', newWeatherData);

      print('Weather data updated: $newWeatherData');
    } catch (e) {
      print('Error updating weather data: $e');
    }
  }

  static Future<Map<dynamic, dynamic>?> getCurrentWeather() async {
    try {
      var box = Hive.box<Map<dynamic, dynamic>>('CurrentWeather');
      return box.get('currentWeather');
    } catch (e) {
      print('Error retrieving current weather: $e');
      return null;
    }
  }
}
