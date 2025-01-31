import 'dart:convert';

import 'package:crop_met/models/current_weather_model.dart';
import 'package:http/http.dart' as http;

class ApiRequests {
  static const String apiKey = "3eaa15718c39f0de6c7091e526424f75";

  static Future<CurrentWeather?> fetchWeather(double lat, double lon) async {
    final String url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

    try {
      print("Requesting: $url");
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        print("this is data: $jsonData");
        return CurrentWeather.fromJson(jsonData);
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Failed to fetch weather: $e");
      return null;
    }
  }

  static Future<CurrentWeather?> fetchHourlyWeather(
      double lat, double lon) async {
    final String url =
        "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

    try {
      print("Requesting: $url");
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        print("this is data: $jsonData");
        return CurrentWeather.fromJson(jsonData);
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Failed to fetch weather: $e");
      return null;
    }
  }
}
