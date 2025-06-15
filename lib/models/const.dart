import 'package:cropmet/models/cities.dart';
import 'package:cropmet/models/current_weather_model.dart';
import 'package:cropmet/models/hourly_weather_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

List<City> allCities = [];

List<HourlyForecast> tomorrowForecastSave = [];
List<HourlyForecast> todayForecastSave = [];
CurrentWeather? data;
ForecastModel? forecastData;

Map<String, String> countryNames = {
  "IT": "Italy",
  "PK": "Pakistan",
  "US": "United States",
  "FR": "France",
  "DE": "Germany",
  "IN": "India",
  "UK": "United Kingdom",
  "CN": "China",
  "JP": "Japan",
  "CA": "Canada",
};

String getCountryName(String countryCode) {
  return countryNames[countryCode] ?? "Unknown";
}

IconData getWeatherIcon(int id) {
  if (id >= 200 && id <= 232) {
    // Thunderstorm
    return WeatherIcons.thunderstorm;
  } else if (id >= 300 && id <= 321) {
    // Drizzle
    return WeatherIcons.sprinkle;
  } else if (id >= 500 && id <= 504) {
    // Light to moderate rain
    return WeatherIcons.rain;
  } else if (id == 511) {
    // Freezing rain
    return WeatherIcons.sleet;
  } else if (id >= 520 && id <= 531) {
    // Shower rain
    return WeatherIcons.showers;
  } else if (id >= 600 && id <= 602) {
    // Light to heavy snow
    return WeatherIcons.snow;
  } else if (id >= 611 && id <= 616) {
    // Sleet or mixed snow/rain
    return WeatherIcons.sleet;
  } else if (id >= 620 && id <= 622) {
    // Snow showers
    return WeatherIcons.snow_wind;
  } else if (id >= 700 && id <= 781) {
    // Atmosphere: mist, smoke, haze, dust, fog, sand, ash, squall, tornado
    return WeatherIcons.fog;
  } else if (id == 800) {
    // Clear sky
    return WeatherIcons.day_sunny;
  } else if (id == 801) {
    // Few clouds
    return WeatherIcons.day_cloudy;
  } else if (id == 802) {
    // Scattered clouds
    return WeatherIcons.cloud;
  } else if (id == 803 || id == 804) {
    // Broken/overcast clouds
    return WeatherIcons.cloudy;
  } else {
    // Default fallback icon
    return WeatherIcons.na;
  }
}

IconData getWeatherIconFromTemp(double tempCelsius) {
  if (tempCelsius <= -20) {
    // Extreme cold
    return WeatherIcons.snowflake_cold;
  } else if (tempCelsius > -20 && tempCelsius <= 0) {
    // Freezing to cold
    return WeatherIcons.snow;
  } else if (tempCelsius > 0 && tempCelsius <= 10) {
    // Chilly
    return WeatherIcons.cloudy;
  } else if (tempCelsius > 10 && tempCelsius <= 20) {
    // Cool to mild
    return WeatherIcons.day_cloudy;
  } else if (tempCelsius > 20 && tempCelsius <= 30) {
    // Pleasant to warm
    return WeatherIcons.day_sunny_overcast;
  } else if (tempCelsius > 30 && tempCelsius <= 38) {
    // Hot
    return WeatherIcons.day_sunny;
  } else if (tempCelsius > 38 && tempCelsius <= 45) {
    // Very hot
    return WeatherIcons.hot;
  } else if (tempCelsius > 45) {
    // Extreme heat
    return WeatherIcons.fire;
  } else {
    // Fallback
    return WeatherIcons.na;
  }
}

Map<int, String> getNextFiveDaysMap() {
  final now = DateTime.now();
  final formatter = DateFormat('EEEE, dd MMMM'); // Example: Monday, 02 June

  return {
    for (int i = 0; i < 5; i++) i: formatter.format(now.add(Duration(days: i))),
  };
}
