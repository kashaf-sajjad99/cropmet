import 'dart:convert';
import 'package:cropmet/models/current_weather_model.dart';
import 'package:cropmet/models/hourly_weather_model.dart';
import 'package:cropmet/models/weather_station_data.dart';
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

  static Future<CurrentWeather?> fetchWeatherByCity(
    String city,
    String countryCode,
  ) async {
    final String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city,$countryCode&appid=$apiKey&units=metric";

    try {
      print("Requesting: $url");
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        print("Weather data: $jsonData");
        return CurrentWeather.fromJson(jsonData);
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Failed to fetch weather by city: $e");
      return null;
    }
  }

  static Future<ForecastModel?> fetchHourlyWeather(
    double lat,
    double lon,
  ) async {
    final String url =
        "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

    try {
      print("Requesting: $url");
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        print("Data fetched ✅");

        // Parse the JSON into the desired structure
        return ForecastModel.fromJson(jsonData);
      } else {
        print("❌ Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ Failed to fetch weather: $e");
      return null;
    }
  }

  static Future<WeatherStationData?> fetchWeatherStationData(int id) async {
    final String url =
        "https://cropmet.paluaf.com/api/getweather/$id/Im0MidCW1sHSrn0n7O9fSSRlqJSXMuXk";

    try {
      print("Requesting: $url");
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body); // FIXED
        print("Data fetched ✅");

        if (jsonData.isNotEmpty) {
          return WeatherStationData.fromJson(jsonData[0]);
        } else {
          print("⚠️ Empty data");
          return null;
        }
      } else {
        print("❌ Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ Failed to fetch weather: $e");
      return null;
    }
  }
}
