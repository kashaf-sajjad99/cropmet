import 'package:cropmet/apis/api_requests.dart';
import 'package:cropmet/components/custom_searchbar.dart';
import 'package:cropmet/components/display_box.dart';
import 'package:cropmet/components/notification.dart';
import 'package:cropmet/models/cities.dart';
import 'package:cropmet/models/const.dart';
import 'package:cropmet/models/current_weather_model.dart';
import 'package:cropmet/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:weather_icons/weather_icons.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading = false;
  CurrentWeather? weatherData;
  int? icon;
  TextEditingController searchController = TextEditingController();
  City? selectedCity;
  List<City> filteredCities = [];
  bool showSuggestions = false;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    // setState(() {
    //   weatherData = getDummyWeather(dummyJson);
    //   icon = weatherData!.weather!.first.id;
    //   selectedCity = City(
    //     id: 12,
    //     name: "Tokyo",
    //     country: "Japan",
    //     lat: 0.0,
    //     lon: 0.0,
    //   );
    // });
  }

  void filterCities(String query) {
    final lower = query.toLowerCase();
    setState(() {
      filteredCities =
          allCities.where((city) {
            return city.name.toLowerCase().contains(lower) ||
                city.country.toLowerCase().contains(lower);
          }).toList();
    });
  }

  void onSuggestionTap(City city) {
    searchController.text = '${city.name}, ${city.country}';
    setState(() {
      selectedCity = city;
      filteredCities = [];
    });
  }

  void onSearch() async {
    if (selectedCity != null) {
      bool hasInternet = await InternetConnection().hasInternetAccess;
      bool res = false;
      if (hasInternet) {
        res = await getData();
      } else {
        showBottomSnackBar(context, "No internet connection!");
      }
      if (res) searchController.clear();
    } else {
      showBottomSnackBar(context, "No city selected!");
    }
  }

  void onSearchTextChanged(String query) {
    if (query.isNotEmpty) {
      setState(() {
        showSuggestions = true;
        filterCities(query); // update filteredCities list here
      });
    } else {
      setState(() {
        showSuggestions = false;
        selectedCity = null;
        filteredCities.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    const imageWidth = 250.0;
    double windSpeedKmh = 0;
    if (weatherData != null) {
      double windSpeedMs = weatherData!.wind!.speed;
      windSpeedKmh = convertWindSpeedToKmh(windSpeedMs);
    }

    if (isLoading) {
      return Center(child: CircularProgressIndicator(color: primaryColorNav));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            showSuggestions = false;
          });
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Stack(
            children: [
              // Top Image with fade at bottom 10% of it
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: screenHeight * 0.3,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.9,
                        child: Image.asset(
                          'assets/search_map.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Gradient fade overlay bottom 10% of image container height
                  ],
                ),
              ),

              // Search bar - centered hint text and icon fix
              Positioned(
                top: 90,
                left: (screenWidth - imageWidth) / 2,
                child: Column(
                  children: [
                    SizedBox(
                      width: imageWidth,
                      child: CustomSearchBar(
                        hintText: 'Search city',
                        controller: searchController,
                        onChanged: onSearchTextChanged,
                        onSearch: onSearch,
                      ),
                    ),
                    if (filteredCities.isNotEmpty && showSuggestions)
                      Container(
                        color: Colors.white,
                        height: 150,
                        width: 250,
                        child: ListView.builder(
                          itemCount: filteredCities.length,
                          itemBuilder: (context, index) {
                            final city = filteredCities[index];
                            return ListTile(
                              title: Text('${city.name}, ${city.country}'),
                              onTap: () => onSuggestionTap(city),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),

              // Bottom image - no changes
              weatherData == null
                  ? Positioned(
                    top: 300,
                    left: (screenWidth - imageWidth) / 2,
                    child: Image.asset(
                      'assets/search_bg.jpg',
                      width: 250,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  )
                  : Positioned(
                    top: 280,
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // decoration: BoxDecoration(border: Border.all()),
                        padding: EdgeInsets.only(
                          left: 50,
                          right: 50,
                          bottom: 10,
                          top: 10,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.close, color: primaryColor),
                                  onPressed: () {
                                    setState(() {
                                      weatherData = null;
                                      selectedCity = null;
                                      searchController.clear();
                                      filteredCities.clear();
                                      showSuggestions = false;
                                    });
                                  },
                                  padding: EdgeInsets.all(10.0),
                                ),
                              ],
                            ),
                            Text(
                              "${selectedCity!.name}, ${selectedCity!.country}",
                              style: TextStyle(
                                color: primaryColor1,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 30),
                            Row(
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
                                          fontSize: 60,
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
                                          fontSize: 14,
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
                                    size: 90,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),

                            /// Weather details row
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: bg,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                          ],
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> getData() async {
    if (selectedCity == null) return false;

    setState(() {
      isLoading = true;
      weatherData = null; // Optional: clear old data while fetching new one
    });

    try {
      final response = await ApiRequests.fetchWeather(
        selectedCity!.lat,
        selectedCity!.lon,
      );

      if (response != null) {
        setState(() {
          weatherData = response;
          icon = weatherData!.weather?.first.id ?? 0;
        });
        return true;
      } else {
        // You can show a toast/snackbar here
        showBottomSnackBar(context, "No weather data found for this city!");

        return false;
      }
    } catch (e) {
      showBottomSnackBar(context, "Error fetching weather data!");
      return false;
    } finally {
      setState(() {
        isLoading = false;
      });
      searchController.clear();
    }
  }

  double convertWindSpeedToKmh(double speedInMs) {
    return speedInMs * 3.6;
  }
}
