class WeatherStationData {
  final String locationId;
  final String temperature;
  final String pressure;
  final String humidity;
  final String windDirectionAngle;
  final String windDirection;
  final String windSpeed;
  final String precipitation;
  final String solarRadiation;
  final String dateTime;
  final String day;

  WeatherStationData({
    required this.locationId,
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.windDirectionAngle,
    required this.windDirection,
    required this.windSpeed,
    required this.precipitation,
    required this.solarRadiation,
    required this.dateTime,
    required this.day,
  });

  factory WeatherStationData.fromJson(Map<String, dynamic> json) {
    return WeatherStationData(
      locationId: json['location_id'] ?? '',
      temperature: json['temperature'] ?? '',
      pressure: json['pressure'] ?? '',
      humidity: json['humidity'] ?? '',
      windDirectionAngle: json['wind_direction_angle'] ?? '',
      windDirection: json['wind_direction'] ?? '',
      windSpeed: json['wind_speed'] ?? '',
      precipitation: json['precipitation'] ?? '',
      solarRadiation: json['solar_radiation'] ?? '',
      dateTime: json['date_time'] ?? '',
      day: json['day'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location_id': locationId,
      'temperature': temperature,
      'pressure': pressure,
      'humidity': humidity,
      'wind_direction_angle': windDirectionAngle,
      'wind_direction': windDirection,
      'wind_speed': windSpeed,
      'precipitation': precipitation,
      'solar_radiation': solarRadiation,
      'date_time': dateTime,
      'day': day,
    };
  }
}
