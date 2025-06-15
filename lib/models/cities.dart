import 'dart:convert';
import 'package:flutter/services.dart';

class City {
  final int id;
  final String name;
  final String country;
  final double lat;
  final double lon;

  City({
    required this.id,
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      lat: (json['coord']['lat'] as num).toDouble(),
      lon: (json['coord']['lon'] as num).toDouble(),
    );
  }
}

Future<List<City>> loadCityList() async {
  final String jsonString = await rootBundle.loadString(
    'assets/city_list_filtered.json',
  );
  final List<dynamic> jsonData = json.decode(jsonString);

  return jsonData.map((cityJson) => City.fromJson(cityJson)).toList();
}
