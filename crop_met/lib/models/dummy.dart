import 'package:crop_met/models/current_weather_model.dart';

var dummyJson = {
  "coord": {"lon": 74.1555, "lat": 31.8007},
  "weather": [
    {
      "id": 804,
      "main": "Clouds",
      "description": "overcast clouds",
      "icon": "04n"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 13.34,
    "feels_like": 11.67,
    "temp_min": 13.34,
    "temp_max": 13.34,
    "pressure": 1014,
    "humidity": 36,
    "sea_level": 1014,
    "grnd_level": 990
  },
  "visibility": 10000,
  "wind": {"speed": 3.5, "deg": 49, "gust": 4.97},
  "clouds": {"all": 100},
  "dt": 1738179122,
  "sys": {"country": "PK", "sunrise": 1738202277, "sunset": 1738240511},
  "timezone": 18000,
  "id": 1169692,
  "name": "Muridke",
  "cod": 200
};

CurrentWeather getDummyWeather(var dummyData) {
  CurrentWeather weatherData = CurrentWeather.fromJson(dummyData);
  return weatherData;
}
