// import 'package:cropmet/models/current_weather_model.dart';
// import 'package:cropmet/models/hourly_weather_model.dart';
// import 'package:cropmet/models/weather_station_data.dart';

// var dummyJson = {
//   "coord": {"lon": 74.1555, "lat": 31.8007},
//   "weather": [
//     {
//       "id": 601,
//       "main": "Thunderstorm",
//       "description": "overcast clouds",
//       "icon": "04n",
//     },
//   ],
//   "base": "stations",
//   "main": {
//     "temp": 13.34,
//     "feels_like": 11.67,
//     "temp_min": 13.34,
//     "temp_max": 13.34,
//     "pressure": 1014,
//     "humidity": 36,
//     "sea_level": 1014,
//     "grnd_level": 990,
//   },
//   "visibility": 10000,
//   "wind": {"speed": 3.5, "deg": 49, "gust": 4.97},
//   "clouds": {"all": 100},
//   "dt": 1738179122,
//   "sys": {"country": "PK", "sunrise": 1738202277, "sunset": 1738240511},
//   "timezone": 18000,
//   "id": 1169692,
//   "name": "Muridke",
//   "cod": 200,
// };

// CurrentWeather getDummyWeather(var dummyData) {
//   CurrentWeather weatherData = CurrentWeather.fromJson(dummyData);
//   return weatherData;
// }

// final List<HourlyForecast> todayForecast = [
//   HourlyForecast(
//     time: '06:00 PM',
//     weatherMain: 'Clear',
//     weatherId: 800,
//     temp: 38.52,
//   ),
//   HourlyForecast(
//     time: '09:00 PM',
//     weatherMain: 'Clear',
//     weatherId: 800,
//     temp: 37.77,
//   ),
// ];

// final List<HourlyForecast> tomorrowForecast = [
//   HourlyForecast(
//     time: '12:00 AM',
//     weatherMain: 'Clear',
//     weatherId: 800,
//     temp: 35.89,
//   ),
//   HourlyForecast(
//     time: '03:00 AM',
//     weatherMain: 'Clear',
//     weatherId: 800,
//     temp: 39.75,
//   ),
//   HourlyForecast(
//     time: '06:00 AM',
//     weatherMain: 'Clear',
//     weatherId: 800,
//     temp: 45.01,
//   ),
//   HourlyForecast(
//     time: '09:00 AM',
//     weatherMain: 'Clear',
//     weatherId: 800,
//     temp: 47.85,
//   ),
//   HourlyForecast(
//     time: '12:00 PM',
//     weatherMain: 'Clear',
//     weatherId: 800,
//     temp: 47.76,
//   ),
//   HourlyForecast(
//     time: '03:00 PM',
//     weatherMain: 'Clear',
//     weatherId: 800,
//     temp: 42.18,
//   ),
//   HourlyForecast(
//     time: '06:00 PM',
//     weatherMain: 'Clear',
//     weatherId: 800,
//     temp: 38.04,
//   ),
//   HourlyForecast(
//     time: '09:00 PM',
//     weatherMain: 'Clear',
//     weatherId: 800,
//     temp: 34.69,
//   ),
// ];

// var dum = {
//   "location_id": "1",
//   "temperature": "40.3",
//   "pressure": "998.8",
//   "humidity": "45",
//   "wind_direction_angle": "20",
//   "wind_direction": "NNE",
//   "wind_speed": "0",
//   "precipitation": "0",
//   "solar_radiation": "104",
//   "date_time": "14 May 2025",
//   "day": "Wednesday",
// };

// WeatherStationData getDummyWeatherStation(var dum) {
//   WeatherStationData weatherData = WeatherStationData.fromJson(dum);
//   return weatherData;
// }
