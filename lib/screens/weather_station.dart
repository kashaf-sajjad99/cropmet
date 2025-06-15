import 'package:cropmet/components/weather_stations_display.dart';
import 'package:cropmet/theme/colors.dart';
import 'package:flutter/material.dart';

class WeatherStation extends StatefulWidget {
  const WeatherStation({super.key});

  @override
  State<WeatherStation> createState() => _WeatherStationState();
}

class _WeatherStationState extends State<WeatherStation> {
  int selectedIndex = 0;
  final List<String> tabs = ['Faisalabad', 'TT Singh', 'Okara', 'Burewala'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Weather Stations',
          style: TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(tabs.length, (index) {
              final isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  // margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 87,
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColorNav : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow:
                        isSelected
                            ? [
                              BoxShadow(
                                color: primaryColorNav.withOpacity(0.4),
                                blurRadius: 6,
                              ),
                            ]
                            : [],
                  ),
                  child: Center(
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        color: isSelected ? primaryColor : Colors.black87,
                        // fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          Expanded(
            child: Center(
              child: WeatherStationsDisplay(tab: tabs[selectedIndex]),
            ),
          ),
        ],
      ),
    );
  }
}
