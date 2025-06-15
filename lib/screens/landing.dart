import 'package:cropmet/models/cities.dart';
import 'package:cropmet/models/const.dart';
import 'package:cropmet/screens/main_screen.dart';
import 'package:cropmet/screens/search.dart';
import 'package:cropmet/screens/weather_station.dart';
import 'package:cropmet/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Landing extends StatefulWidget {
  final int pageIndex;
  const Landing({super.key, required this.pageIndex});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _selectedIndex = 0;
  final Map<int, GlobalKey<NavigatorState>> _navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
  };

  late List<Widget> _pagesList;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.pageIndex;

    // Only initialize once here
    _pagesList = [
      MainScreen(key: _navigatorKeys[0]),
      Search(key: _navigatorKeys[1]),
      WeatherStation(key: _navigatorKeys[2]),
    ];

    loadCityList().then((cities) {
      setState(() {
        allCities = cities;
      });
    });
  }

  // Define a list of icons for the BottomNavigationBar
  final List<Map<String, IconData>> _icons = [
    {"outlined": MdiIcons.homeOutline, "filled": MdiIcons.home},
    {"outlined": MdiIcons.magnify, "filled": MdiIcons.magnify},
    {"outlined": MdiIcons.compassOutline, "filled": MdiIcons.compass},
  ];

  // Define a list of page titles for each tab
  final List<String> _titles = ['Home', 'Search', 'Station'];

  // // Define a list of corresponding pages for each tab
  // List<Widget> _pages() => [
  //   MainScreen(key: _navigatorKeys[0]),
  //   Search(key: _navigatorKeys[1]),
  //   WeatherStation(key: _navigatorKeys[2]),
  // ];
  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      _navigatorKeys[index]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          if (_selectedIndex == 0)
            Positioned.fill(
              child: Image.asset('assets/bg.png', fit: BoxFit.cover),
            )
          else
            // White background for other screens
            Container(color: bodyBackgroundColor),
          SafeArea(child: _pagesList[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color:
                _selectedIndex == 0 ? bgNav.withOpacity(0.9) : primaryColorNav,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              selectedItemColor: primaryColor,
              unselectedItemColor: _selectedIndex == 0 ? Colors.grey : bgNav,
              selectedIconTheme: const IconThemeData(
                size: 26,
                color: primaryColor,
              ),
              unselectedIconTheme: IconThemeData(
                size: 22,
                color: _selectedIndex == 0 ? Colors.grey : bgNav,
              ),
              selectedLabelStyle: const TextStyle(
                fontSize: 12,
                color: primaryColor,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: List.generate(
                _icons.length,
                (index) => BottomNavigationBarItem(
                  icon: Icon(
                    _selectedIndex == index
                        ? _icons[index]["filled"]
                        : _icons[index]["outlined"],
                  ),
                  label: _titles[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
