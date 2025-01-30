import 'package:crop_met/apis/api_requests.dart';
import 'package:crop_met/models/current_weather_model.dart';
import 'package:crop_met/services/location_check.dart';
import 'package:crop_met/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CurrentWeather? weatherData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    LocationService.requestLocationPermission();
    getData();
  }

  Future<void> getData() async {
    Position? position = await LocationService.getUserLocation();
    if (position != null) {
      double latitude = position.latitude;
      double longitude = position.longitude;

      try {
        var fetchedData = await ApiRequests.fetchWeather(latitude, longitude);
        setState(() {
          weatherData = fetchedData;
          isLoading = false;
        });
      } catch (e) {
        print("Error fetching weather: $e");
        setState(() {
          isLoading = false;
        });
      }
    } else {
      print("Failed to get location.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text("Failed to get location. Unable to fetch weather data.")),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  //for wind speed conversion
  double convertWindSpeedToKmh(double speedInMs) {
    return speedInMs * 3.6;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (weatherData == null) {
      return Scaffold(
        body: Center(
          child: Text("Failed to load weather data"),
        ),
      );
    }
    DateTime now = DateTime.now();

    // Format the date and time
    String formattedDateTime = DateFormat('dd MMM').format(now);

    //converted speed
    double windSpeedMs = weatherData!.wind!.speed;
    double windSpeedKmh = convertWindSpeedToKmh(windSpeedMs);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Makes the image cover the full screen
        children: [
          // Background Image
          Image.asset(
            'assets/bg2.jpg',
            fit: BoxFit.cover,
          ),

          // location
          Positioned(
            top: 30,
            left: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  MdiIcons.mapMarker,
                  color: secondaryColor,
                  size: 16,
                ),
                Text(
                  '${weatherData!.name}, ${weatherData!.sys?.country}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // date today
          Positioned(
            top: 60,
            left: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today, $formattedDateTime',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // main weather
          Positioned(
            top: 100,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${weatherData!.weather?.first.main}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          //description of weather
          Positioned(
            top: 130,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${weatherData!.weather?.first.description}',
                  style: TextStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          //main degree temperature
          Positioned(
            top: 100,
            right: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${weatherData!.main!.temp!.toInt()}',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  MdiIcons.temperatureCelsius,
                  color: secondaryColor,
                ),
              ],
            ),
          ),

          //min & max temperature

          Positioned(
            top: 160,
            right: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  MdiIcons.arrowUpThin,
                  color: secondaryColor,
                  size: 18,
                ),
                Text(
                  '${weatherData!.main!.tempMax!.toInt()}°',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  MdiIcons.arrowDownThin,
                  color: secondaryColor,
                  size: 18,
                ),
                Text(
                  '${weatherData!.main!.tempMin!.toInt()}°',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          //humidity, wind, visibilty, extra info
          Positioned(
            top: 200,
            right: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Wind",
                        style: TextStyle(color: secondaryColor, fontSize: 16),
                      ),
                      Text(
                        '${windSpeedKmh.toInt()} km/h',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   width: 10,
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Humidity",
                        style: TextStyle(color: secondaryColor, fontSize: 16),
                      ),
                      Text(
                        '${weatherData!.main!.humidity}%',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   width: 5,
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Feels like",
                        style: TextStyle(color: secondaryColor, fontSize: 16),
                      ),
                      Text(
                        '${weatherData!.main!.feelsLike!.toInt()}°',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   width: 5,
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Visibility",
                        style: TextStyle(color: secondaryColor, fontSize: 16),
                      ),
                      Text(
                        '${weatherData!.visibility! ~/ 1000} km',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
