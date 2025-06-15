import 'package:cropmet/apis/api_requests.dart';
import 'package:cropmet/components/check_permission.dart';
import 'package:cropmet/components/display_box.dart';
import 'package:cropmet/components/notification.dart';
import 'package:cropmet/models/const.dart';
import 'package:cropmet/models/current_weather_model.dart';
import 'package:cropmet/models/hourly_weather_model.dart';
import 'package:cropmet/screens/forecast_screen.dart';
import 'package:cropmet/services/db_hive.dart';
import 'package:cropmet/services/internet_check.dart';
import 'package:cropmet/services/location_check.dart';
import 'package:cropmet/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  CurrentWeather? weatherData;
  ForecastModel? forecastMap;
  List<HourlyForecast>? todayData;
  List<HourlyForecast>? tomorrowData;
  bool isLoading = false;
  int? icon;

  @override
  void initState() {
    super.initState();
    // weatherData = getDummyWeather(dummyJson);
    checkPermissionAndGetData();
  }

  void checkPermissionAndGetData() async {
    // Check for location permission when the app starts
    setState(() {
      isLoading = true;
    });
    try {
      bool res = await checkPermission(context);

      if (res) {
        // If permission is granted, fetch the weather data
        bool hasInternet = await InternetConnection().hasInternetAccess;

        if (hasInternet) {
          await getDataforRefresh();
        } else {
          // If no internet, show a dialog
          showBottomSnackBar(context, "No internet connection!");
          var data = await HiveService.getCurrentWeather();

          CurrentWeather? fetchedData =
              data != null ? CurrentWeather.fromMap(data) : null;
          setState(() {
            weatherData = fetchedData;
          });
        }
      } else {
        // If permission is denied, show a dialog
        showBottomSnackBar(context, "Please allow location.");
      }
    } catch (e) {
      showBottomSnackBar(context, "Failed to load weather data.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> toRefreshData() async {
    bool hasInternet = await InternetConnection().hasInternetAccess;
    if (hasInternet) {
      await Future.wait([getData(), getDataHourly()]);
    } else {
      // If no internet, show a dialog
      showBottomSnackBar(context, "No internet connection!");
      var data = await HiveService.getCurrentWeather();
      CurrentWeather? fetchedData =
          data != null ? CurrentWeather.fromMap(data) : null;
      setState(() {
        weatherData = fetchedData;
      });
    }
  }

  Future<void> getDataforRefresh() async {
    if (todayForecastSave.isEmpty ||
        tomorrowForecastSave.isEmpty ||
        data == null ||
        forecastMap == null) {
      await Future.wait([getData(), getDataHourly()]);
    } else {
      setState(() {
        weatherData = data;
        todayData = todayForecastSave;
        tomorrowData = tomorrowForecastSave;
        forecastData = forecastMap;
      });
    }
  }

  Future<void> getData() async {
    Position? position = await LocationService.getUserLocation();
    if (position != null) {
      double latitude = position.latitude;
      double longitude = position.longitude;

      try {
        var fetchedData = await ApiRequests.fetchWeather(latitude, longitude);
        if (fetchedData == null) {
          showBottomSnackBar(context, "Failed to fetch weather data.");
          setState(() {
            isLoading = false;
          });
          return;
        }
        Map<dynamic, dynamic> weatherMap = fetchedData.toMap();
        // Save the fetched weather data to Hive
        await HiveService.insertOrUpdateWeather(weatherMap);

        setState(() {
          weatherData = fetchedData;
          data = fetchedData;
          isLoading = false;
        });
      } catch (e) {
        showBottomSnackBar(context, "Error fetching weather data.");
      } finally {}
    } else {
      showBottomSnackBar(context, "Failed to get location.");
    }
  }

  Future<void> getDataHourly() async {
    Position? position = await LocationService.getUserLocation();
    if (position != null) {
      double latitude = position.latitude;
      double longitude = position.longitude;

      try {
        var _forecastMap = await ApiRequests.fetchHourlyWeather(
          latitude,
          longitude,
        );

        setState(() {
          forecastMap = _forecastMap;
          filterData();
          isLoading = false;
        });
      } catch (e) {
        showBottomSnackBar(context, "Error fetching weather data.");
      } finally {}
    } else {
      showBottomSnackBar(context, "Failed to get location.");
    }
  }

  void filterData() {
    if (forecastMap != null) {
      todayData = forecastMap!.today;
      tomorrowData = forecastMap!.tomorrow;
      todayForecastSave = todayData ?? [];
      tomorrowForecastSave = tomorrowData ?? [];
    }
  }

  //for wind speed conversion
  double convertWindSpeedToKmh(double speedInMs) {
    return speedInMs * 3.6;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator(color: primaryColorNav));
    }

    if (weatherData == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Failed to load weather data",
              style: TextStyle(color: primaryColor, fontSize: 16),
            ),
            SizedBox(height: 20),
            IconButton(
              onPressed: () {
                checkPermissionAndGetData();
              },
              icon: Icon(Icons.refresh, color: primaryColor, size: 30),
            ),
          ],
        ),
      );
    }

    DateTime now = DateTime.now();
    String formattedDateTime = DateFormat('dd MMM').format(now);
    String getDayName() {
      final days = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
      ];
      return days[DateTime.now().weekday - 1];
    }

    String dayName = getDayName();
    double windSpeedKmh = 0;
    if (weatherData != null) {
      double windSpeedMs = weatherData!.wind!.speed;
      windSpeedKmh = convertWindSpeedToKmh(windSpeedMs);
      if (weatherData!.weather != null) icon = weatherData!.weather!.first.id;
    }

    return RefreshIndicator(
      color: primaryColorNav,
      onRefresh: toRefreshData,
      child: SingleChildScrollView(
        // padding: EdgeInsets.all(20),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  // decoration: BoxDecoration(border: Border.all()),
                  height: 80,
                  width: 80,
                  child: Image.asset('assets/logo.png', fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (!isConnection)
                      Center(
                        child: Text(
                          "No internet. Displaying last fetched data.",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.mapPin,
                                  color: primaryColor,
                                  size: 15,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '${weatherData!.name}, ${weatherData!.sys?.country}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '    $dayName, $formattedDateTime',
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 30),
                    Container(
                      // decoration: BoxDecoration(border: Border.all()),
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 20,
                        top: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // margin: EdgeInsets.only(top: 40),
                                // decoration: BoxDecoration(border: Border.all()),
                                child: Text(
                                  '${weatherData!.main!.temp!.toInt()}°',
                                  style: TextStyle(
                                    fontSize: 70,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                // decoration: BoxDecoration(border: Border.all()),
                                child: Text(
                                  '${weatherData!.weather?.first.main}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    // fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            // decoration: BoxDecoration(border: Border.all()),
                            child: Icon(
                              getWeatherIcon(icon ?? 0),
                              color: primaryColor,
                              size: 100,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    /// Weather details row
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            weatherInfoBox(
                              WeatherIcons.strong_wind,
                              '${windSpeedKmh.toInt()} km/h',
                              'Wind',
                            ),
                            weatherInfoBox(
                              WeatherIcons.humidity,
                              '${weatherData!.main!.humidity}%',
                              'Humidity',
                            ),
                            weatherInfoBox(
                              WeatherIcons.fog,
                              '${weatherData!.visibility! ~/ 1000} km',
                              'Visibility',
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 20,
                      ),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today's forcast",
                            style: TextStyle(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 104, 156, 199),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Wrap(
                              spacing: 25,
                              runSpacing: 20,
                              children:
                                  (todayData ?? []).map((forecast) {
                                    return forecastInfoBox(
                                      time: forecast.time,
                                      icon: getWeatherIcon(forecast.weatherId),
                                      temp: forecast.temp,
                                    );
                                  }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 20,
                      ),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Tomorrow's forcast",
                            style: TextStyle(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 104, 156, 199),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Wrap(
                              spacing: 25,
                              runSpacing: 20,
                              children:
                                  (tomorrowData ?? []).map((forecast) {
                                    return forecastInfoBox(
                                      time: forecast.time,
                                      icon: getWeatherIcon(forecast.weatherId),
                                      temp: forecast.temp,
                                    );
                                  }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 20,
                        bottom: 20,
                      ),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        ForecastScreen(data: forecastMap),
                              ),
                            );
                          },
                          child: Text(
                            "See forecast for next 5 days?",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              decoration:
                                  TextDecoration.underline, // underline it
                              decorationColor: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget forecastInfoBox({
    required String time,
    required IconData icon,
    required double temp,
  }) {
    return Column(
      children: [
        Text(time, style: TextStyle(fontSize: 12, color: primaryColor)),
        Padding(
          padding: EdgeInsets.all(8),
          child: Icon(icon, size: 30, color: primaryColor1),
        ),
        Text(
          "${temp.toStringAsFixed(0)}°",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget imageIcon(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0), // No extra padding
      child: Image.network(
        image,
        height: 140,
        width: 180,
        filterQuality: FilterQuality.high, // Makes the icon sharper
        fit: BoxFit.cover, // Removes extra white space
      ),
    );
  }
}
