import 'package:cropmet/apis/api_requests.dart';
import 'package:cropmet/components/display_box.dart';
import 'package:cropmet/components/notification.dart';
import 'package:cropmet/models/const.dart';
import 'package:cropmet/models/hourly_weather_model.dart';
import 'package:cropmet/models/weather_station_data.dart';
import 'package:cropmet/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherStationsDisplay extends StatefulWidget {
  final String tab;

  const WeatherStationsDisplay({super.key, required this.tab});

  @override
  State<WeatherStationsDisplay> createState() => _WeatherStationsDisplayState();
}

class _WeatherStationsDisplayState extends State<WeatherStationsDisplay> {
  WeatherStationData? model;
  ForecastModel? forecastMap;
  List<HourlyForecast>? dailyForecasts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void didUpdateWidget(covariant WeatherStationsDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tab != widget.tab) {
      // trigger data reload when tab changes
      fetchData();
    }
  }

  void fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      bool hasInternet = await InternetConnection().hasInternetAccess;
      if (hasInternet) {
        if (widget.tab == "Faisalabad") {
          WeatherStationData? res = await ApiRequests.fetchWeatherStationData(
            1,
          );
          getDataHourly(73.07076, 31.42975);
          if (res != null) {
            setState(() {
              model = res;
            });
          } else {
            showBottomSnackBar(context, "No data found for Faisalabad");
          }
        } else if (widget.tab == "TT Singh") {
          WeatherStationData? res = await ApiRequests.fetchWeatherStationData(
            4,
          );
          getDataHourly(72.452834, 30.911078);
          if (res != null) {
            setState(() {
              model = res;
            });
          } else {
            showBottomSnackBar(context, "No data found for TT Singh");
          }
        } else if (widget.tab == "Okara") {
          WeatherStationData? res = await ApiRequests.fetchWeatherStationData(
            3,
          );
          getDataHourly(73.532486, 30.851432);
          if (res != null) {
            setState(() {
              model = res;
            });
          } else {
            showBottomSnackBar(context, "No data found for Okara");
          }
        } else if (widget.tab == "Burewala") {
          WeatherStationData? res = await ApiRequests.fetchWeatherStationData(
            2,
          );
          getDataHourly(72.717624, 30.2264901);
          // Using hardcoded coordinates for Burewala
          if (res != null) {
            setState(() {
              model = res;
            });
          } else {
            showBottomSnackBar(context, "No data found for Burewala");
          }
        } else {
          // throw Exception("Invalid tab selected");
        }
      } else {
        showBottomSnackBar(context, "No internet connection");
      }
    } catch (e) {
      showBottomSnackBar(context, "Error fetching data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getDataHourly(double lat, double long) async {
    setState(() {
      isLoading = true;
    });

    double latitude = lat;
    double longitude = long;

    try {
      var _forecastMap = await ApiRequests.fetchHourlyWeather(
        latitude,
        longitude,
      );

      setState(() {
        forecastMap = _forecastMap;
        if (forecastMap == null) {
          showBottomSnackBar(context, "No hourly forecast data available.");
          return;
        }
        dailyForecasts = getFirstHourlyForecasts(_forecastMap!);
        isLoading = false;
      });
    } catch (e) {
      showBottomSnackBar(context, "Error fetching weather data.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<HourlyForecast> getFirstHourlyForecasts(ForecastModel model) {
    List<HourlyForecast> firstForecasts = [];

    for (int i = 0; i < 5; i++) {
      final dayForecasts = model[i];
      if (dayForecasts.isNotEmpty) {
        firstForecasts.add(dayForecasts.first);
      }
    }

    return firstForecasts;
  }

  @override
  Widget build(BuildContext context) {
    Map<int, String> days = getNextFiveDaysMap();
    // int index = 0;
    return isLoading
        ? CircularProgressIndicator(color: primaryColorNav)
        : SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              model == null
                  ? Center(
                    child: Text(
                      "No weather stations data available",
                      style: TextStyle(color: primaryColor, fontSize: 14),
                    ),
                  )
                  : Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.mapPin,
                                color: primaryColor1,
                                size: 15,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "${widget.tab} Station",
                                style: TextStyle(
                                  color: primaryColor1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${model!.temperature}°C",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      // decoration: BoxDecoration(border: Border.all()),
                                      child: Icon(
                                        getWeatherIconFromTemp(
                                          double.tryParse(model!.temperature) ??
                                              0.0,
                                        ),
                                        color: primaryColor,
                                        size: 50,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(height: 10),
                              Text(
                                "Current weather",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                  // fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                        GridView.count(
                          crossAxisCount: 3,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),

                          children: [
                            weatherInfoBox(
                              WeatherIcons.humidity,
                              "${model!.humidity} %",
                              "Humidity",
                            ),
                            weatherInfoBox(
                              WeatherIcons.barometer,
                              "${model!.pressure} mb",
                              "Pressure",
                            ),
                            weatherInfoBox(
                              WeatherIcons.raindrop,
                              "${model!.precipitation} mm",
                              "Precipitation",
                            ),
                            weatherInfoBox(
                              WeatherIcons.wind_deg_45,
                              "${model!.windDirection} - ${model!.windDirectionAngle}°",
                              "Wind Direction",
                            ),
                            weatherInfoBox(
                              WeatherIcons.strong_wind,
                              "${model!.windSpeed} km/h",
                              "Wind Speed",
                            ),
                            weatherInfoBox(
                              WeatherIcons.day_sunny,
                              "${model!.solarRadiation} W/m²",
                              "Solar Radiation",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              SizedBox(height: 40),
              if (dailyForecasts == null || dailyForecasts!.isEmpty) ...[
                Center(
                  child: Text(
                    "No forecast data available",
                    style: TextStyle(color: primaryColor, fontSize: 14),
                  ),
                ),
              ] else ...[
                Center(
                  child: Text(
                    "Forecast weather",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Wrap(
                    spacing: 25,
                    runSpacing: 20,
                    children: [
                      for (int i = 0; i < (dailyForecasts?.length ?? 0); i++)
                        forecastInfoBoxByDay(
                          day: days[i] ?? "N/A",
                          icon: getWeatherIcon(dailyForecasts![i].weatherId),
                          temp: dailyForecasts![i].temp,
                        ),
                    ],
                  ),
                ),
              ],

              SizedBox(height: 20),
            ],
          ),
        );
  }

  Widget forecastInfoBoxByDay({
    required String day,
    required IconData icon,
    required double temp,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 100,
      decoration: BoxDecoration(
        color: bgNav,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              day,
              style: TextStyle(fontSize: 12, color: primaryColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Icon(icon, size: 30, color: primaryColor1),
          ),
          Text(
            "${temp.toStringAsFixed(0)}°",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
