import 'package:crop_met/screens/ai.dart';
import 'package:crop_met/theme/colors.dart';
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
                Image.asset(
                  'assets/cropmet.png',
                  width: 200,
                  height: 200,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigation() {
    // Navigate to HomePage after 3 seconds, ensuring context is valid
    Future.delayed(Duration(seconds: 3), () {
      // Check if the widget is still mounted before using context
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage()), // Your homepage widget
        );
      }
    });
  }
}
