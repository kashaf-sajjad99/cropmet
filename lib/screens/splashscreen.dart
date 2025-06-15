import 'package:cropmet/screens/landing.dart';
import 'package:cropmet/screens/starter_screen.dart';
import 'package:cropmet/services/shared_prefrence.dart';
import 'package:cropmet/theme/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to HomePage after 3 seconds
    navigation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/cropmet.png', width: 200, height: 200),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigation() async {
    bool isFirstTime = await PreferencesHelper.isFirstTime();
    if (isFirstTime) {
      Future.delayed(Duration(seconds: 3), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => StarterScreen()),
          );
        }
      });
    } else {
      // Navigate to HomePage after 3 seconds, ensuring context is valid
      Future.delayed(Duration(seconds: 3), () {
        // Check if the widget is still mounted before using context
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Landing(pageIndex: 0),
            ), // Your homepage widget
          );
        }
      });
    }
  }
}
