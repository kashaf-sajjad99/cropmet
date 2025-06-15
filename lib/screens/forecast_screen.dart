import 'package:cropmet/models/const.dart';
import 'package:cropmet/models/hourly_weather_model.dart';
import 'package:cropmet/theme/colors.dart';
import 'package:flutter/material.dart';

class ForecastScreen extends StatefulWidget {
  final ForecastModel? data;
  const ForecastScreen({super.key, required this.data});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  List<HourlyForecast> hourlyForecastDay0 = [];
  List<HourlyForecast> hourlyForecastDay1 = [];
  List<HourlyForecast> hourlyForecastDay2 = [];
  List<HourlyForecast> hourlyForecastDay3 = [];
  List<HourlyForecast> hourlyForecastDay4 = [];

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      setState(() {
        hourlyForecastDay0 = widget.data![0];
        hourlyForecastDay1 = widget.data![1];
        hourlyForecastDay2 = widget.data![2];
        hourlyForecastDay3 = widget.data![3];
        hourlyForecastDay4 = widget.data![4];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<int, String> days = getNextFiveDaysMap();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close, color: const Color.fromARGB(255, 0, 0, 0)),
          onPressed: () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.all(10.0),
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          "Hourly Forecast",
          style: TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body:
      // widget.data == null
      //     ? Center(
      //       child: Text(
      //         "No data available.",
      //         style: TextStyle(color: primaryColor, fontSize: 16),
      //       ),
      //     )
      //     :
      ListView(
        children: [
          ///today DAY 1
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: bgNav,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${days[0]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: hourlyForecastDay0.length,
                  itemBuilder: (context, index) {
                    final forecast = hourlyForecastDay0[index];
                    return foreCastRow(
                      forecast.time,
                      getWeatherIcon(forecast.weatherId),
                      forecast.temp,
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          ///tomorrow DAy 2
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: bgNav,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${days[1]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: hourlyForecastDay1.length,
                  itemBuilder: (context, index) {
                    final forecast = hourlyForecastDay1[index];
                    return foreCastRow(
                      forecast.time,
                      getWeatherIcon(forecast.weatherId),
                      forecast.temp,
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          ///day after tomorrow    DAY 3
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: bgNav,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${days[2]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: hourlyForecastDay2.length,
                  itemBuilder: (context, index) {
                    final forecast = hourlyForecastDay2[index];
                    return foreCastRow(
                      forecast.time,
                      getWeatherIcon(forecast.weatherId),
                      forecast.temp,
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          ///day after day after tomorrow DAY 4
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: bgNav,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${days[3]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: hourlyForecastDay3.length,
                  itemBuilder: (context, index) {
                    final forecast = hourlyForecastDay3[index];
                    return foreCastRow(
                      forecast.time,
                      getWeatherIcon(forecast.weatherId),
                      forecast.temp,
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          ///day after day after day after tomorrow DAY 5
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: bgNav,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${days[4]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: hourlyForecastDay4.length,
                  itemBuilder: (context, index) {
                    final forecast = hourlyForecastDay4[index];
                    return foreCastRow(
                      forecast.time,
                      getWeatherIcon(forecast.weatherId),
                      forecast.temp,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget foreCastRow(String time, IconData icon, double temp) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(color: bgNav),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(time, style: TextStyle(fontSize: 18, color: primaryColor)),
            Text(
              "${temp.toStringAsFixed(0)}°",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Icon(icon, size: 35, color: primaryColor1),
            ),
          ],
        ),
      ),
    );
  }
}
