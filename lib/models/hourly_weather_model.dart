import 'package:intl/intl.dart';

class HourlyForecast {
  final String time; // "6:00 AM"
  final String weatherMain;
  final int weatherId;
  final double temp;

  HourlyForecast({
    required this.time,
    required this.weatherMain,
    required this.weatherId,
    required this.temp,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    final dateTime = DateTime.parse(json['dt_txt']);
    final formattedTime = DateFormat.jm().format(dateTime); // e.g. "6:00 AM"

    return HourlyForecast(
      time: formattedTime,
      weatherMain: json['weather'][0]['main'],
      weatherId: json['weather'][0]['id'],
      temp: (json['main']['temp'] as num).toDouble(),
    );
  }
}

class ForecastModel {
  final Map<String, List<HourlyForecast>> _data = {};

  ForecastModel._(); // private constructor

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    final model = ForecastModel._();
    final List<dynamic> forecastList = json['list'];

    for (var item in forecastList) {
      final dateTime = DateTime.parse(item['dt_txt']);
      final dateStr = DateFormat('yyyy-MM-dd').format(dateTime);
      final forecast = HourlyForecast.fromJson(item);

      model._data.putIfAbsent(dateStr, () => []).add(forecast);
    }

    return model;
  }

  /// Get data by index: 0 = today, 1 = tomorrow, up to 4
  List<HourlyForecast> operator [](int index) {
    final date = DateTime.now().add(Duration(days: index));
    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    return _data[dateStr] ?? [];
  }

  /// Optional alias for `model[0]`
  List<HourlyForecast> get today => this[0];
  List<HourlyForecast> get tomorrow => this[1];
}
